class OmniauthController < ApplicationController

  def facebook
    redirect
  end

  def google_oauth2
    redirect
  end

  def twitter
    redirect
  end

  def github
    redirect
  end

  def linkedin
    redirect
  end

  def instagram_graph
    redirect
  end

  def failure
    redirect_to new_user_registration_url, error: 'There is a problem signing you in'
  end

  private

  def auth_hash
    request.env['omniauth.auth']
  end

  def redirect
    if registered_user.present?
      if user_signed_in?
        redirect_to providers_path
      else
        sign_in_and_redirect registered_user
      end
    else
      failure
    end
  end

  def registered_user
    user_hash = auth_hash.to_json
    email = auth_hash.info.email ? auth_hash.info.email : "#{auth_hash.info.name}@instagram.com"
    provider = Provider.find_by(uid: auth_hash.uid,provider: auth_hash.provider)
    if provider.present?
      user = provider.user
    else
      if user_signed_in?
        current_user.providers.find_or_create_by(name: auth_hash.provider, uid: auth_hash.uid, auth_hash: user_hash, access_token: auth_hash.credentials.token, email: email)
      else
        available_user = User.find_by(email: email)
        user = available_user.present? ? available_user : User.create_from_provider_data(auth_hash)
        user.providers.find_or_create_by(name: auth_hash.provider, uid: auth_hash.uid, auth_hash: user_hash, access_token: auth_hash.credentials.token, email: email)
      end
    end
    user
  end
end
