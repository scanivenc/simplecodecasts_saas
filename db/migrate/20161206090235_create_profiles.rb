class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.integer :user_id #ties the 2 tables together ea profile has a user id
      t.string :first_name
      t.string :last_name
      t.string :job_title
      t.string :phone_number
      t.string :contact_email
      t.text :description #larger chunk of text
      
      t.timestamps
      
    end
  end
end
