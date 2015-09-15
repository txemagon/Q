class UserMailer < ApplicationMailer


	def welcome_user_email(user, pass)
		@user, @pass = user, pass

		mail(to: @user.email,
			subject: "Welcome to Q")
	end

	def youve_been_confirmed(user, whom)
		@user, @whom = user, whom
        mail(to: @user.email,
        	 subject: "You've been confirmed.")
	end

	def youve_been_banished(user, whom)
		@user, @whom = user, whom
        mail(to: @user.email,
        	 subject: "Bye.")
	end

	def youve_been_approved(user, whom)
		@user, @whom = user, whom
        mail(to: @user.email,
        	 subject: "Welcome to the board.")
	end


	def cancel_account(user, whom)
		@user, @whom = user, whom
        mail(to: @user.email,
        	 subject: "Account canceled.")
	end

end
