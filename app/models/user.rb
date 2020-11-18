require 'pp'
class User < ActiveRecord::Base

  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }
  validates :password_confirmation, presence: true
  validates :password_digest, presence: true

  def self.authenticate_with_credentials(email, password)
    user = User.find_by_email(email.strip)

    if user.authenticate(password)
      user
    else
      nil
    end
  end

end
