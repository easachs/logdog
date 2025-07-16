require 'rails_helper'

RSpec.describe User, type: :model do
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
end
