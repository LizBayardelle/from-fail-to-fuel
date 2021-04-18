class HomeController < ApplicationController
  layout false, only: [:coming_soon]
  
  def index
  end

  def coming_soon
  end
end
