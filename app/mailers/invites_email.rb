class InvitesEmail < ActionMailer::Base
  def invites(notify_by, notify_to)
  	@from = notify_by
  	@to = notify_to
    mail :to => notify_to.email, :from => @from.email, :subject => "Invitation by #{@from.name} to join a project at LightHouse"
  end
end

