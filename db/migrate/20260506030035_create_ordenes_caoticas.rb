class CreateOrdenesCaoticas < ActiveRecord::Migration[8.0]
  def change
    create_table :ordenes_caoticas do |t|
      t.integer :id_orden
      t.date :fecha
      t.string :cliente_nombre
      t.string :cliente_dni
      t.string :cliente_direccion
      t.text :items_comprados
      t.string :sucursal_nombre
      t.string :sucursal_ciudad
      t.string :vendedor_nombre
      t.decimal :precio_total, precision: 10, scale: 2

      t.timestamps
    end
  end
end
