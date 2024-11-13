class AddTeamAssessmentAttrsToEvaluations < ActiveRecord::Migration[8.0]
  def change
    change_table :evaluations, bulk: true do |t|
      t.integer :team_stability
      t.integer :team_competencies_and_experience
      t.integer :team_leaders_competencies
      t.integer :team_competencies
      t.integer :team_professional_activity
    end
  end
end
