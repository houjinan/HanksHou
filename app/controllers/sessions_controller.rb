class SessionsController < Devise::SessionsController

  def new
    super
    cache_referrer
  end


  private

  def cache_referrer
    referrer = request.referrer
    if referrer && referrer.include?(domain_or_host) && referrer.exclude?(new_user_session_path)
      session['user_return_to'] = request.referrer
    end
  end

  def domain_or_host
    request.domain || request.host
  end
end