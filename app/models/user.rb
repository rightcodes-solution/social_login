class User < ApplicationRecord


  has_many :providers

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:facebook, :google_oauth2, :twitter, :github, :linkedin, :instagram_graph]

  def self.create_from_provider_data(provider_data)
    email = provider_data.info.email ? provider_data.info.email : "#{provider_data.info.name}@instagram.com"
    name = provider_data.info.name
    password = Devise.friendly_token[0, 20]
    self.create(email: email, password: password,name: name)
  end

  def devise_mapping
    Devise.mappings[:user]
  end

  def resource_name
    devise_mapping.name
  end

  def resource_class
    devise_mapping.to
  end

end
