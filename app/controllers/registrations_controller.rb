class RegistrationsController < Devise::RegistrationsController

    private

    def build_resource(*args)
    	super
    	if (session["devise.google_data"])
    		@user.apply_oauth(session["devise.google_data"])
    		@user.valid?
    	end
    end

end
