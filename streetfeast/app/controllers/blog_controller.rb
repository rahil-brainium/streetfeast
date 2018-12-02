class BlogController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    if blog_params[:title].present? && blog_params[:content].present?
      @blog  = Blog.create(blog_params)
      if blog_params[:fullname].nil?
        @blog.fullname = "Annonymus"
      end
      if blog_params[:email].nil?
        @blog.email = "Annonymus"
      end
      @blog.is_reviewed = false
      @blog.is_blocked = false
      @blog.save
      if params[:blog][:picture].nil?
        redirect_to :back
        flash[:notice]= "Blog has been created successfully!"
      else
        params[:blog][:picture][:avatar].each do |c|
          Picture.create(:avatar=> c,:blog_id => @blog.id)
        end
        flash[:notice]= "Blog has been created successfully!"
        redirect_to :back
      end
    else
      flash[:notice] = "Title and Content are mandatory!!"
      redirect_to :back
    end
  end

  def new
    @blog = Blog.new
    @picture = Picture.new
  end

  def create_blog_user
    if blog_params[:title].present? && blog_params[:content].present?
      @blog  = Blog.create(blog_params)
      @blog.user_id = current_user.id
      @blog.fullname = current_user.fullname
      @blog.email = current_user.email
      @blog.is_reviewed = false
      @blog.is_blocked = false
      @blog.save
      unless params[:blog][:picture].nil?
        params[:blog][:picture][:avatar].each do |c|
          Picture.create(:avatar=> c,:blog_id => @blog.id)
        end
      end
      if current_user.is_admin == true
        flash[:notice]= "Blog has been created successfully!"
        redirect_to dashboard_path
      else
        flash[:notice]= "Blog has been created successfully!"
        redirect_to home_dashboard_user_path
      end
    else
      redirect_to :back
      flash[:notice] = "Title and Content are mandatory!!"
    end
  end

  def update_blog_user
    if blog_params[:title].present? && blog_params[:content].present?
      @blog = Blog.find_by_id(params[:id])
      @blog.update_attributes(blog_params)
      @blog.user_id = current_user.id
      @blog.save
      unless params[:blog][:picture].nil?
        params[:blog][:picture][:avatar].each do |c|
          Picture.create(:avatar=> c,:blog_id => @blog.id)
        end
      end
      if current_user.is_admin == true
        flash[:notice]= "Blog details successfully updated!"
        redirect_to :back
      else
        flash[:notice]= "Blog details successfully updated!"
        redirect_to :back
      end
    else
      redirect_to :back
      flash[:notice] = "Title and Content are mandatory!!"
    end  
  end

  def edit
    @blog = Blog.find_by_id(params[:id])
    if @blog.present?
      if @blog.is_reviewed.eql? false
        @blog.is_reviewed = true
        @blog.save
      end
      @picture = Picture.new
    end
    render partial: "edit"
  end

  def update
    @blog = Blog.find_by_id(params[:id])
    @blog.update_attributes(blog_params)
    render json: @blog
  end

  def add_picture_to_blog
    picture = params[:pic].to_jsons
    render text: "uploaded"
  end


  def show
    @blog = Blog.find_by_id(params[:id])
    @picture = Picture.new
    if @blog.is_reviewed.eql? false
      @blog.is_reviewed = true
      @blog.save
    end
  end

  def index
     respond_to do |format|
      format.html
      format.json { render json: BlogDatatable.new(view_context) }
    end
  end

  private
  def blog_params
    params.require(:blog).permit(:title, :content,:email,:fullname)
  end

end
