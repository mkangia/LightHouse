class State < ActiveRecord::Base
  attr_accessible :open, :project_id, :title
  
  validates :title ,:project_id, :presence => true
  belongs_to :project

  before_destroy :check_for_associated_tickets

  def check_for_associated_tickets
  	unless Ticket.find(:first, :conditions => ["state = #{self.id}"]).nil?
  	  return false
  	end
  end

end
