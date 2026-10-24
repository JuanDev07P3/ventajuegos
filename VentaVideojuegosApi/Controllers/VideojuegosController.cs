using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using VentaVideojuegosApi.Data;
using VentaVideojuegosApi.DTOs;

namespace VentaVideojuegosApi.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class VideojuegosController : ControllerBase
    {
        private readonly VentaVideojuegosDbContext _context;

        public VideojuegosController(VentaVideojuegosDbContext context)
        {
            _context = context;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<VideojuegoDto>>> GetVideojuegos()
        {
            var juegos = await _context.Videojuegos
                .Select(v => new VideojuegoDto
                {
                    Id = v.IdVideojuego,
                    Titulo = v.Titulo,
                    Plataforma = v.Plataforma,
                    Genero = v.Genero,
                    Precio = v.Precio,
                    Stock = v.Stock
                })
                .ToListAsync();

            return Ok(juegos);
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<VideojuegoDto>> GetVideojuego(int id)
        {
            var juego = await _context.Videojuegos.FindAsync(id);
            if (juego == null) return NotFound("Videojuego no encontrado");

            return Ok(new VideojuegoDto
            {
                Id = juego.IdVideojuego,
                Titulo = juego.Titulo,
                Plataforma = juego.Plataforma,
                Genero = juego.Genero,
                Precio = juego.Precio,
                Stock = juego.Stock
            });
        }
    }
}