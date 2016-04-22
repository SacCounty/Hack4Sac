class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :question_text, null: false
      t.belongs_to :questionnaire, index: true
      t.timestamps null: false
    end
  end
end
