class User < ApplicationRecord
  attr_accessor :old_password
  has_secure_password

  validate :correct_old_password, on: :update, if: -> { password.present? }

  validates :username, presence: { message: "Please enter an username" }, 
                        uniqueness: { message: "This username is already taken" }

  validates :email, presence: { message: "Please enter a email" }, 
                    uniqueness: { message: "This email is already taken" },
                    format: { with: /\A[^@\s]+@[^@\s]+\z/, message: "Incorrect email was entered" }
                    
  validates :password, presence: { message: "Please enter a password" }, 
                        length: { minimum: 8, message: "Please choose a password with at least 8 characters"}

  def correct_old_password
    return if BCrypt::Password.new(password_digest_was).is_password?(old_password)
                      
    errors.add :old_password, 'The old password was entered incorrectly'
  end
end
