class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  validates :reward, numericality: true, allow_blank: true
  validates :status, inclusion: { in: [0, 1, 2, 3, 100] }, presence: true
  attribute :source, :integer, default: 0
  validates :name, presence: true
  validates :description, length: { maximum: 150 }
  validates :date, presence: true

  # for Geocoder
  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?

end
