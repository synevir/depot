class AddDetailsToProducts < ActiveRecord::Migration
  def change
    add_column :products, :details, :string, default: 'Unfortunately there is no detailed information.
Please contact the manager'
  end
end
