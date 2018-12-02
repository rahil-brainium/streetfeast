class LikeController < ApplicationController
  def pic_like
    pic_id = params[:id]
    @pic_like = Like.where("picture_id=? and user_id =?",pic_id,current_user.id).first
    if @pic_like.present?
      if @pic_like.is_liked.eql? true
        @pic_like.update_attribute(:is_liked,false)
        render json: {pic_id: pic_id , is_liked: false}
      else
        @pic_like.update_attribute(:is_liked,true)
        render json: {pic_id: pic_id , is_liked: true}
      end
    else
      @like = Like.create(:user_id=>current_user.id,:picture_id => pic_id,:is_liked =>true)
      render json: {pic_id: pic_id , is_liked: true}
    end
  end
end
