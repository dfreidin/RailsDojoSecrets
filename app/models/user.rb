class User < ActiveRecord::Base
  before_validation :email_lowercase
  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  has_secure_password
  has_many :secrets
  has_many :likes, dependent: :destroy
  has_many :secrets_liked, through: :likes, source: :secret
  validates :name, :email, presence: true
  validates :password, presence: true, on: :create
  validates :email, uniqueness: {case_sensitive: false}, format: {with: EMAIL_REGEX}

  private
  def email_lowercase
    self.email.downcase!
  end
end
