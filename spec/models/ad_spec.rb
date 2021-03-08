require_relative '../spec_helper'
require_relative '../../models/ad'

RSpec.describe Ad do
  describe 'create' do
    subject { described_class.create(params) }

    context 'when valid params' do
      let(:params) { { title: 'one', description: 'one more ad', city: 'MSK', user_id: 1 } }

      it 'creates new ad' do
        expect { subject }.to change {Ad.count}.by(1)
      end
    end

    context 'when title nil' do
      let(:params) { { description: 'one more ad', city: 'MSK', user_id: 1 } }

      it 'raise title cannot be empty' do
        expect { subject }.to raise_error Sequel::ValidationFailed, 'title is not present'
      end
    end

    context 'when city nil' do
      let(:params) { { title: 'one', description: 'one more ad', city: 'MSK' } }

      it 'raise city cannot be empty' do
        expect { subject }.to raise_error Sequel::ValidationFailed, 'user_id is not present'
      end
    end
  end
end
