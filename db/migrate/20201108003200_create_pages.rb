class CreatePages < ActiveRecord::Migration[6.0]
  def change
    create_table :pages do |t|
      t.string :link
      t.text :content

      t.timestamps
    end
    add_index :pages, :link
  end
end
