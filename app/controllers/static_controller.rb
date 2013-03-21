class StaticController < ApplicationController
  caches_page :about
  
  def about
  	@time = Time.now
  end
  
end