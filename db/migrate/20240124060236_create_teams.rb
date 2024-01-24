class CreateTeams < ActiveRecord::Migration[7.1]
  def change
    create_table :teams, id: :uuid, default: 'uuid_generate_v4()' do |t|
      t.string :name
      t.string :status
      t.uuid :leader_id
      t.timestamps
    end
  end
end
