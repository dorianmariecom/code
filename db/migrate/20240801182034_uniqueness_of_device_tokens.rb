class UniquenessOfDeviceTokens < ActiveRecord::Migration[8.0]
  def change
    Device.destroy_all

    add_index :devices, :token, unique: true
  end
end
