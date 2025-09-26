# == Schema Information
#
# Table name: weightlogs
#
#  id         :bigint           not null, primary key
#  weight     :decimal
#  logged_at  :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_weightlogs_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Weightlog < ApplicationRecord
  belongs_to :user

  validates :weight, presence: true, numericality: { greater_than: 0 }
  validates :logged_at, presence: true
  validates :logged_at, uniqueness: { scope: :user_id, message: "already logged for this date" }

  scope :ordered, -> { order(logged_at: :desc) }
  scope :for_date, ->(date) { where(logged_at: date.beginning_of_day..date.end_of_day) }

  def self.find_or_initialize_for_date(user, date)
    find_by(user: user, logged_at: date.beginning_of_day..date.end_of_day) || 
    new(user: user, logged_at: date)
  end
end
