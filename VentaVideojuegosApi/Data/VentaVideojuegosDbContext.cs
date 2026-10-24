using Microsoft.EntityFrameworkCore;

namespace VentaVideojuegosApi.Data
{
    public class VentaVideojuegosDbContext : DbContext
    {
        public VentaVideojuegosDbContext(DbContextOptions<VentaVideojuegosDbContext> options) : base(options) { }

        public DbSet<Cliente> Clientes => Set<Cliente>();
        public DbSet<Videojuego> Videojuegos => Set<Videojuego>();
        public DbSet<MetodoPago> MetodosPago => Set<MetodoPago>();
        public DbSet<Venta> Ventas => Set<Venta>();
        public DbSet<DetalleVenta> DetalleVentas => Set<DetalleVenta>();

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Cliente>().HasKey(c => c.IdCliente);
            modelBuilder.Entity<Videojuego>().HasKey(v => v.IdVideojuego);
            modelBuilder.Entity<MetodoPago>().HasKey(m => m.IdMetodoPago);
            modelBuilder.Entity<Venta>().HasKey(v => v.IdVenta);
            modelBuilder.Entity<DetalleVenta>().HasKey(d => d.IdDetalle);

            modelBuilder.Entity<Venta>()
                .HasOne(v => v.Cliente)
                .WithMany()
                .HasForeignKey(v => v.IdCliente);

            modelBuilder.Entity<Venta>()
                .HasOne(v => v.MetodoPago)
                .WithMany()
                .HasForeignKey(v => v.IdMetodoPago);

            modelBuilder.Entity<DetalleVenta>()
                .HasOne(d => d.Venta)
                .WithMany(v => v.Detalles)
                .HasForeignKey(d => d.IdVenta);

            modelBuilder.Entity<DetalleVenta>()
                .HasOne(d => d.Videojuego)
                .WithMany()
                .HasForeignKey(d => d.IdVideojuego);
        }
    }

    public class Cliente { public int IdCliente { get; set; } public string Nombre { get; set; } = ""; public string Correo { get; set; } = ""; public string Ciudad { get; set; } = ""; }
    public class Videojuego { public int IdVideojuego { get; set; } public string Titulo { get; set; } = ""; public string Plataforma { get; set; } = ""; public string Genero { get; set; } = ""; public decimal Precio { get; set; } public int Stock { get; set; } }
    public class MetodoPago { public int IdMetodoPago { get; set; } public string Metodo { get; set; } = ""; public string Descripcion { get; set; } = ""; public bool Activo { get; set; } }
    public class Venta { public int IdVenta { get; set; } public DateTime Fecha { get; set; } public int IdCliente { get; set; } public Cliente? Cliente { get; set; } public int IdMetodoPago { get; set; } public MetodoPago? MetodoPago { get; set; } public decimal Total { get; set; } public List<DetalleVenta> Detalles { get; set; } = new(); }
    public class DetalleVenta { public int IdDetalle { get; set; } public int IdVenta { get; set; } public Venta? Venta { get; set; } public int IdVideojuego { get; set; } public Videojuego? Videojuego { get; set; } public int Cantidad { get; set; } public decimal PrecioUnitario { get; set; } }
}