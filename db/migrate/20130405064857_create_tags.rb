class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :name
      t.string :ancestry

      t.timestamps
    end

    add_index :tags, :ancestry
  end
end
