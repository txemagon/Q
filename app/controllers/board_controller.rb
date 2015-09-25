class BoardController < ApplicationController
  before_action :check_admin_privileges
  before_action :set_user , only: [:welcome, :banish, :confirm, :destroy]

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
    begin
      current_user.banish(@user)
      logger.info "#{current_user.full_name} has banished #{@user.full_name} from the admin board."
      UserMailer.youve_been_banished(@user, current_user).deliver_later
    rescue Exception => e
        flash[:alert] = e.message
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

end
