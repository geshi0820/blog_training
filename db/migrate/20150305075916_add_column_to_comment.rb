class AddColumnToComment < ActiveRecord::Migration
  def change
    add_column :comments, :user_id, :int
    add_column :comments, :User, :string
    add_reference :comments,  index: true
  end
end
