class User < ActiveRecord::Base
  has_secure_password
  has_many :lists, dependent: :destroy
  before_create :generate_auth_token

  validates :email, presence: true,
                    uniqueness: {case_sensitive: false},
                    format: /\A\S+@\S+\z/

  private

  def generate_auth_token
    self.authentication_token = SecureRandom.hex(10)
  end
end
