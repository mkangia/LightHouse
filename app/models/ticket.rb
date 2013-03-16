class Ticket < ActiveRecord::Base
  attr_accessible :assigned_to, :description, :project_id, :state, :title, :user_id

  validates :title, :user_id, :project_id, :presence => true

  belongs_to :creator, :class_name => "User", :foreign_key => "user_id"

  def self.search(search, search_by)
  	if search
  		if(search_by == "all")
  		  find(:all, :conditions => ["title like ? Or description like ?", "%#{search}%", "%#{search}%"])
  		elsif search_by == "project"
  		  @project = Project.where(:name => search)[0]
        @project ? find(:all, :conditions => ["project_id = ?", @project.id]) : []
  		elsif search_by
        find(:all, :condition => ["#{search_by} like ?", "#{search}"])
  	  else
  		find(:all)
  	  end
    end
  end
end
