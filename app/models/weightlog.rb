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
end
