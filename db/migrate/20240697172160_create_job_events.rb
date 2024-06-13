# frozen_string_literal: true

class CreateJobEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :job_events, id: :uuid do |t|
      t.references :job, type: :uuid, foreign_key: true, null: false
      t.string :type, null: false
      t.jsonb :data

      t.timestamps
    end
  end
end
