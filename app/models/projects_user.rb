class ProjectsUser < ActiveRecord::Base
  attr_accessible :project_id, :user_id, :admin

  belongs_to :user 
  belongs_to :project
end
