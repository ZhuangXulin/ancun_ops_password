class AddSystemPasswordSaltToAcsystems < ActiveRecord::Migration
  def change
    add_column :acsystems, :system_password_salt, :string
  end
end
