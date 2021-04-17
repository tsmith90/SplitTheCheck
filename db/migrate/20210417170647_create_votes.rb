class CreateVotes < ActiveRecord::Migration[5.2]
  def change
    create_table :votes do |t|
      t.references :restaurant, foreign_key: true
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end
  end
end
