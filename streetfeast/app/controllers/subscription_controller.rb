class SubscriptionController < ApplicationController
  def new
    email = params[:email]
    Subscription.create(:user_email=>email)
    render text: "success"
  end
  def index
  	respond_to do |format|
      format.html
      format.json { render json: SubscriptionDatatable.new(view_context) }
    end
  end

  # def send_newsletter
  #   subscription_ids = params[:user_ids]
  #   random_id = rand(Blog.count)
  #   random_record = Blog.first(:conditions => ["id >= ?", random_id])

  #   subscription_ids.each do |subscription_id|
  #     subscription = Subscription.where("id=?",subscription_id).first
  #     UserMailer.email_newsletter(subscription.user_email,random_record).deliver
  #   end
  #   render text: "success"
  # end


  def send_newsletter
    subscription_ids = params[:user_ids]
    subscription_ids.each do |subscription_id|
      subscription = Subscription.where("id=?",subscription_id).first
      UserMailer.email_newsletter(subscription.user_email).deliver
    end
    render text: "success"
  end

end
