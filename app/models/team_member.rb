# frozen_string_literal: true

class TeamMember < ApplicationRecord
  belongs_to :member
  belongs_to :team
end
