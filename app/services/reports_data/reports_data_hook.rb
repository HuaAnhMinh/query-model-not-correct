# frozen_string_literal: true

module ReportsData
  class ReportsDataHook
    MODELS = [Member, TeamMember, Team].freeze
    EVENTS = %i[create update destroy].freeze

    def self.inject!
      MODELS.each do |model|
        EVENTS.each do |event|
          model.send(
            :after_commit,
            proc { ::ReportsData::CallbackHandler.new(model, event, self).call },
            on: event
          )
        end
      end
    end
  end
end
