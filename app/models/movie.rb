class Movie < ApplicationRecord
    belongs_to :genre
    has_many :recommendations, dependent: :destroy
end
