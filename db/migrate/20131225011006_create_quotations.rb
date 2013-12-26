class CreateQuotations < ActiveRecord::Migration
  def change
    create_table :quotations do |t|
      t.string :author
      t.string :source
      t.text :passage

      t.timestamps
    end
  end
end
