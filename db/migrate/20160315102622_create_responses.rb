class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.string :response_text, null: false
      t.belongs_to :user, index: true
      t.belongs_to :question, index: true
      t.timestamps null: false
    end
  end
end
