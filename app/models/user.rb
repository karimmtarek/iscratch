class User < ActiveRecord::Base
  has_secure_password
  has_many :lists, dependent: :destroy
  before_create :generate_auth_token

  validates :email, presence: true

  def self.authenticate(email, password)
    user = User.find_by(email: email)
    user && user.authenticate(password)
  end

  private

  def generate_auth_token
    self.authentication_token = SecureRandom.hex(10)
    # begin
    #   self.authentication_token = SecureRandom.hex
    # end while self.class.exists?(access_token: access_token)
  end
end
