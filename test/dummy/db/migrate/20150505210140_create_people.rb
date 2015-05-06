class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string  :name
      t.integer :age_phase
      t.string :status

      t.timestamps
    end
  end
end
