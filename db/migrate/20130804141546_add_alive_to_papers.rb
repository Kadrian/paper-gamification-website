class AddAliveToPapers < ActiveRecord::Migration
  def change
    add_column :papers, :alive, :boolean
  end
end
