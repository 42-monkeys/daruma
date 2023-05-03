# frozen_string_literal: true

class User < ApplicationRecord
  extend UserLanguages
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist

  has_many :resolutions, dependent: :destroy
  validates :name, presence: true
  validates :language, presence: true, inclusion: { in: languages }
end
