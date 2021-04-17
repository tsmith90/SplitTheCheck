class Restaurant < ApplicationRecord
  validates :name, :location, presence: true

  has_many :votes, dependent: :destroy
end
