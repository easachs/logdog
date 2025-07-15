class CreateWeightlog < ActiveRecord::Migration[8.0]
  def change
    create_table :weightlogs do |t|
      t.references :user, null: false, foreign_key: true
      t.decimal :weight
      t.datetime :logged_at

      t.timestamps
    end
  end
end
