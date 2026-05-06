# ═══════════════════════════════════════════════════════════
#  Seeds — Market Caótica
#  Datos de órdenes del mini market boliviano
# ═══════════════════════════════════════════════════════════

puts "🛒 Iniciando seeds de Market Caótica..."

# Limpiar tabla para evitar duplicados en redeploys
OrdenCaotica.delete_all

ordenes = [
  { id_orden: 1,  fecha: '2023-10-01', cliente_nombre: 'Juan Perez',    cliente_dni: '12345',  cliente_direccion: 'Calle Falsa 123',  items_comprados: 'Arroz, Leche',          sucursal_nombre: 'Sucursal Norte', sucursal_ciudad: 'Santa Cruz',  vendedor_nombre: 'Carlos Gomez',  precio_total: 50.00 },
  { id_orden: 2,  fecha: '2023-10-01', cliente_nombre: 'Ana Lopez',     cliente_dni: '67890',  cliente_direccion: 'Av. Bush 456',     items_comprados: 'Pan, Cafe',             sucursal_nombre: 'Sucursal Norte', sucursal_ciudad: 'Santa Cruz',  vendedor_nombre: 'Carlos Gomez',  precio_total: 30.00 },
  { id_orden: 3,  fecha: '2023-10-02', cliente_nombre: 'Juan Perez',    cliente_dni: '12345',  cliente_direccion: 'Calle Falsa 123',  items_comprados: 'Soda',                  sucursal_nombre: 'Sucursal Sur',   sucursal_ciudad: 'La Paz',      vendedor_nombre: 'Maria Rojas',   precio_total: 10.00 },
  { id_orden: 4,  fecha: '2023-10-02', cliente_nombre: 'Ricardo Sosa',  cliente_dni: '11223',  cliente_direccion: 'Calle Aroma 78',   items_comprados: 'Leche, Galletas',       sucursal_nombre: 'Sucursal Norte', sucursal_ciudad: 'Santa Cruz',  vendedor_nombre: 'Carlos Gomez',  precio_total: 25.50 },
  { id_orden: 5,  fecha: '2023-10-03', cliente_nombre: 'Juan Perez',    cliente_dni: '12345',  cliente_direccion: 'Calle Falsa 123',  items_comprados: 'Aceite',                sucursal_nombre: 'Sucursal Norte', sucursal_ciudad: 'Santa Cruz',  vendedor_nombre: 'Carlos Gomez',  precio_total: 15.00 },
  { id_orden: 6,  fecha: '2023-10-03', cliente_nombre: 'Ana Lopez',     cliente_dni: '67890',  cliente_direccion: 'Av. Bush 456',     items_comprados: 'Fideos, Salsa',         sucursal_nombre: 'Sucursal Sur',   sucursal_ciudad: 'La Paz',      vendedor_nombre: 'Maria Rojas',   precio_total: 22.00 },
  { id_orden: 7,  fecha: '2023-10-04', cliente_nombre: 'Marta Quiroga', cliente_dni: '44556',  cliente_direccion: 'Calle Mexico 10',  items_comprados: 'Manzanas, Peras',       sucursal_nombre: 'Sucursal Este',  sucursal_ciudad: 'Cochabamba',  vendedor_nombre: 'Jose Mamani',   precio_total: 18.00 },
  { id_orden: 8,  fecha: '2023-10-04', cliente_nombre: 'Ricardo Sosa',  cliente_dni: '11223',  cliente_direccion: 'Calle Aroma 78',   items_comprados: 'Detergente',            sucursal_nombre: 'Sucursal Este',  sucursal_ciudad: 'Cochabamba',  vendedor_nombre: 'Jose Mamani',   precio_total: 40.00 },
  { id_orden: 9,  fecha: '2023-10-05', cliente_nombre: 'Juan Perez',    cliente_dni: '12345',  cliente_direccion: 'Calle Nueva 999',  items_comprados: 'Papel Higienico',       sucursal_nombre: 'Sucursal Norte', sucursal_ciudad: 'Santa Cruz',  vendedor_nombre: 'Carlos Gomez',  precio_total: 12.00 },
  { id_orden: 10, fecha: '2023-10-05', cliente_nombre: 'Marta Quiroga', cliente_dni: '44556',  cliente_direccion: 'Calle Mexico 10',  items_comprados: 'Carne de Res',          sucursal_nombre: 'Sucursal Sur',   sucursal_ciudad: 'La Paz',      vendedor_nombre: 'Maria Rojas',   precio_total: 60.00 },
  { id_orden: 11, fecha: '2023-10-06', cliente_nombre: 'Ana Lopez',     cliente_dni: '67890',  cliente_direccion: 'Av. Bush 456',     items_comprados: 'Shampoo',               sucursal_nombre: 'Sucursal Norte', sucursal_ciudad: 'Santa Cruz',  vendedor_nombre: 'Carlos Gomez',  precio_total: 35.00 },
  { id_orden: 12, fecha: '2023-10-06', cliente_nombre: 'Carlos Ruiz',   cliente_dni: '99887',  cliente_direccion: 'Calle Lanza 5',    items_comprados: 'Pilas, Linterna',       sucursal_nombre: 'Sucursal Este',  sucursal_ciudad: 'Cochabamba',  vendedor_nombre: 'Jose Mamani',   precio_total: 100.00 },
  { id_orden: 13, fecha: '2023-10-07', cliente_nombre: 'Ricardo Sosa',  cliente_dni: '11223',  cliente_direccion: 'Calle Aroma 78',   items_comprados: 'Yogurt',                sucursal_nombre: 'Sucursal Norte', sucursal_ciudad: 'Santa Cruz',  vendedor_nombre: 'Carlos Gomez',  precio_total: 8.50 },
  { id_orden: 14, fecha: '2023-10-07', cliente_nombre: 'Marta Quiroga', cliente_dni: '44556',  cliente_direccion: 'Calle Mexico 10',  items_comprados: 'Jugo de Naranja',       sucursal_nombre: 'Sucursal Este',  sucursal_ciudad: 'Cochabamba',  vendedor_nombre: 'Jose Mamani',   precio_total: 14.00 },
  { id_orden: 15, fecha: '2023-10-08', cliente_nombre: 'Juan Perez',    cliente_dni: '12345',  cliente_direccion: 'Calle Nueva 999',  items_comprados: 'Pan, Mantequilla',      sucursal_nombre: 'Sucursal Sur',   sucursal_ciudad: 'La Paz',      vendedor_nombre: 'Maria Rojas',   precio_total: 20.00 }
]

OrdenCaotica.insert_all(ordenes.map { |o| o.merge(created_at: Time.current, updated_at: Time.current) })

puts "✅ #{OrdenCaotica.count} órdenes insertadas correctamente."
puts "💰 Total ventas: Bs. #{OrdenCaotica.sum(:precio_total)}"
puts "🏙️  Ciudades: #{OrdenCaotica.distinct.pluck(:sucursal_ciudad).join(', ')}"
