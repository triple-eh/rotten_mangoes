class User < ActiveRecord::Base

  has_many :reviews, dependent: :destroy

  has_secure_password

  validates :email,
    presence: true, uniqueness: true

  validates :firstname,
    presence: true

  validates :lastname,
    presence: true

  validates :password,
    length: { in: 6..20 }, on: :create

  paginates_per 10

  def full_name
    "#{firstname} #{lastname}"
  end
    
end
