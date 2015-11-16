class Cat < ActiveRecord::Base
  COLORS = ["brown", "black", "white", "orange", "tabby"]
  attr_accessor :user_id
  validates :birth_date, :color, :name, :sex, :description, :user_id, :presence => true
  validates :color, inclusion: COLORS
  validates :sex, inclusion: { in: ["M", "F"],
    message: "%{value} is not a valid sex" }


  has_many :cat_rental_requests, dependent: :destroy
  belongs_to(
    :owner,
    :class_name: "User",
    foreign_key: :user_id
  )

  def age
    #current date - birth_date
  end
end
