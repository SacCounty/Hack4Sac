class FixColumnNameInUsersQuestionnaires < ActiveRecord::Migration
  def change
    change_table :users_questionnaires do |t|
      t.remove_belongs_to :questionnare
      t.belongs_to :questionnaire
    end
  end
end
