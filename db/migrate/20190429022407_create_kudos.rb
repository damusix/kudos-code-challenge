class CreateKudos < ActiveRecord::Migration[5.2]
  def change
    create_table :kudos do |t|
      t.integer :amount
      t.string :comment

      t.timestamps
    end

    add_reference :kudos, :from, references: :users, index: true
    add_reference :kudos, :to, references: :users, index: true
    add_foreign_key :kudos, :users, column: :from_id
    add_foreign_key :kudos, :users, column: :to_id

  end
end
