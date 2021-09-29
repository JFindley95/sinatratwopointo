class CreateRotas < ActiveRecord::Migration[6.1]
  def change
    create_table :rotas do |t|
      t.string :uk_team_name
      t.string :us_team_name
      t.date :date
    end
  end
end
