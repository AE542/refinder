class Item < ApplicationRecord
  belongs_to :user
  validates :reward, numericality: true, allow_blank: true
  validates :status, inclusion: { in: [0, 1, 2, 3, 100] }, presence: true
  attribute :source, :integer, default: 0
  validates :name, presence: true
  validates :description, presence: true, length: { maximum: 150 }
  validates :date, presence: true
end
