class CreateCattributes < ActiveRecord::Migration[5.2]
  def change
    create_table :cattributes do |t|
      t.string :name
      t.string :category
      t.integer :gene
      t.string :readable_name
      t.string :readable_category

      t.timestamps
    end
  end
end
