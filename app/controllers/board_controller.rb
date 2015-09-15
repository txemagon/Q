class BoardController < ApplicationController
  before_action :set_user , only: [:welcom, :banish, :confirm, :destroy]

  def index
  	@approved = User.all
  	@pending  = User.find_by_admin(false)
  end

  def welcome
  end

  def banish
  end

  def confirm
    @user.confirm
    rendirect_to board_index_url
  end
  
  # DELETE /board/1
  # DELETE /board/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to board_index_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  def set_user
      @user = User.find(params[:id])
    end
end
