class AddApplauseTable < ActiveRecord::Migration
  def change
    create_table(:applauses) do |t|
      t.column :paper_id, :integer
      t.column :user_agent, :string
      t.column :referer, :string
      t.column :source_ip, :string  #request.remote_ip      
      t.timestamps
    end
  end
end
