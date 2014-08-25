ActiveAdmin.register User do


  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end

	index do
		column :id
		column :admin
		column :username
		column :nick
		column :provider
		column :uid
		column :image do |user|
			image_tag user.image_url, width: '60px' if user.image_url
		end
		actions
	end

	filter :id
	filter :admin
	filter :username
	filter :nick
	filter :provider
	filter :created_at
	filter :updated_at

	form do |f|
		f.inputs do
			f.input :username
			f.input :password, required: false, input_html: {placeholder: 'Leave blank if you don\'t want to change it'}
			f.input :password_confirmation, input_html: {placeholder: 'Required only if changing password'}
			f.input :nick
			f.input :admin
			f.input :provider
			f.input :uid
			f.input :image
		end
		f.actions do
			f.action :submit, label: 'Update'
			f.cancel_link
		end
	end

	controller do
		def update
			if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
				params[:user].delete("password")
				params[:user].delete("password_confirmation")
			end
			super
		end
	end
end
