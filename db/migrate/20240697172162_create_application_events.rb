# frozen_string_literal: true

class CreateApplicationEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :application_events do |t|
      t.references :application, type: :uuid, foreign_key: true, null: false
      t.string :type, null: false
      t.jsonb :data

      t.timestamps
    end
  end
end
