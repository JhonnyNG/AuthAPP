class AddResetTokenToUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :email_address, null: false
      t.string :password_digest, null: false
      t.string :reset_token
      t.datetime :reset_sent_at
      t.timestamps
    end

    add_index :users, :email_address, unique: true
    add_index :users, :reset_token, unique: true

    create_table :sessions do |t|
      t.references :user, null: false, foreign_key: true
      t.string :user_agent
      t.string :ip_address
      t.timestamps
    end
  end
end
