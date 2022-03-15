class User < ApplicationRecord
include Filterable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :listings
  has_many :reviews
  has_many :applications

  # Scope for future use to be able to search Users
  scope :filter_by_username, -> (username) {where("username like ?", "#{username}")}
end
