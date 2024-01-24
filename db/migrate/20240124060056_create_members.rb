# frozen_string_literal: true

class CreateMembers < ActiveRecord::Migration[7.1]
  def change
    create_table :members, id: :uuid, default: 'uuid_generate_v4()' do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.timestamps
    end
  end
end
