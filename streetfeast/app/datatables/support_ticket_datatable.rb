class SupportTicketDatatable
  delegate :params, :h, :link_to,:check_box_tag, :number_to_currency, to: :@view
  def initialize(view)
    @view = view
  end
  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: SupportTicket.count,
      iTotalDisplayRecords: SupportTicket.count,
      aaData: data
    }
  end
private
  def data
    support_tickets.map do |support_ticket|
      [ 
        support_ticket.is_resolved == true ?  "" : check_box_tag("support_ticket",support_ticket.id, false, :id =>"st_#{support_ticket.id}" ,:class=>"is_checked_resolved","data-id"=>"#{support_ticket.id}"),
        support_ticket.id,
        IssueType.find_by_id(support_ticket.issue_type_id).issue_type,
        support_ticket.issue_description,
        support_ticket.is_resolved == true ? "<img src='/assets/resolved_ticket.png' class='is_resolved_#{support_ticket.id}' style='height: 20px;width: 20px;'>" : "<img class='is_resolved_#{support_ticket.id}' style='height: 20px;width: 20px;display: none;'>",
        "<a href='javascript:void(0)' class='show_ticket' id='#{support_ticket.id}' 'data-toggle'='modal' 'data-target'='#myModal' 'data-remote'='true'><span><img src='/assets/issue.png' style ='height:20px;width:20px;cursor: pointer;'></span></a>"
      ]
    end
  end
  def support_tickets
    @support_tickets ||= fetch_support_tickets
  end
  def fetch_support_tickets
    @support_tickets = SupportTicket.order("#{sort_column} #{sort_direction}")
    if params[:search][:value].present?
      @support_tickets = SupportTicket.where("issue_description like :search", search: "%#{params[:search][:value]}%")
    end
    if params[:is_resolved].present?
      if params[:is_resolved].eql? "resolved"
        @support_tickets = SupportTicket.where("is_resolved=?",true)
      end
      if params[:is_resolved].eql? "not resolved"
        @support_tickets = SupportTicket.where("is_resolved=?",false)
      end
    end
    @support_tickets = @support_tickets.page(page).per_page(per_page)
    @support_tickets
  end

  def page
    params[:start].to_i/per_page + 1
  end

  def per_page
    params[:length].to_i > 0 ? params[:length].to_i : 10
  end

  def sort_column
    columns = %w[id id issue_description issue_description]
    columns[params[:order]['0'][:column].to_i]
  end

  def sort_direction
    params[:order]['0'][:dir] == "desc" ? "asc" : "desc"
  end
end