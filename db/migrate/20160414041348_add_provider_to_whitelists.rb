class AddProviderToWhitelists < ActiveRecord::Migration
  def change
    add_column :whitelists, :provider, :string, :default => 'github'
  end
end
