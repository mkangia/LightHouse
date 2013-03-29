class ProjectsUser < ActiveRecord::Base
  attr_accessible :project_id, :user_id, :admin

  belongs_to :user 
  belongs_to :project

  after_create :notify_user

  def notify_user
    notify_to = user
    InvitesEmail.delay.invites(project.owner, notify_to)
  end	
end
