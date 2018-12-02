class SupportticketController < ApplicationController
  def new
    @support_ticket = SupportTicket.new
  end

  def index
    respond_to do |format|
      format.html
      format.json { render json: SupportTicketDatatable.new(view_context) }
    end
  end

  def show
    @support_ticket = SupportTicket.where("id=?",params[:id]).first
    render partial: 'supportticket/show'
  end


  def create
    if params[:support_ticket][:issue_type].present?
      issue_type_id = params[:support_ticket][:issue_type].to_i
      @support_ticket = SupportTicket.create(ticket_params)
      @support_ticket.update_attribute(:issue_type_id,issue_type_id)
      @support_ticket.save
      user_id = current_user.id
      @user = User.where("id=?",user_id)
      @support_ticket.update_attribute(:user_id,user_id)
      @support_ticket.save
      UserMailer.ticket_email_user(@user,@support_ticket).deliver
      UserMailer.ticket_email_admin(@user,@support_ticket).deliver
      flash[:notice] = "Ticket has been raised successfully.Please check you email for the Ticket ID"
    else
      flash[:notice] = "Please select Issue type"
    end
    redirect_to :back
  end

  def resolve
    issue_ids = params[:issue_ids]
    if issue_ids.present?
      issue_ids.each do |issue_id|
        @support_ticket = SupportTicket.where("id=?",issue_id).first
        @support_ticket.update_attribute(:is_resolved,true)
        @support_ticket.save
      end 
    render text: "success"
    else
      render text: "error"
    end
  end
 

  private
  def ticket_params
    params.require(:support_ticket).permit(:issue_description)
  end

end