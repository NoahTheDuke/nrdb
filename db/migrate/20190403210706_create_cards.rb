class CreateCards < ActiveRecord::Migration[5.1]
  def change
    create_table :cards do |t|

      t.integer :advancement_requirement
      t.integer :agenda_points
      t.integer :base_link
      t.integer :cost
      t.integer :deck_limit
      t.text :faction, null: false
      t.integer :influence_cost
      t.integer :influence_limit
      t.integer :memory_cost
      t.integer :minimum_deck_size
      t.text :side
      t.integer :strength
      t.text :subtype
      t.text :text
      t.text :title, null: false
      t.integer :trash_cost
      t.text :type, null: false
      t.boolean :unique, null: false

      t.timestamps
    end
  end
end
