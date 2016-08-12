class RemoveSystemDescToAcsystem < ActiveRecord::Migration
  def change
  	remove_column :acsystems, :system_name
  	remove_column :acsystems, :system_desc
  	remove_column :acsystems, :system_ip
  	remove_column :acsystems, :system_password
  	
  	add_column :acsystems, :system_name, :string, null: false, default: ""
  	add_column :acsystems, :system_desc, :string ,default: ""
  	add_column :acsystems, :system_ip, :string, default: ""
  	add_column :acsystems, :system_password, :string, null: false, default: ""
  end
end
