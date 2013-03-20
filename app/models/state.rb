class State < ActiveRecord::Base
  attr_accessible :open, :project_id, :title
  
  validates :open, :project_id, :title , :presence => true
  belongs_to :project
end
