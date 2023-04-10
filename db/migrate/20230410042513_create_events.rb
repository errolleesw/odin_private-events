class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.string :event_title
      t.date :event_date

      t.timestamps
    end
  end
end
