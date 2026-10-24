namespace VentaVideojuegosApi.DTOs
{
    public class VideojuegoDto
    {
        public int Id { get; set; }
        public string Titulo { get; set; } = string.Empty;
        public string Plataforma { get; set; } = string.Empty;
        public string Genero { get; set; } = string.Empty;
        public decimal Precio { get; set; }
        public int Stock { get; set; }
        public string EstadoVenta => Stock >= 20 ? "Venta permitida" : "Stock insuficiente";
    }

    public class RegistrarVentaDto
    {
        public int IdCliente { get; set; }
        public int IdMetodoPago { get; set; }
        public List<DetalleItemDto> Detalles { get; set; } = new();
    }

    public class DetalleItemDto
    {
        public int IdVideojuego { get; set; }
        public int Cantidad { get; set; }
    }
}