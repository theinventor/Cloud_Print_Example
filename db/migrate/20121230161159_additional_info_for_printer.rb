class AdditionalInfoForPrinter < ActiveRecord::Migration
  def change
    add_column :printers, :user_id, :integer
    add_column :printers, :user_account_id, :integer
  end
end
