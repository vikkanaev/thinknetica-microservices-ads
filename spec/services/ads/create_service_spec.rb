RSpec.describe Ads::CreateService do
  subject { described_class }

  let(:user_id) { 1 }

  context 'valid parameters' do
    let(:ad_params) do
      {
        title: 'Ad title',
        description: 'Ad description',
        city: 'City',
        user_id: user_id
      }
    end

    it 'creates a new ad' do
      expect { subject.call(ad: ad_params) }
        .to change { Ad.where(user_id: user_id).count }.from(0).to(1)
    end

    it 'assigns ad' do
      result = subject.call(ad: ad_params)

      expect(result.ad).to be_kind_of(Ad)
    end

    it 'calls geocoding service' do
      expect(Ads::GeocodingService).to receive(:call).with(ad: kind_of(Ad))
      subject.call(ad: ad_params)
    end
  end

  context 'invalid parameters' do
    let(:ad_params) do
      {
        title: 'Ad title',
        description: 'Ad description',
        city: '',
        user_id: user_id
      }
    end

    it 'does not create ad' do
      expect { subject.call(ad: ad_params) }
        .not_to change { Ad.count }
    end

    it 'assigns ad' do
      result = subject.call(ad: ad_params)

      expect(result.ad).to be_kind_of(Ad)
    end

    it 'does not call geocoding service' do
      expect(Ads::GeocodingService).to_not receive(:call)
      subject.call(ad: ad_params)
    end
  end
end
