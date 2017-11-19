class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :authentication_keys => [:login]

  	def self.find_for_database_authentication(warden_conditions)
      conditions = warden_conditions.dup
      if login = conditions.delete(:login)
        where(conditions.to_h).where(["lower(mobile) = :value OR lower(email) = :value", { :value => login.downcase }]).first
      elsif conditions.has_key?(:mobile) || conditions.has_key?(:email)
        where(conditions.to_h).first
      end
    end
    validates :mobile, :presence => true, :uniqueness => { :case_sensitive => false } # etc.
	# validates_format_of :mobile, with: /^[a-zA-Z0-9_\.]*$/
	validate :validate_mobile

	def validate_mobile
	  if User.where(email: mobile).exists?
	    errors.add(:mobile, :invalid)
	  end
	end
	def login=(login)
	  @login = login
	end

	def login
	  @login || self.mobile || self.email
	end
end
