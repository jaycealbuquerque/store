class Backoffice::SendMailController < ApplicationController

  def edit
    @admin = Admin.find(params[:id])

    respond_to do |format|
      format.js
    end
  end

  def create
   	begin
   	 AdminMailer.send_message(current_admin, params[:'recipient-text'], params[:'subject-text'], params['message-text']).deliver_now
   	 @notify_message = "email enviado com sucesso"		 
   	 @notify_flag = "sucess"
   	rescue
   	 @notify_message = "erro ao enviar email"	
   	 @notify_flag = "error"
   	end 
    respond_to do |format|
      format.js
    end
  end

end