class CreateWeathers < ActiveRecord::Migration[5.2]
  def change
    create_table :weathers do |t|
      t.string :weather, null: false
      t.date :date, null: false
      t.string :place, null: false

      t.timestamps
    end
  end
end
