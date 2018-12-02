class RestaurantDatatable

   delegate :params,:link_to, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Restaurant.count,
      iTotalDisplayRecords: Restaurant.count,
      aaData: data
    }
  end
  private

  def data
    restaurants.map do |restaurant|
      [ 
        "<span style='cursor:pointer' onclick='show(#{restaurant.id})'>#{restaurant.name}</span>",
        restaurant.contact_number,
        restaurant.operator,
        restaurant.cuisine,
        "<span>#{restaurant.opening_time}-#{restaurant.closing_time}</span>",
        restaurant.closed_on,
        restaurant.addresses.present? ? restaurant.addresses.first.address_line : "",
        restaurant.associated_blogs
      ]
    end
  end
   def restaurants
    @restaurants ||= fetch_restaurants
  end
  def fetch_restaurants
    @restaurants = Restaurant.order("#{sort_column} #{sort_direction}")
    if params[:search][:value].present?
      @restaurants = Restaurant.where("name like :search or operator like :search or contact_number like :search", search: "%#{params[:search][:value]}%")
    end
    if params[:cuisine].present?
      @restaurants=Restaurant.where("cuisine LIKE ?","%#{params[:cuisine]}%")
    end
    if params[:closed_on].present?
      @restaurants=Restaurant.where("closed_on LIKE ?","%#{params[:closed_on]}%")
    end
    if params[:is_blacklisted].present?
      if params[:is_blacklisted].eql? "true"
        @restaurants=Restaurant.where("is_blacklisted=?",true)
      end
      if params[:is_blacklisted].eql? "false"
        @restaurants=Restaurant.where("is_blacklisted=?",false)
      end
    end
    if params[:is_deactive].present?
      if params[:is_deactive].eql? "true"
        @restaurants=Restaurant.where("is_deactive=?",true)
      end
      if params[:is_deactive].eql? "false"
        @restaurants=Restaurant.where("is_deactive=?",false)
      end
    end
    @restaurants = @restaurants.page(page).per_page(per_page)
    @restaurants
  end
  def page
    params[:start].to_i/per_page + 1
  end

  def per_page
    params[:length].to_i > 0 ? params[:length].to_i : 10
  end

  def sort_column
    columns = %w[name name operator operator]
    columns[params[:order]['0'][:column].to_i]
  end

  def sort_direction
    params[:order]['0'][:dir] == "desc" ? "asc" : "desc"
  end
end
