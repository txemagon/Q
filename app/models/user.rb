class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  #
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :timeoutable, :lockable,
         :omniauthable, :omniauth_providers => [:google_oauth2]

  validates :last_name, :uniqueness => {:scope => :first_name}

  after_create :send_welcome_email

  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
    data = access_token.info
    user = User.where(:email => data["email"]).first

    # Uncomment the section below if you want users to be created if they don't exist
    unless user
        user = User.create(first_name: data["first_name"],
           last_name: data["last_name"],
           email: data["email"],
           password: Devise.friendly_token[0,20]
        )
    end
    user
  end


  def apply_oauth(omniauth)
    omniauth = omniauth['info']
    self.first_name = omniauth['first_name']
    self.last_name  = omniauth['last_name']
    self.email      = omniauth['email']
    self.password   = Devise.friendly_token.first(8)
    self.password_confirmation   = Devise.friendly_token.first(8)
  end

  def self.send_welcome_email(attributes={})
    
  end

end
