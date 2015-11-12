class CatRentalRequest < ActiveRecord::Base
  STATUS = ["PENDING", "APPROVED", "DENIED"]
  validates :cat_id, :start_date, :end_date, :status, presence: true
  validates :status, inclusion: STATUS
  validate :non_overlapping_requests
  validate :start_date_before_end_date

  belongs_to :cat

  def overlapping_requests
    CatRentalRequest
      .where("(id is NUll) OR (id != :id)", id: self.id)
      .where(cat_id: cat_id)
      .where(<<-SQL, start_date: start_date, end_date: end_date)
      NOT( (start_date > :end_date) OR (end_date < :start_date) )

    SQL
  end

  def approved_overlapping_requests
    overlapping_requests.where("status = 'APPROVED'")
  end

  def overlapping_pending_requests
    overlapping_requests.where("status = 'PENDING'")
  end

  def approve!
    raise "not pending" unless self.status == "PENDING"
    transaction do
      self.status = "APPROVED"
      self.save!

      overlapping_pending_requests.update_all(status: "DENIED")
    end
  end

  def deny!
    self.status = "DENIED"
    self.save!
  end

  def pending?
    self.status == "PENDING"
  end

  def non_overlapping_requests
    return if self.status == "DENIED"

    unless approved_overlapping_requests.empty?
      errors[:base] <<
        "Request conflicts with existing approved request"
    end
  end

  def start_date_before_end_date
    return if start_date < end_date
    errors[:start_date] << "must come before end date"
    errors[:end_date] << "must come after start date"
  end

end
