class ApplicationController < ActionController::Base
  helper_method :logged_in?, :display_name?

	def log_in(user)
    	session[:user_id] = user.id
  	end

  	# Remembers a user in a persistent session.
	 def remember(user)
	    user.remember
	    cookies.permanent.signed[:user_id] = user.id
	    cookies.permanent[:remember_token] = user.remember_token
	 end

  	# Returns the user corresponding to the remember token cookie.
  def current_user
    if (user_id = session[:user_id])# notice "=" is not a comparism sign, the whole statement could be read as If session of user id exists (while setting user id to session of user id)
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  	# Returns true if the user is logged in, false otherwise.
  def logged_in?
    !current_user.nil?
  end

  # Forgets a persistent session.
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  # Logs out the current user.
  def log_out
  	forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

  # Forgets a persistent session.
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

	private
    # Confirms a logged-in user.
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end

  def display_name?
    if current_user == nil
      return false
    else
      return true
    end    
  end 

  # Redirects to stored location (or to the default).
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default) # This evaluates to session[:forwarding_url] unless it’s nil,
    session.delete(:forwarding_url)
  end

  # Stores the URL trying to be accessed.
  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end

end
