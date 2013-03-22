require 'test_helper'

class UserTest < ActiveSupport::TestCase
  fixtures :users
  
  test "user should have a name/email and password" do
    user = User.new

    assert user.invalid?
    assert user.errors[:name].any?
    assert user.errors[:email].any?
    assert user.errors[:password_digest].any?
  end

  test "user should have a valid email-id" do
    user = users(:test_user2)
    user.email = "nothing"
    assert !user.save
  end

  test "email-ids have to be unique" do
    user = User.create(:name => "me", :password_digest => "you", :email => users(:test_user2).email)
    assert !user.save
  end
  
end
