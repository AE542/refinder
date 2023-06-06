class AddBlurToItems < ActiveRecord::Migration[7.0]
  def change
    add_column :items, :blur, :boolean
  end
end
