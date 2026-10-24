export interface Videojuego {
  id: number;
  titulo: string;
  plataforma: string;
  genero: string;
  precio: number;
  stock: number;
  estadoVenta: string;
}

const API_BASE_URL = import.meta.env.VITE_API_URL || 'http://localhost:5285/api';

export const getCatalogos = async (): Promise<Videojuego[]> => {
  // Cambiamos /productos por /videojuegos
  const response = await fetch(`${API_BASE_URL}/videojuegos`);
  if (!response.ok) throw new Error('Error al cargar el catálogo');
  return response.json();
};

export const procesarVenta = async (idCliente: number, idMetodoPago: number, idVideojuego: number, cantidad: number) => {
  const response = await fetch(`${API_BASE_URL}/ventas`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({
      idCliente,
      idMetodoPago,
      detalles: [{ idVideojuego, cantidad }]
    })
  });

  if (!response.ok) {
    const errorMsg = await response.text();
    throw new Error(errorMsg || 'Error al procesar la venta');
  }

  return response.json();
};