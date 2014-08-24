class User < ActiveRecord::Base
	has_and_belongs_to_many :posts, uniq: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :validatable,
				 :omniauthable, :omniauth_providers => [:steam]

	mount_uploader :image, ImageUploader

	def email_changed?
		false
	end

	def email_required?
		false
	end

	def self.from_omniauth(auth)
		where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
			user.username = auth.info.nickname
			user.password = Devise.friendly_token[0,20]
			user.remote_image_url = auth.info.image
		end
	end

	def link_omniauth(auth)
		self.provider = auth.provider
		self.uid = auth.uid
		self.remote_image_url = auth.info.image
		self.save
	end
end
