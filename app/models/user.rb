class User < ActiveRecord::Base  
  
  attr_accessible :username, :password, :password_confirmation, :full_name,
                  :department_id, :user_type, :status


  scope :search_by_name, lambda { |value| where("CONCAT(full_name,' ', username) LIKE ?", "%#{value}%") }

  scope :search_by_fullname, lambda { | value | where("full_name LIKE ?" , "%#{value}%")}

  scope :search_by_username, lambda { | value | where("username LIKE ?", "%#{value}%")}
  scope :search_by_department, lambda { | value |
                                       departments = Department.where("n ame LIKE :value", value: "%#{value}%")
                                       self.where('department_id IN (?)', departments.pluck(:id))
                                    }



  attr_accessor :password
  before_save :encrypt_password
  
  belongs_to :department
  
  validates :full_name, presence: true
  validates :username, uniqueness: true, presence: true,  uniqueness: { case_sensitivity: true }
  validates :password, presence: true, confirmation: true, on: :create
  
  validates :department_id, :user_type, presence: true

  UserType = [ "Admin", "Head", "Checker" ]

  def self.authenticate(username, password)
    user = find_by_username(username)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt) && user.status
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


  def self.search(search_by, search)
    user_scope = self.scoped({})

    case search_by
      when 'Fullname'
          user_scope = user_scope.search_by_fullname(search)
      when 'Username'
          user_scope = user_scope.search_by_username(search)
      when 'Department'
          user_scope = user_scope.search_by_department(search)
      end
    return user_scope
  end
  
end
