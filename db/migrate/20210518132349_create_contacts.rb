class CreateContacts < ActiveRecord::Migration[6.1]
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :email
      t.text :message
      t.boolean :responded, default: false
      t.boolean :archived, default: false

      t.timestamps
    end
  end
end
