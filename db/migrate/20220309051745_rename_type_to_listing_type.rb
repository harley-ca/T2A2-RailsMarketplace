class RenameTypeToListingType < ActiveRecord::Migration[6.1]
  def change
    rename_column :listings, :type, :listing_type
  end
end
