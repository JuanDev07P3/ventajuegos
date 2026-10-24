import React, { useState } from 'react';
import { useCatalogo } from '../hooks/useCatalogo';
import { procesarVenta } from '../services/api';

export const TiendaVideojuegos: React.FC = () => {
  const { juegos, loading, error, recargar } = useCatalogo();
  const [mensaje, setMensaje] = useState<string | null>(null);

  const handleComprar = async (idVideojuego: number) => {
    try {
      setMensaje(null);
      await procesarVenta(1, 1, idVideojuego, 1);
      setMensaje('¡Venta realizada exitosamente!');
      recargar();
    } catch (err: any) {
      setMensaje(`Error: ${err.message}`);
    }
  };

  if (loading) return <p>Cargando catálogo...</p>;
  if (error) return <p style={{ color: 'red' }}>Error: {error}</p>;

  return (
    <div style={{ padding: '20px', fontFamily: 'sans-serif' }}>
      <h2>Tienda de Videojuegos</h2>
      {mensaje && (
        <div style={{ padding: '10px', background: '#e2e2e2', color: '#333', marginBottom: '15px' }}>
          {mensaje}
        </div>
      )}

      <table border={1} cellPadding={10} style={{ borderCollapse: 'collapse', width: '100%' }}>
        <thead>
          <tr style={{ background: '#f4f4f4', color: '#000' }}>
            <th>ID</th>
            <th>Título</th>
            <th>Plataforma</th>
            <th>Género</th>
            <th>Precio</th>
            <th>Stock</th>
            <th>Estado</th>
            <th>Acción</th>
          </tr>
        </thead>
        <tbody>
          {juegos.map((juego) => (
            <tr key={juego.id}>
              <td>{juego.id}</td>
              <td>{juego.titulo}</td>
              <td>{juego.plataforma}</td>
              <td>{juego.genero}</td>
              <td>Q{juego.precio.toFixed(2)}</td>
              <td>{juego.stock}</td>
              <td>{juego.estadoVenta}</td>
              <td>
                <button
                  disabled={juego.stock <= 0}
                  onClick={() => handleComprar(juego.id)}
                >
                  {juego.stock > 0 ? 'Comprar 1' : 'Agotado'}
                </button>
              </td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
};