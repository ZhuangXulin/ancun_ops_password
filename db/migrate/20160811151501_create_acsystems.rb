class CreateAcsystems < ActiveRecord::Migration
  def change
    create_table :acsystems do |t|
      t.string :system_name
      t.text :system_desc
      t.text :system_ip
      t.text :system_password

      t.timestamps null: false
    end
  end
end
