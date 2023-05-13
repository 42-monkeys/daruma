# frozen_string_literal: true

class User < ApplicationRecord
  extend UserLanguages
  before_save :set_timezone
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable, :trackable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist

  has_many :resolutions, dependent: :destroy
  has_many :devices, dependent: :destroy

  validates :name, presence: true
  validates :language, presence: true, inclusion: { in: languages }

  enum :role, %i[std admin], suffix: true

  def set_timezone
    self.time_zone = Time.zone
  end

  def send_notification
    android_device_tokens = devices.where(platform: 'android').pluck(:token)
    return if android_device_tokens.blank?

    n = Rpush::Gcm::Notification.new
    n.app = Rpush::Gcm::App.find_by(name: 'daruma')
    n.registration_ids = android_device_tokens
    n.data = {
      title: 'New Message',
      body: 'Hello, Again!',
      icon: 'path_to_your_app_icon'
    }
    n.save!
    Rpush.push
  end
end
