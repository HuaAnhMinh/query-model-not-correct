# frozen_string_literal: true

module ReportsData
  class CallbackHandler
    def initialize(model, event, object)
      @model = model
      @event = event
      @object = object
    end

    def call
      p 'ReportsData::CallbackHandler called'
    end
  end
end
