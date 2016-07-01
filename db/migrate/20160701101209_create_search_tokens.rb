class CreateSearchTokens < ActiveRecord::Migration
  def change
    create_table :search_tokens do |t|
      t.references :document, index: true, polymorphic: true, null: false
      t.string :term, null: false
      t.string :matched_string, null: false
      t.string :column, null: false

      t.timestamps null: false
    end

    add_index :search_tokens, %i[column term]
  end
end
