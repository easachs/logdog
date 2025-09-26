require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many(:workouts).dependent(:destroy) }
    it { should have_many(:weightlogs).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
  end

  describe 'devise modules' do
    it 'includes the expected devise modules' do
      expect(User.devise_modules).to include(:database_authenticatable)
      expect(User.devise_modules).to include(:registerable)
      expect(User.devise_modules).to include(:recoverable)
      expect(User.devise_modules).to include(:rememberable)
      expect(User.devise_modules).to include(:validatable)
      expect(User.devise_modules).to include(:omniauthable)
    end
  end

  describe '.from_omniauth' do
    let(:auth) do
      OmniAuth::AuthHash.new(
        provider: 'google_oauth2',
        uid: '123456789',
        info: {
          email: 'test@example.com'
        }
      )
    end

    context 'when user does not exist' do
      it 'creates a new user' do
        expect {
          User.from_omniauth(auth)
        }.to change(User, :count).by(1)
      end

      it 'sets the correct attributes' do
        user = User.from_omniauth(auth)
        expect(user.provider).to eq('google_oauth2')
        expect(user.uid).to eq('123456789')
        expect(user.email).to eq('test@example.com')
      end
    end

    context 'when user already exists' do
      let!(:existing_user) { create(:user, provider: 'google_oauth2', uid: '123456789', email: 'test@example.com') }

      it 'does not create a new user' do
        expect {
          User.from_omniauth(auth)
        }.not_to change(User, :count)
      end

      it 'returns the existing user' do
        user = User.from_omniauth(auth)
        expect(user).to eq(existing_user)
      end
    end
  end

  describe 'weight metrics' do
    let(:user) { create(:user) }

    context 'with no weight logs' do
      it 'returns empty metrics' do
        expect(user.weight_metrics).to eq({})
      end
    end

    context 'with weight logs' do
      before do
        create(:weightlog, user: user, weight: 180.0, logged_at: 3.days.ago)
        create(:weightlog, user: user, weight: 179.5, logged_at: 2.days.ago)
        create(:weightlog, user: user, weight: 179.0, logged_at: 1.day.ago)
        create(:weightlog, user: user, weight: 178.5, logged_at: Date.current)
      end

      it 'calculates max weight' do
        expect(user.max_weight).to eq(180.0)
      end

      it 'calculates min weight' do
        expect(user.min_weight).to eq(178.5)
      end

      it 'calculates weight range' do
        expect(user.weight_range).to eq(1.5)
      end

      it 'calculates average weight' do
        expect(user.average_weight).to eq(179.3)
      end

      it 'returns most recent weight' do
        expect(user.most_recent_weight).to eq(178.5)
      end

      it 'calculates weight this week' do
        expect(user.weight_this_week).to eq(4)
      end

      it 'calculates days since last log' do
        expect(user.days_since_last_log).to eq(0)
      end

      it 'calculates logging streak' do
        expect(user.logging_streak).to eq(4)
      end

      it 'provides chart data' do
        chart_data = user.weight_chart_data
        expect(chart_data).to be_an(Array)
        expect(chart_data.length).to eq(4)
        expect(chart_data.first).to include(Date.current.strftime('%Y-%m-%d'))
        expect(chart_data.first).to include(178.5)
      end
    end
  end
end
