class BoardController < ApplicationController
  before_action :set_user , only: [:welcome, :banish, :confirm, :destroy]
  before_action :check_privileges

  def index
  	@approved  = User.admins
  	@plebeians = User.plebeians
  end

  def welcome
    @user.admin = true
    @user.save
    UserMailer.youve_been_approved(@user, current_user).deliver_later
    redirect_to board_index_url
  end

  def banish
    if User.admins.count > 1 and @user != current_user
      @user.admin = false
      @user.save
          logger.info "#{current_user.full_name} has banished #{@user.full_name} from the admin board."
      UserMailer.youve_been_banished(@user, current_user).deliver_later
    else
      if @user == current_user
        flash[:alert] = <<-END

    don't give up
 -  'cause you have friends
 -  don't give up
 -  you're not the only one
 -  don't give up
 -  no reason to be ashamed
 -  don't give up
 -  you still have us
 -  don't give up now
 -  we're proud of who you are
 -  don't give up
 -  you know it's never been easy
 -  don't give up
 -  'cause I believe there's a place
 -  there's a place where we belong

END

      else
         flash[:alert] = "You are the only one administrator. Choose a heir before leaving."
      end
    end
    redirect_to board_index_url
  end

  def confirm
    @user.confirm
    UserMailer.youve_been_confirmed(@user, current_user).deliver_later
    redirect_to board_index_url
  end

  # DELETE /board/1
  # DELETE /board/1.json
  def destroy
    redirect_to board_index_url, notice: 'Admins cannot be deleted' if (@user.admin?)

    logger.info "#{current_user.full_name} has deleted #{@user.full_name} account."
    UserMailer.cancel_account(@user, current_user).deliver_later
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

  def check_privileges
    unless user_signed_in? and current_user.admin?
      flash[:alert] = "No peeping allowed. Sign in as administrator."
      redirect_to root_url
    end
  end
end
