require_relative 'requests_helper'

RSpec.describe 'Ads API' do
  describe 'GET /' do

    before { create_list(:ad, 3) }

    it 'returns a collection of ads' do
      get '/'

      expect(last_response).to be_ok
      expect(JSON.parse(last_response.body)['data'].size).to eq(3)
    end
  end

  describe 'POST / (valid auth token)' do
    let(:headers) { {'CONTENT_TYPE' => 'application/json'} }
    context 'missing parameters' do
      it 'returns an error' do
        post '/'

        expect(last_response).to be_unprocessable
      end
    end

    context 'invalid parameters' do
      let(:body) do
        {
          ad:
            {
              title: 'Ad title',
              description: 'Ad description',
              city: '',
              user_id: 1
            }
        }.to_json
      end

      it 'returns an error' do
        post '/', body, headers

        expect(last_response).to be_unprocessable
        expect(JSON.parse(last_response.body)['errors']).to include(
          {
            'detail' => 'Укажите город',
            'source' => {
              'pointer' => '/data/attributes/city'
            }
          }
        )
      end
    end
    #
    context 'valid parameters' do
      let(:body) do
        {
          ad:
            {
              title: 'Ad title',
              description: 'Ad description',
              city: 'MSK',
              user_id: 1
            }
        }.to_json
      end

      it 'creates a new ad' do
        expect { post '/', body, headers }.to change { Ad.where(user_id: 1).count }.from(0).to(1)

        expect(last_response.status).to eq(201)
      end

      it 'returns an ad' do
        post '/', body, headers

        expect(JSON.parse(last_response.body)['data']).to a_hash_including(
          'id' => Ad.last.id.to_s,
          'type' => 'ad'
        )
      end
    end
  end
end
