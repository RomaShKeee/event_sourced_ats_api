# frozen_string_literal: true

class CreateApplications < ActiveRecord::Migration[7.0]
  def change
    create_table :applications, id: :uuid do |t|
      t.string :candidate_name
      t.references :job, type: :uuid, null: false, foreign_key: true
      t.jsonb :data

      t.timestamps
    end
  end
end
