class CreateUserAccounts < ActiveRecord::Migration
  def change
    create_table :user_accounts do |t|
      t.belongs_to :user
      t.string :email
      t.string :provider
      t.string :uid
      t.string :refresh_token
      t.timestamps
    end
  end
end
