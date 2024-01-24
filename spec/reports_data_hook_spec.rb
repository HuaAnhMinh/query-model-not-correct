# frozen_string_literal: true

require 'rails_helper'

describe ReportsData::ReportsDataHook do
  describe '.inject!' do
    let(:models_data) do
      ReportsData::ReportsDataHook::MODELS.map do |model|
        {
          record: create(model.to_s.underscore.to_sym),
          model:
        }
      end
    end

    before do
      ReportsData::ReportsDataHook.inject!
    end

    context 'when create event is triggered' do
      it 'calls the callback handler' do
        ReportsData::ReportsDataHook::MODELS.each do |model|
          expect(ReportsData::CallbackHandler)
            .to receive(:new)
            .with(model, :create, instance_of(model))
            .and_call_original
            .at_least(:once)

          create(model.to_s.underscore.to_sym)
          # * With ruby-debug-ide, put a breakpoint on the line above and run, then
          #   step next to 'end' keyword and check Member.count, Member.first.
          # * With byebug, run bundle exec rspec spec/reports_data_hook_spec.rb
          #   and check Member.count, Member.first.
          # byebug
        end
      end
    end

    context 'when update event is triggered' do
      it 'calls the callback handler' do
        models_data.each do |data|
          model = data[:model]
          record = data[:record]

          expect(ReportsData::CallbackHandler)
            .to receive(:new)
            .with(model, :update, record)
            .and_call_original
            .at_least(:once)

          record.update(uuid: SecureRandom.uuid)
        end
      end
    end

    context 'when destroy event is triggered' do
      it 'calls the callback handler' do
        models_data.each do |data|
          model = data[:model]
          record = data[:record]

          expect(ReportsData::CallbackHandler)
            .to receive(:new)
            .with(model, :destroy, record)
            .and_call_original
            .at_least(:once)

          record.destroy
        end
      end
    end
  end
end

