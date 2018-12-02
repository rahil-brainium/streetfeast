class HomeController < ApplicationController
  before_filter :authenticate_user!, only: [:dashboard]
  skip_before_action :verify_authenticity_token

  def index
    @blog = Blog.new
    @picture = Picture.new
    @blogs = Blog.where("is_reviewed =?",true)
  end

  def analytics
  end

  def under_construction
    render layout: false
  end

  def dummy_homepage
    render layout: false
  end

  def dashboard
  	respond_to do |format|
      format.html 
      format.js   
    end
  end

  def dashboard_admin
  end
  
  def blog_list
    @blogs = Blog.all
    render partial: "blog_list"
  end

  def blacklist
    user_id=params[:pt]
    user=User.find(user_id.to_i)
    user.update(:is_blocked => true)

    respond_to do |format|
     format.js { render nothing: true}
    end 
  end

  def undo_blacklist
    user_id=params[:pt]
    user=User.find(user_id.to_i)
    user.update(:is_blocked => false)

    respond_to do |format|
     format.js { render nothing: true}
    end 
  end
  def new_sms
  end

  def send_sms
    number = params[:sms_user][:mobile_number]
    if number.length < 10 || number.length >10
      flash[:notice]="Enter correct number"
      redirect_to :back
    else
      message = params[:sms_user][:message]
      User.send_sms(number,message)
      redirect_to dashboard_path
    end
  end
end
