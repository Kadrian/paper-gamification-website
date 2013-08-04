class CreatePapers < ActiveRecord::Migration
  def change
    create_table :papers do |t|
      t.string :title
      t.text :stats

      t.timestamps
    end
  end
end
