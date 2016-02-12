class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :images, dependent: :destroy

  accepts_nested_attributes_for :images,
                                reject_if: proc { |attributes| attributes['lat'].blank? || attributes['lng'].blank? || attributes['file'].blank? },
                                allow_destroy: true
end
