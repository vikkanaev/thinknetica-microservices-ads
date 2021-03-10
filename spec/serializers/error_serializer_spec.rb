RSpec.describe ErrorSerializer do
  subject { described_class }

  describe 'from_messages' do
    context 'with single error message' do
      let(:message) { 'Error message' }

      it 'returns errors representation' do
        expect(subject.from_message(message)).to eq(
          errors: [
            { detail: message }
          ]
        )
      end
    end

    context 'with multiple error messages' do
      let(:messages) { ['Error message 1', 'Error message 2'] }

      it 'returns errors representation' do
        expect(subject.from_messages(messages)).to eq(
          errors: [
            { detail: messages[0] },
            { detail: messages[1] }
          ]
        )
      end
    end

    context 'with meta' do
      let(:message) { 'Error message' }
      let(:meta) { { level: 'error' } }

      it 'returns errors representation' do
        expect(subject.from_message(message, meta: meta)).to eq(
          errors: [
            {
              detail: message,
              meta: meta
            }
          ]
        )
      end
    end
  end

  describe 'from_model' do
    let(:model) do
      DB = Sequel.connect(ENV.fetch("DATABASE_URL"))
      DB.drop_table?(:foos)
      DB.create_table :foos do
        primary_key :id
        String :blue
        Float :green
      end

      class Foo < Sequel::Model
        plugin :validation_helpers
        attr_accessor :blue, :green


        def validate
          super
          validates_presence [:blue, :green]
          validates_includes [1] , :green
        end

        def default_validation_helpers_options(type)
          case type
          when :presence
            {message: 'не может быть пустым'}
          when :includes
            {message: 'имеет непредусмотренное значение', allow_nil: true}
          else
            super
          end
        end
      end

      Foo
    end

    let(:instanse) { model.new(params) }

    before { instanse.validate }

    context 'when attributes not set' do
      let(:params) { {} }

      it 'returns errors representation' do
        expect(subject.from_model(instanse)).to eq(
          errors: [
            {
              detail: %(не может быть пустым),
              source: {
                pointer: '/data/attributes/blue'
              }
            },
            {
              detail: %(не может быть пустым),
              source: {
                pointer: '/data/attributes/green'
              }
            }
          ]
        )
      end
    end

    context 'when wrong attribute set' do
      let(:params) {  { blue: 'a', green: 'b' } }

      it 'returns errors representation' do
        expect(subject.from_model(instanse)).to eq(
          errors: [
            {
              detail: %(имеет непредусмотренное значение),
              source: {
                pointer: '/data/attributes/green'
              }
            }
          ]
        )
      end
    end
  end
end
