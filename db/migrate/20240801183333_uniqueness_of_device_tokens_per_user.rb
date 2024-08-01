class UniquenessOfDeviceTokensPerUser < ActiveRecord::Migration[8.0]
  def change
    Device.destroy_all

    remove_index :devices, :token

    add_index :devices, %i[token user_id], unique: true
  end
end
