class Reserved < ApplicationRecord
  has_many :users
  has_many :restaurants

  validates_presence_of :user_email

end
