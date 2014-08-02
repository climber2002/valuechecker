class Company < ActiveRecord::Base

  validates :code, presence: true, uniqueness: true
  validates :name, presence: true, uniqueness: true
  validates :english_name, uniqueness: { allow_blank: true }

  belongs_to :exchange
  validates :exchange_id, presence: true
end
