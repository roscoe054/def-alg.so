class User < ActiveRecord::Base
	include Gravtastic
  	gravtastic :secure => true,
               :filetype => :gif,
               :rating => 'G',
               :d => 'mm'

	before_save { self.email = email.downcase }
	before_create :create_remember_token

	validates :name, presence: true, length: { minimum: 2, maximum: 10 }
	VALID_EMAIL_REGEX = /\A([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{1,3}\z/i
	validates :email, presence: true,
					  format: { with: VALID_EMAIL_REGEX },
					  uniqueness: { case_sensitive: false }
	has_secure_password
	validates :password, presence: true, length: { minimum: 6 }

	def User.new_remember_token
		SecureRandom.urlsafe_base64
	end
	def User.encrypt(token)
		Digest::SHA1.hexdigest(token.to_s)
	end
	private
		def create_remember_token
			self.remember_token = User.encrypt(User.new_remember_token)
		end
end
