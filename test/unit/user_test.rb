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
    user = users(:test_user1)
    assert !user.save

    user = users(:test_user2)
    assert user.save
  end
end
