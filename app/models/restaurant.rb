class Restaurant < ApplicationRecord
  validates :name, :location, presence: true

  has_many :votes, dependent: :destroy
  has_many :favorites, dependent: :destroy
end
