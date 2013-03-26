class Project < ActiveRecord::Base
  attr_accessible :description, :name, :user_id

  validates :name, :user_id, :presence => true

  belongs_to :owner, :class_name => "User", :foreign_key => "user_id"
  
  has_many :projects_users
  has_many :users, :through => :projects_users
  has_many :tickets, :dependent => :destroy
  has_many :states, :dependent => :destroy

  after_create :add_default_states

  def self.search(search)
    find(:all, :conditions => ['name like ?', "%#{search}%"])
  end

  def add_default_states
    states << State.new( :project_id => id, :title => 'open' , :open => true )
    states << State.new( :project_id => id, :title => 'close' , :open => false )
  end
    
end
