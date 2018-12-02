class RestaurantController < ApplicationController

  def new 
    @blog_id=params[:id]
    @restaurant = Restaurant.new
    @address = @restaurant.addresses.build
    @menu = Menu.new
    render partial: "new"
  end

  def create
    @restaurant = Restaurant.where("associated_blogs LIKE ?","%#{params[:blog_id]}%")
    if @restaurant.nil?
      params[:restaurant][:is_blacklisted] = false
      @restaurant = Restaurant.create(restaurant_params)
      @restaurant.update_attribute(:associated_blogs,params[:blog_id])
      menu_item_name = params[:menu_item_name]
      menu_item_price = params[:menu_item_price]
      restaurant_id = @restaurant.id
      if params[:menu_item_name].present? && params[:menu_item_price].present?
        menu_item_name.keys.each_with_index do |key, index|
          item_name = menu_item_name.values[index]
          item_price = menu_item_price.values[index]
          if item_name.present? && item_price.present?
            Menu.create(:item_name=>item_name,:price=>item_price,:restaurant_id=>restaurant_id)
          end
        end
      end
      if params[:restaurant][:address][:address_line].present? && params[:restaurant][:address][:latitude].present? && params[:restaurant][:address][:longitude].present?
        @address = Address.create(:address_line => params[:restaurant][:address][:address_line],:latitude =>params[:restaurant][:address][:latitude],:longitude=>params[:restaurant][:address][:longitude],:restaurant_id=>@restaurant.id)
      end
      flash[:notice] = "Restaurant has been created successfully!"
      redirect_to :back
    else
      flash[:notice] = "Restaurant already exists for this blog!"
      redirect_to :back
    end
  end

  def show
    @restaurant = Restaurant.find_by_id(params[:id])
    @pictures_res = @restaurant.pictures
    @menu_for_restaurant = Menu.where("restaurant_id=?",@restaurant.id)
    
  end


  def show_for_user
    @restaurant = Restaurant.find_by_id(params[:id])
    @pictures_res = @restaurant.pictures
  end

  def show_pic
    @picture = Picture.find_by_id(params[:id])
    if current_user.present?
      @like = Like.where("picture_id=?  and user_id =? and is_liked =?",@picture.id,current_user.id,true).first
    end
    if @like.present?
      render json: {pic: @picture.avatar, id: @picture.id, is_liked: true}
    else
      render json: {pic: @picture.avatar, id: @picture.id, is_liked: false}
    end
  end

  def address
    @address = Address.where("restaurant_id =?",params[:id]).first
    render json: {lat: @address.latitude,long: @address.longitude}
  end
  
  def update
    blog_ids=[]
    @restaurant = Restaurant.find_by_id(params[:id])
    if @restaurant.present?
      @restaurant_address = Address.where("restaurant_id=?",@restaurant.id).first
      if params[:restaurant][:address].present?
        restaurant_latitude = params[:restaurant][:address][:latitude]
        restaurant_longitude = params[:restaurant][:address][:longitude]
        restaurant_address_line = params[:restaurant][:address][:address_line]
        @restaurant_address.update_attribute(:latitude,restaurant_latitude)  
        @restaurant_address.update_attribute(:longitude,restaurant_longitude)  
        @restaurant_address.update_attribute(:address_line,restaurant_address_line)
        @restaurant_address.save
      end
      params[:restaurant][:associated_blogs].split(",").each do |check_blog_id|
        blog = Blog.where("id=?",check_blog_id).first
        if blog.present?
          blog_ids << blog.id
        end
      end
      params[:restaurant][:associated_blogs] = blog_ids.uniq.join(",")
      @restaurant.update_attributes(restaurant_params)
    end
    flash[:notice] = "Restaurant details has been updated successfully!"
    redirect_to :back      
  end
  def index
    respond_to do |format|
      format.html
      format.json { render json: RestaurantDatatable.new(view_context) }
    end
  end


 private
  def restaurant_params
    params.require(:restaurant).permit(:name,:cuisine,:cost_for_two,:contact_number, :description,:opening_time,:closing_time,:operator,:closed_on,:is_blacklisted,:is_deactive,:associated_blogs)
  end
end