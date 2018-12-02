class BlogDatatable

 
   delegate :params,:link_to, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Blog.count,
      iTotalDisplayRecords: Blog.count,
      aaData: data
    }
  end
  private

  def data
    blogs.map do |blog|
      [ 
        blog.id,
        "<div onclick='show(#{blog.id})' style='cursor:pointer;' class='blog_title_#{blog.id}'>#{blog.title}</div>",
        "<div class='blog_content_#{blog.id}'>#{blog.content.truncate(30).html_safe}<div>",
        blog.user_id.present? ? blog.user.email : blog.email,
        blog.pictures.count,
        blog.created_at,
        blog.updated_at,
        "<a href='javascript:void(0)' class='blog_edit' id='#{blog.id}' 'data-toggle'='modal' 'data-target'='#myModal' 'data-remote'='true'><span><img src='/assets/edit_icon.png' style ='height:20px;width:20px;cursor: pointer;'></span></a>"  
      ]
    end
  end
  def blogs
    @blogs ||= fetch_blogs
  end
  def fetch_blogs
    @blogs = Blog.order("#{sort_column} #{sort_direction}")
    if params[:is_reviewed].present?
      if params[:is_reviewed].eql? "true"
        @blogs = Blog.where("is_reviewed=?",true)
      else
        @blogs = Blog.where("is_reviewed=?",false)
      end
    end
    if params[:is_blocked].present?
      if params[:is_blocked].eql? "true"
        @blogs = Blog.where("is_blocked=?",true)
      else
        @blogs = Blog.where("is_blocked=?",false)
      end
    end
    @blogs = @blogs.page(page).per_page(per_page)
    @blogs
  end
  def page
    params[:start].to_i/per_page + 1
  end

  def per_page
    params[:length].to_i > 0 ? params[:length].to_i : 10
  end

  def sort_column
    columns = %w[id title content user_id pictures created_at updated_at]
    columns[params[:order]['0'][:column].to_i]
  end

  def sort_direction
    params[:order]['0'][:dir] == "desc" ? "asc" : "desc"
  end
end
