class ProvidersController < ApplicationController
  before_action :authenticate_user!

  def index
    @providers = current_user.providers
  end

  def destroy
    @provider = Provider.find(params[:id])
    if @provider && @provider.destroy
      redirect_to providers_path, alert: 'Disconnected'
    else
      redirect_to providers_path, alert: 'can not be disconnected'
    end
  end
end
