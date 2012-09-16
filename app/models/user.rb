class User < ActiveRecord::Base  
  
  attr_accessible :username, :password, :password_confirmation, :full_name

  attr_accessor :password
  before_save :encrypt_password
  
  validates :full_name, presence: true
  validates :username, uniqueness: true, presence: true
  validates :password, presence: true, confirmation: true, on: :create

  def self.authenticate(username, password)
    user = find_by_username(username)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end
  
  
  
end