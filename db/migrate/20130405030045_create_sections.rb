class CreateSections < ActiveRecord::Migration
  def change
    create_table :sections do |t|
      t.text :content
      t.integer :post_id

      t.timestamps
    end
  end
end
