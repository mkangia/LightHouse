class State < ActiveRecord::Base
  attr_accessible :open, :project_id, :title
  
  belongs_to :project
end
