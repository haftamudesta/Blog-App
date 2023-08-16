class CommentCounterDefaultValue < ActiveRecord::Migration[7.0]
  def change
    change_column_default :posts, :coments_counter, 0
  end
end
