class OrdenesCaoticasController < ApplicationController
  # Requiere autenticación - heredado del concern Authentication
  before_action :set_filters

  def index
    @ordenes = OrdenCaotica.recientes
                            .por_ciudad(@ciudad)
                            .por_vendedor(@vendedor)
                            .por_cliente(@busqueda)

    @total_ventas      = OrdenCaotica.total_ventas
    @total_ordenes     = OrdenCaotica.count
    @clientes_unicos   = OrdenCaotica.clientes_unicos
    @ciudades          = OrdenCaotica.ciudades
    @vendedores        = OrdenCaotica.vendedores
    @ventas_por_ciudad = OrdenCaotica.ventas_por_sucursal
    @ventas_por_vendedor = OrdenCaotica.ventas_por_vendedor
    @promedio_orden    = @total_ordenes > 0 ? (@total_ventas / @total_ordenes).round(2) : 0
  end

  private

  def set_filters
    @ciudad   = params[:ciudad]
    @vendedor = params[:vendedor]
    @busqueda = params[:q]
  end
end
