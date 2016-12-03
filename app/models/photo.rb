class Photo < ApplicationRecord
    has_many :favoritephotos, dependent: :destroy 
    has_many :users, through: :favoritephotos, dependent: :destroy 
end
