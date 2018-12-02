class UserDatatable
  delegate :params,:link_to, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: User.count,
      iTotalDisplayRecords: User.count,
      aaData: data
    }
  end

private

  def data
    users.map do |user|
      [ 
        "<a href='/user/#{user.id}/edit'>#{user.fullname}</a>",
        user.email,
        user.mobile_no,
        user.city,
        user.state,
        user.blogs.count,
        "<a href='/user/#{user.id}/edit'><span  class='user_edit' style='cursor: pointer;'><img id='#{user.id}edit' src='/assets/edit_icon.png' class='user_edit' style ='height:20px;width:20px;'></span></a>",
        "<span class='user_ban' style='cursor: pointer;'><img id='#{user.id}ban' data-id='#{user.id}' src='/assets/ban_icon.png' class=\"#{user.is_blocked == true ? 'unblock' : 'block' } is_block_test\" style ='height:20px;width:20px;'></span>"
      ]
    end
  end

  def users
    @users ||= fetch_users
  end

  def fetch_users
    @users = User.order("#{sort_column} #{sort_direction}")
    if params[:is_blocked].eql? "true"
      @users = User.where("is_blocked=?",true)
    end
    if params[:is_blocked].eql? "false"
      @users = User.where("is_blocked=?",false)
    end
    @users = @users.page(page).per_page(per_page)
    @users
  end
 
  def page
    params[:start].to_i/per_page + 1
  end
  def per_page
    params[:length].to_i > 0 ? params[:length].to_i : 10
  end

  def sort_column
    columns = %w[fullname email mobile_no city state]
    columns[params[:order]['0'][:column].to_i]
  end

  def sort_direction
    params[:order]['0'][:dir] == "desc" ? "asc" : "desc"
  end
end
