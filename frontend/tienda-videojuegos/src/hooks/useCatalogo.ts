import { useState, useEffect } from 'react';
import { type Videojuego, getCatalogos } from '../services/api';

export const useCatalogo = () => {
  const [juegos, setJuegos] = useState<Videojuego[]>([]);
  const [loading, setLoading] = useState<boolean>(true);
  const [error, setError] = useState<string | null>(null);

  const cargarCatalogo = async () => {
    try {
      setLoading(true);
      const data = await getCatalogos();
      setJuegos(data);
      setError(null);
    } catch (err: any) {
      setError(err.message);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    cargarCatalogo();
  }, []);

  return { juegos, loading, error, recargar: cargarCatalogo };
};