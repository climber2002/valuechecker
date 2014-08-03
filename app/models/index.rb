# == Schema Information
#
# Table name: indices
#
#  id           :integer          not null, primary key
#  code         :string(255)
#  name         :string(255)
#  english_name :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#

class Index < ActiveRecord::Base

  validates :name, presence: true, uniqueness: true
  validates :code, presence: true, uniqueness: true

  has_many :index_items
  has_many :companies, through: :index_items

  def company_by_code(company_code)
    companies.find_by(code: company_code)
  end
end
