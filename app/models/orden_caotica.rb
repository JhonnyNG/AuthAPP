class OrdenCaotica < ApplicationRecord
  self.table_name = "ordenes_caoticas"

  # Scopes para filtros
  scope :por_ciudad, ->(ciudad) { where(sucursal_ciudad: ciudad) if ciudad.present? }
  scope :por_vendedor, ->(vendedor) { where(vendedor_nombre: vendedor) if vendedor.present? }
  scope :por_cliente, ->(q) { where("cliente_nombre ILIKE ?", "%#{q}%") if q.present? }
  scope :recientes, -> { order(fecha: :desc, id_orden: :asc) }

  # Stats helpers
  def self.total_ventas
    sum(:precio_total)
  end

  def self.clientes_unicos
    distinct.pluck(:cliente_nombre).count
  end

  def self.ciudades
    distinct.order(:sucursal_ciudad).pluck(:sucursal_ciudad)
  end

  def self.vendedores
    distinct.order(:vendedor_nombre).pluck(:vendedor_nombre)
  end

  def self.ventas_por_sucursal
    group(:sucursal_ciudad)
      .sum(:precio_total)
      .sort_by { |_, v| -v }
  end

  def self.ventas_por_vendedor
    group(:vendedor_nombre)
      .sum(:precio_total)
      .sort_by { |_, v| -v }
  end
end
