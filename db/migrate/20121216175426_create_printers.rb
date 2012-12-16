class CreatePrinters < ActiveRecord::Migration
  def change
    create_table :printers do |t|
      t.string :name
      t.string :printer_id

      t.timestamps
    end
  end
end
