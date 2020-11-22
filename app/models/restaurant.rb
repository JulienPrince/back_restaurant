class Restaurant < ApplicationRecord
  has_one :user
  has_many :commentaires, dependent: :destroy
  has_many :reserveds, dependent: :destroy
  has_one_attached :photo

  validates :nom_restaurant, presence: true
  validates_uniqueness_of :nom_restaurant
  validates :prix, presence: true


  def self.search(params)
    restaurant= Restaurant.where("nom_restaurant LIKE ?", "%#{params[:search]}%")
    if params[:search].present?
      restaurant
    end
  end
  
end
