class State < ActiveRecord::Base
  attr_accessible :open, :project_id, :title
  
  validates :title ,:project_id, :presence => true
  belongs_to :project
end
