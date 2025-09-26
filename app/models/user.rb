# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at   :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  provider               :string
#  uid                    :string
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [ :google_oauth2 ]

  has_many :workouts, dependent: :destroy
  has_many :weightlogs, dependent: :destroy

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
    end
  end

  # Weight metrics methods
  def weight_metrics
    return {} if weightlogs.empty?

    {
      max_weight: max_weight,
      min_weight: min_weight,
      weight_range: weight_range,
      average_weight: average_weight,
      most_recent_weight: most_recent_weight,
      weight_this_week: weight_this_week,
      days_since_last_log: days_since_last_log,
      weekly_change_percent: weekly_change_percent,
      logging_streak: logging_streak
    }
  end

  def max_weight
    weightlogs.maximum(:weight)
  end

  def min_weight
    weightlogs.minimum(:weight)
  end

  def weight_range
    return 0 if max_weight.nil? || min_weight.nil?
    max_weight - min_weight
  end

  def average_weight
    weightlogs.average(:weight)&.to_f&.round(1)
  end

  def most_recent_weight
    weightlogs.ordered.first&.weight
  end

  def weight_this_week
    start_of_week = Date.current.beginning_of_week
    end_of_week = Date.current.end_of_week
    weightlogs.where(logged_at: start_of_week..end_of_week).count
  end

  def days_since_last_log
    return nil if weightlogs.empty?
    last_log = weightlogs.ordered.first
    return nil unless last_log
    (Date.current - last_log.logged_at.to_date).to_i
  end

  def weekly_change_percent
    return nil if weightlogs.count < 2
    
    current_week = weightlogs.where(logged_at: Date.current.beginning_of_week..Date.current.end_of_week)
    last_week = weightlogs.where(logged_at: 1.week.ago.beginning_of_week..1.week.ago.end_of_week)
    
    return nil if current_week.empty? || last_week.empty?
    
    current_avg = current_week.average(:weight)
    last_avg = last_week.average(:weight)
    
    return nil if current_avg.nil? || last_avg.nil? || last_avg.zero?
    
    ((current_avg - last_avg) / last_avg * 100).round(1)
  end

  def logging_streak
    return 0 if weightlogs.empty?
    
    streak = 0
    current_date = Date.current
    
    while weightlogs.where(logged_at: current_date.beginning_of_day..current_date.end_of_day).exists?
      streak += 1
      current_date -= 1.day
    end
    
    streak
  end

  def weight_chart_data
    weightlogs.ordered.limit(30).map do |log|
      [log.logged_at.strftime('%Y-%m-%d'), log.weight.to_f]
    end
  end
end
