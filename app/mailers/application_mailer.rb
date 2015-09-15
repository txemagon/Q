class ApplicationMailer < ActionMailer::Base
  default from: User.find_by_admin(true).email
  before_action :set_common_data
  layout 'mailer'

  private
	def set_common_data
		@admin = User.find_by_admin(true)
		attachments.inline['Q.png'] = File.read(
			Rails.root.join("app/assets/images", "Q120.png") )
        attachments.inline['vertical_cat_claim.png'] = File.read(
        	Rails.root.join("app/assets/images", "vertical_cat_claim256.png"))
    end

end
