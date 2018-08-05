class ApplicationController < ActionController::Base

  #pundit
  include Pundit
  # manages pundit erros
  rescue_from Pundit: :NoAuthorizedError, with: :user_not_authorized


  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
 
  #set layput
  layout :layout_by_resource
  
  protected

  def layout_by_resource
    if devise_controller? && resource_name == :admin
      "backoffice_devise"
    else
      "application"
    end
  end

  def user_not_authorized
    flash[:alert] = "voce nao tem autorizaçao para executar essa açao."
    redirect_to(request.referrer|| root_path)
  end
end
