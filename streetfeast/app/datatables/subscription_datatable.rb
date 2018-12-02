class SubscriptionDatatable
  delegate :params,:link_to,:check_box_tag, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Subscription.count,
      iTotalDisplayRecords: Subscription.count,
      aaData: data
    }
  end

  private

  def data
    subscriptions.map do |subscription|
      [ 
        check_box_tag("subscription",subscription.id, false, :id =>"sc_#{subscription.id}" ,:class=>"is_checked_subscription","data-id"=>"#{subscription.id}"),
        subscription.user_email
      ]
    end
  end

  def subscriptions
    @subscriptions ||= fetch_subscriptions
  end

  def fetch_subscriptions
    @subscriptions = Subscription.order("#{sort_column} #{sort_direction}")
  end
 
 def page
    params[:start].to_i/per_page + 1
  end
  def per_page
    params[:length].to_i > 0 ? params[:length].to_i : 10
  end

  def sort_column
    columns = %w[id user_email]
    columns[params[:order]['0'][:column].to_i]
  end

  def sort_direction
    params[:order]['0'][:dir] == "desc" ? "asc" : "desc"
  end
end
