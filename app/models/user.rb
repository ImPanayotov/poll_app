# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :votes, dependent: :destroy

  validates :email, presence: true, unless: :guest_user?
  validates :password, presence: true, unless: :guest_user?

  def guest_user?
    email.blank? && ip_address.present?
  end

  def admin?
    role == 'admin'
  end
end
