class Project < ActiveRecord::Base
  attr_accessible :description, :name, :user_id

  validates :name, :presence => true

  belongs_to :owner, :class_name => "User", :foreign_key => "user_id"
  
  has_many :projects_users
  has_many :users, :through => :projects_users
  has_many :tickets
  has_many :states

  def self.search(search)
    if search
    	find(:all, :conditions => ['name like ?', "%#{search}%"])
    else
    	find(:all)
    end
  end
  
end
