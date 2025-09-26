require 'rails_helper'

RSpec.describe Weightlog, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
  end

  describe 'validations' do
    it { should validate_presence_of(:weight) }
    it { should validate_numericality_of(:weight).is_greater_than(0) }
    it { should validate_presence_of(:logged_at) }
  end

  describe 'uniqueness' do
    let(:user) { create(:user) }
    let!(:existing_log) { create(:weightlog, user: user, logged_at: Date.current) }

    it 'validates uniqueness of logged_at scoped to user' do
      duplicate_log = build(:weightlog, user: user, logged_at: Date.current)
      expect(duplicate_log).not_to be_valid
      expect(duplicate_log.errors[:logged_at]).to include('already logged for this date')
    end

    it 'allows same date for different users' do
      other_user = create(:user)
      other_log = build(:weightlog, user: other_user, logged_at: Date.current)
      expect(other_log).to be_valid
    end
  end

  describe 'scopes' do
    let(:user) { create(:user) }
    let!(:old_log) { create(:weightlog, user: user, logged_at: 2.days.ago) }
    let!(:new_log) { create(:weightlog, user: user, logged_at: Date.current) }

    it 'orders by logged_at desc' do
      expect(Weightlog.ordered).to eq([new_log, old_log])
    end

    it 'filters by date' do
      expect(Weightlog.for_date(Date.current)).to include(new_log)
      expect(Weightlog.for_date(Date.current)).not_to include(old_log)
    end
  end

  describe '.find_or_initialize_for_date' do
    let(:user) { create(:user) }
    let(:date) { Date.current }

    context 'when log exists for date' do
      let!(:existing_log) { create(:weightlog, user: user, logged_at: date) }

      it 'returns existing log' do
        result = Weightlog.find_or_initialize_for_date(user, date)
        expect(result).to eq(existing_log)
        expect(result).to be_persisted
      end
    end

    context 'when no log exists for date' do
      it 'returns new log with correct attributes' do
        result = Weightlog.find_or_initialize_for_date(user, date)
        expect(result).to be_new_record
        expect(result.user).to eq(user)
        expect(result.logged_at.to_date).to eq(date)
      end
    end
  end
end
