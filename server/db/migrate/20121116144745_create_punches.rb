class CreatePunches < ActiveRecord::Migration
  def change
    create_table :punches do |t|
      t.string :alias
      t.string :mac, null: false
      t.string :local_ip, null: false
      t.string :public_ip, null: false
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
