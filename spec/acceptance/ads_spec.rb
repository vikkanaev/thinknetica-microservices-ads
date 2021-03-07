require_relative 'acceptance_helper'

RSpec.describe 'Ads API' do
  describe 'GET#ads' do
    it "works fine" do
      get '/'
      expect(last_response).to be_ok
      expect(last_response.body).to eq('Hello index!')
    end
  end

  describe 'POST#ads' do
    it "says yo" do
      post '/'
      expect(last_response).to be_ok
      expect(last_response.body).to eq('Yo, u can post!')
    end
  end
end
