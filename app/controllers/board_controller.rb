class BoardController < ApplicationController
  def index
  	@approved = User.all
  	@pending  = User.find_by_rac(false)
  end

  def welcome
  end

  def banish
  end

  def confirm
  end
  
end
