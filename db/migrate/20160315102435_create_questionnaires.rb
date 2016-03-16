class CreateQuestionnaires < ActiveRecord::Migration
  def change
    create_table :questionnaires do |t|
      t.string :name, null: false
      t.timestamps null: false
    end
  end
end
