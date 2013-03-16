class InvitesEmail < ActionMailer::Base
  def invites(user, email)
  	@from = user
     if @user = User.find_by_email(email)
        mail :to => email, :from => user.email, :subject => "Invitation from #{user.name}"
    else
    	mail :to => email, :from => user.email, :subject => "Invitation to join in at LightHouse"
    end
  end
end

