
class User < ActiveRecord::Base
  attr_accessible :email, :name, :password_digest
  validates :name, :email, :password_digest , :presence => true 
  validates :email ,:uniqueness => true, :format => { :with => /^[a-zA-z0-9]+[\w\.]*\w+@\w+\.[a-zA-Z]{2,3}$/i }

  def password_match(password_entered)
    password_digest.eql? password_entered
  end
 
  has_many :projects_users
  has_many :projects, :through => :projects_users
  has_many :tickets, :foreign_key => "assigned_to"
end
