# frozen_string_literal: true

class CreateJobs < ActiveRecord::Migration[7.0]
  def change
    create_table :jobs, id: :uuid do |t|
      t.string :title
      t.text :description
      t.jsonb :data

      t.timestamps
    end
  end
end
