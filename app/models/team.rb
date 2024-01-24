# frozen_string_literal: true

class Team < ApplicationRecord
  has_many :team_members, foreign_key: 'team_id', inverse_of: :team
  has_many :members, through: :team_members
  belongs_to :leader, class_name: 'Member', foreign_key: 'leader_id'
end
