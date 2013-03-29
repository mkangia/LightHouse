require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  fixtures :projects

  test "project must have a name" do
    project = Project.new

    assert project.invalid?
    assert project.errors[:name].any? 
    assert_equal project.errors[:description].any?, false
  end

  test "project can be without description" do
  	project = Project.new(:name => "test_project", :user_id => 1)
  	assert_equal project.errors[:description].any?, false
  	assert_equal project.invalid?, false
  end

  test "project should have an owner" do
  	project = projects(:test_project)
  	assert project.owner
  	assert_equal project.owner.name, "puppy"
  end
end
