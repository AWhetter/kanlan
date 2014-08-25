ActiveAdmin.register Game do


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
		column :name
		column :url
		column "Steam App ID", :steam_app_id
		column :created_at
		column :updated_at
		actions
	end

	filter :name
	filter :url
	filter :steam_app_id, label: "Steam App ID"
	filter :created_at
	filter :updated_at

end
