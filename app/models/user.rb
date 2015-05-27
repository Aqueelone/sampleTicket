class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :tickets
  has_many :widgets
  has_one  :dashboard
  has_many :ticket_statuses, :through => :tickets  
  has_many :categories, :through => :tickets

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :is_admin, :is_moderator, :current_sign_in_at, :current_sign_in_ip
  attr_protected :sign_in_count, :last_sign_in_at, :last_sign_in_ip
  
  validates :name, presence: true
  validates :email, presence: true 
  validates :password, :on => :create, presence: true
  validates :password, :confirmation => true
  
  def is_associated?
    tickets.count > 0
  end
end
