class UserMailer < ApplicationMailer
	default from: User.first.email

	def welcome_user_email(user, pass)
		@user = user
		@pass = pass

        attachments.inline['Q.png'] = File.read(Rails.root.join("app/assets/images", "Q120.png"))
        attachments.inline['vertical_cat_claim.png'] = File.read(Rails.root.join("app/assets/images", "vertical_cat_claim256.png"))

		mail(to: @user.email,
			subject: "Welcome to Q")
	end
end
