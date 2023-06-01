class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.integer :status
      t.integer :category
      t.date :date
      t.string :location
      t.float :reward
      t.integer :source
      t.text :description

      t.timestamps
    end
  end
end
