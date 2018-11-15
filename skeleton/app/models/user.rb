class User < ApplicationRecord
  validates :session_token, presence: true
  validates :user_name, presence: true, uniqueness: true
  validates :password_digest, presence: true
  
  after_initialize :ensure_session_token
  
  def ensure_session_token
    self.session_token ||= reset_session_token!
  end
  
  def generate_session_token!
    SecureRandom::urlsafe_base64(16)
  end
  
  def reset_session_token!
    self.session_token = generate_session_token!
    self.save!
    self.session_token
  end
  
  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
  end
  
  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end
  
  def self.find_by_credentials(user_name, password)
    user = User.find_by(user_name: user_name)
    return nil if user.nil?
    
    user.is_password?(password) ? user : nil
  end
  
  
  
end
