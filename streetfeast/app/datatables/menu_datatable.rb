class MenuDatatable
  delegate :params, :h, to: :@view

  def initialize(view)
    @view = view
  end
  def as_json(options = {})
    {

      sEcho: params[:sEcho].to_i,
      iTotalRecords: Menu.count,
      aaData: data
    }
  end

  private

  def data
    menus.map do |menu|
      [
        menu.item_name,
        menu.price
      ]
    end
  end

  def menus
    @menus ||= fetch_menus
  end

  def fetch_menus
    @restaurant = Restaurant.find(params[:id])
    menus = Menu.order("#{sort_column} #{sort_direction}")
    menus = menus.page(page).per_page(per_page)
    menus = Menu.where("restaurant_id=?",@restaurant.id)
    menus
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[item_name price]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "asc" : "desc"
  end
end