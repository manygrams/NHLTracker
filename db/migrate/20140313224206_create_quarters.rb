class CreateQuarters < ActiveRecord::Migration
  def change
    create_table :quarters do |t|
      t.datetime :starts_at
      t.datetime :ends_at

      t.timestamps
    end
  end
end
