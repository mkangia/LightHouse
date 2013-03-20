class ProjectsUser < ActiveRecord::Base
  attr_accessible :project_id, :user_id, :admin

  belongs_to :user 
  belongs_to :project

  after_create :notify_user

  def notify_user
    notify_to = user
    InvitesEmail.invites(project.owner, notify_to).deliver
  end	
end
