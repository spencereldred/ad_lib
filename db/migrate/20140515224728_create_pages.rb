class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.references :adventure, index: true
      t.string :name
      t.text :text

      t.timestamps
    end
  end
end
