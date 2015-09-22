class User < ActiveRecord::Base

  class ClearanceError  < StandardError; end
  class SuicideError    < StandardError; end
  class DecapitateError < StandardError; end

  ERROR = {
    :clearance  => "Not enough clearance to perform this operation.",
    :decapitate => "You are the only one administrator. Choose a heir before leaving.",
    :suicide    => <<-END

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
  }

  # Include default devise modules. Others available are:
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :timeoutable, :lockable,
         :omniauthable, :omniauth_providers => [:google_oauth2]

  validates :last_name, :uniqueness => {:scope => :first_name}

  scope :admins,    -> { where(admin: true)  }
  scope :plebeians, -> { where(admin: false) }

  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
    data = access_token.info
    user = User.where(:email => data["email"]).first

    # Uncomment the section below if you want users to be created if they don't exist
    unless user
        token = Devise.friendly_token[0,20]
        user = User.create(first_name: data["first_name"],
           last_name: data["last_name"],
           email: data["email"],
           password: token
        )
        UserMailer.welcome_user_email(user, token).deliver_later
    end
    user
  end


  def apply_oauth(omniauth)
    omniauth        = omniauth['info']
    self.first_name = omniauth['first_name']
    self.last_name  = omniauth['last_name']
    self.email      = omniauth['email']
  end

  def full_name
    first_name + " " + last_name
  end

  def banish(user)
      raise ClearanceError,  ERROR[:clearance]  if !admin?
      raise DecapitateError, ERROR[:decapitate] if User.admins.count < 2 
      raise SuicideError,    ERROR[:suicide]    if user == self

      user.admin = false
      user.save
  end

end
