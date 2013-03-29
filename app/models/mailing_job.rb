class MailingJob < Struct.new(:mailing_id)  
  def perform  
    InvitesEmail.invites(project.owner, notify_to).deliver
  end  
end  