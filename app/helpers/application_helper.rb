module ApplicationHelper

    # Ensure there is a current user and he is the Admin
	def you_are_admin?
		user_signed_in? and current_user.confirmed? and current_user.admin?
	end

	def beautify(list)
		list = list.clone
		list.each{ |a| a.name = Formatter.show(a.name) }
	end

end
