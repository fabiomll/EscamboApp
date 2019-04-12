class ApplicationController < ActionController::Base

  before_filter :store_current_location, :unless => :devise_controller?

  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  layout :layout_by_resource

  def layout_by_resource
    if devise_controller? && resource_name == :admin
      "backoffice_devise"
    elsif devise_controller? && resource_name == :member
      "site_devise"
    else
      "application"
    end
  end



  private

    def user_not_authorized
      flash[:alert] = "Você não pode executar essa ação"
      redirect_to(request.referrer || root_path)
    end


    # Its important that the location is NOT stored if:
    # - The request method is not GET (non idempotent)
    # - The request is handled by a Devise controller such as Devise::SessionsController as that could cause an
    #    infinite redirect loop.
    # - The request is an Ajax request as this can lead to very unexpected behaviour.
    #def storable_location?
      #request.get? && is_navigational_format? && !devise_controller? && !request.xhr?
    #end

    def store_current_location
      store_location_for(:member, request.url)
    end


end
