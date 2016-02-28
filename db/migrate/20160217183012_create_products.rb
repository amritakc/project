class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :prod
      t.float :amt
      t.string :sold
      t.references :user, index: true

      t.timestamps
    end
  end
end
