module ApplicationHelper

    # Ensure there is a current user and he is the RAC
	def you_are_rac?
		user_signed_in? and current_user.confirmed? and current_user.rac?
	end
	
end
