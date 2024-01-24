class CreateTeamMembers < ActiveRecord::Migration[7.1]
  def change
    create_table :team_members, id: :uuid, default: 'uuid_generate_v4()' do |t|
      t.uuid :member_id, null: false
      t.uuid :team_id, null: false
      t.timestamps
    end
  end
end
