// Ok. Perfecto ahora. Lista los elementos pendientes de implementar en formato tabla. Gracias

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

// ✅ Providers
import 'providers/album_provider.dart';

// ✅ Screens
import 'screens/home_screen.dart';

void main() async {
  // Asegurar que Flutter esté inicializado antes de usar métodos async
  WidgetsFlutterBinding.ensureInitialized();

  // Ejecutar la aplicación
  runApp(const SellosEspanaApp());
}

/// Aplicación principal del Álbum de Sellos Españoles en Pesetas.
class SellosEspanaApp extends StatelessWidget {
  const SellosEspanaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // ✅ Provider principal para gestionar la colección de sellos
        ChangeNotifierProvider(
          create: (_) => AlbumProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Álbum de Sellos Españoles',
        debugShowCheckedModeBanner: false,
        
        theme: ThemeData(
          // Colores principales
          primarySwatch: Colors.brown,
          primaryColor: const Color(0xFF8B4513),
          scaffoldBackgroundColor: const Color(0xFF1A0F0A),
          
          // ✅ CORREGIDO: Asignar propiedad appBarTheme:
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF8B4513),
            foregroundColor: Color(0xFFD4AF37),
            elevation: 2,
            centerTitle: true,
          ),
          
          // Configuración de botones
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFD4AF37),
              foregroundColor: const Color(0xFF2C1810),
              elevation: 3,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          
          // Tipografía con Google Fonts
          textTheme: GoogleFonts.cormorantGaramondTextTheme(
            const TextTheme(
              headlineLarge: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2C1810),
              ),
              headlineMedium: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2C1810),
              ),
              bodyLarge: TextStyle(
                fontSize: 16,
                color: Color(0xFF4A3420),
              ),
              bodyMedium: TextStyle(
                fontSize: 14,
                color: Color(0xFF4A3420),
              ),
            ),
          ),
          
          // ✅ CORREGIDO: Usar CardThemeData
          cardTheme: CardThemeData(
            color: const Color(0xFFFAF0E6),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        
        initialRoute: '/',
        routes: {
          '/': (context) => const HomeScreen(),
        },
        
        onGenerateRoute: (settings) {
          if (settings.name == null) {
            return MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            );
          }
          return null;
        },
      ),
    );
  }
}