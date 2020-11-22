class User < ApplicationRecord
    has_secure_password
    
    has_many :comments, dependent: :destroy
    has_many :reserveds, dependent: :destroy

    validates_presence_of :email
    validates_uniqueness_of :email
end
