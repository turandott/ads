class AddImagesToMicroposts < ActiveRecord::Migration[7.0]
  def change
    add_column :microposts, :images, :string, array: true
  end
end
