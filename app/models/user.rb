class User < ActiveRecord::Base
  before_validation :email_lowercase
  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  has_secure_password
  validates :name, :email, :password, presence: true
  validates :email, uniqueness: {case_sensitive: false}, format: {with: EMAIL_REGEX}

  private
  def email_lowercase
    self.email.downcase!
  end
end
