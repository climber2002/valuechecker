# == Schema Information
#
# Table name: exchanges
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  abbreviation :string(255)
#  english_name :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#

class Exchange < ActiveRecord::Base

  validates :name, uniqueness: true, presence: true
  validates :abbreviation, uniqueness: true, presence: true
  validates :english_name, uniqueness: true, presence: true

  has_many :companies
end
