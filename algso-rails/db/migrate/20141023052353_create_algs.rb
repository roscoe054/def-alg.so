class CreateAlgs < ActiveRecord::Migration
  def change
    create_table :algs do |t|
      t.string :name
      t.string :url
      t.string :doc
      t.string :status
      t.string :type
      t.string :version

      t.timestamps
    end
  end
end
