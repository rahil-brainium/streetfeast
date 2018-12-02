class MenuController < ApplicationController
skip_before_action :verify_authenticity_token
  def show
    @restaurant = Restaurant.find_by_id(params[:id])
    @menu_for_restaurant = Menu.where("restaurant_id=?",@restaurant.id)
    @menu = Menu.new
    render partial: "menu_list"
  end

  def create
    @restaurant = Restaurant.find_by_id(params[:id])
    @menu_for_restaurant = Menu.where("restaurant_id=?",@restaurant.id)
    menu_item_name = params[:menu_item_name]
    menu_item_price = params[:menu_item_price]
    restaurant_id = @restaurant.id
    menu_item_name.keys.each_with_index do |key, index|
      item_name = menu_item_name.values[index]
      item_price = menu_item_price.values[index]
      Menu.create(:item_name=>item_name,:price=>item_price,:restaurant_id=>restaurant_id)
    end
    @menu = Menu.new
    render partial: "menu_list"
  end

  def is_available
    @menu = Menu.find_by_id(params[:id])
    if @menu.is_available.eql? true
      @menu.update_attribute(:is_available,false)
    else
      @menu.update_attribute(:is_available,true)
    end
    render text: "success"
  end

  def edit_price
    @menu = Menu.first(conditions: ["id = ?", params[:menu_id]])
    @menu.update_attribute(:price,params[:price])
    render json: @menu
  end

end
