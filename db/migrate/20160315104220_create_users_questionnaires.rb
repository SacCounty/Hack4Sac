class CreateUsersQuestionnaires < ActiveRecord::Migration
  def change
    create_table :users_questionnaires do |t|
      t.belongs_to :user, index: true
      t.belongs_to :questionnare, index: true
      t.timestamps null: false
    end
  end
end
