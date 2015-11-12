class User < ActiveRecord::Base
  after_initialize do
    reset_session_token!
  end
  validates :user_name, presence: true


  def reset_session_token!
    self.session_token ||= SecureRandom::urlsafe_base64
  end

  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    self.password_digest.is_password?(password)
  end

  def self.find_by_credentials(username, password)

    user = User.find_by(user_name: username)
    return nil if user.nil?
    user.is_password?(password)? user : nil
  end
end
