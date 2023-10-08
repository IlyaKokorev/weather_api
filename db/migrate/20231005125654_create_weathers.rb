# frozen_string_literal: true

class CreateWeathers < ActiveRecord::Migration[7.0]
  def change
    create_table :weathers do |t|
      t.float :temperature
      t.datetime :timestamp

      t.timestamps
    end
  end
end
