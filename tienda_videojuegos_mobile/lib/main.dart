import 'package:flutter/material.dart';
import 'models/videojuego.dart';
import 'services/api_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tienda de Videojuegos',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const CatalogoPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CatalogoPage extends StatefulWidget {
  const CatalogoPage({super.key});

  @override
  State<CatalogoPage> createState() => _CatalogoPageState();
}

class _CatalogoPageState extends State<CatalogoPage> {
  late Future<List<Videojuego>> _futureVideojuegos;

  @override
  void initState() {
    super.initState();
    _refreshCatalogo();
  }

  void _refreshCatalogo() {
    setState(() {
      _futureVideojuegos = ApiService.fetchVideojuegos();
    });
  }

  void _comprar(int idVideojuego) async {
    bool exito = await ApiService.procesarVenta(idVideojuego, 1);
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          exito ? '¡Venta registrada con éxito!' : 'Error al procesar la compra',
        ),
        backgroundColor: exito ? Colors.green : Colors.red,
      ),
    );

    if (exito) {
      _refreshCatalogo();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catálogo de Videojuegos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _refreshCatalogo,
          )
        ],
      ),
      body: FutureBuilder<List<Videojuego>>(
        future: _futureVideojuegos,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay videojuegos disponibles.'));
          }

          final juegos = snapshot.data!;
          return ListView.builder(
            itemCount: juegos.length,
            itemBuilder: (context, index) {
              final juego = juegos[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                child: ListTile(
                  title: Text(
                    juego.titulo,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    '${juego.plataforma} | ${juego.genero}\nStock: ${juego.stock}',
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Q${juego.precio.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      const SizedBox(height: 4),
                      ElevatedButton(
                        onPressed: juego.stock > 0 ? () => _comprar(juego.id) : null,
                        child: Text(juego.stock > 0 ? 'Comprar' : 'Agotado'),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}