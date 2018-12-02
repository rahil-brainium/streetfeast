class Picture < ActiveRecord::Base
  belongs_to :blog
  has_many :likes
  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/assets/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/, :message => "Please upload only images!"
end
