class FeedbackController < ApplicationController
  skip_before_action :verify_authenticity_token
  def create

    feedback_form_field_array = params[:pt].split("@@@")

    feedback = Feedback.new
    feedback.description = feedback_form_field_array[0]
    feedback.rating = feedback_form_field_array[1]
    feedback.viewers_ip = feedback_form_field_array[2]
    feedback.viewers_city = feedback_form_field_array[3]
    feedback.viewers_region = feedback_form_field_array[4]
    feedback.viewers_country = feedback_form_field_array[5]
    feedback.viewers_continent = feedback_form_field_array[6]
    feedback.viewers_latitude = feedback_form_field_array[7]
    feedback.viewers_longitude = feedback_form_field_array[8]
    feedback.viewers_internet_service_provider = feedback_form_field_array[9]
    feedback.save
    respond_to do |format|
      format.js {render :nothing => true}
    end
  end
end
