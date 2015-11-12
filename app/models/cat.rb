class Cat < ActiveRecord::Base
  COLORS = ["brown", "black", "white", "orange", "tabby"]
  validates :birth_date, :color, :name, :sex, :description, :presence => true
  validates :color, inclusion: COLORS
  validates :sex, inclusion: { in: ["M", "F"],
    message: "%{value} is not a valid sex" }

  has_many :cat_rental_requests, dependent: :destroy

  def age
    #current date - birth_date
  end
end
