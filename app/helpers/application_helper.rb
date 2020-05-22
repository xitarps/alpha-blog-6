module ApplicationHelper
  def gravatar_for(user, options = { size: 80 })
    hash = Digest::MD5.hexdigest(user.email)
    size = options[:size]
    image_src = "https://www.gravatar.com/avatar/#{hash}?s=#{size}"
    image_tag image_src, alt: user.username, class:"rounded shadow mx-auto d-block"
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end
end
