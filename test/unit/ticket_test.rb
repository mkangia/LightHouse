require 'test_helper'

class TicketTest < ActiveSupport::TestCase
  fixtures :tickets
  
  test "ticket should have title/user/project" do
  	ticket = Ticket.new
  	assert ticket.invalid?
  	assert ticket.errors[:title].any?
  	assert ticket.errors[:user_id].any?
  	assert ticket.errors[:project_id].any?
  end

  test "ticket should have a creator" do
    ticket = tickets(:test_ticket)
    assert ticket.creator
  end
end
