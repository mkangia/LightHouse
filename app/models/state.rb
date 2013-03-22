class State < ActiveRecord::Base
  attr_accessible :open, :project_id, :title
  
  validates :title , :presence => true
  belongs_to :project
end
