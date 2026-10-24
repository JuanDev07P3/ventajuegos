class Videojuego {
  final int id;
  final String titulo;
  final String plataforma;
  final String genero;
  final double precio;
  final int stock;
  final String estadoVenta;

  Videojuego({
    required this.id,
    required this.titulo,
    required this.plataforma,
    required this.genero,
    required this.precio,
    required this.stock,
    required this.estadoVenta,
  });

  factory Videojuego.fromJson(Map<String, dynamic> json) {
    return Videojuego(
      id: json['id'],
      titulo: json['titulo'] ?? '',
      plataforma: json['plataforma'] ?? '',
      genero: json['genero'] ?? '',
      precio: (json['precio'] as num).toDouble(),
      stock: json['stock'] ?? 0,
      estadoVenta: json['estadoVenta'] ?? '',
    );
  }
}