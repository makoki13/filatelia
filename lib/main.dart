// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:window_manager/window_manager.dart';

// ✅ Providers
import 'providers/album_provider.dart';

// ✅ Screens
import 'screens/home_screen.dart';

void main() async {
  // Asegurar que Flutter esté inicializado antes de usar métodos async
  WidgetsFlutterBinding.ensureInitialized();

  // ✅ Inicializar window_manager para Windows
  await windowManager.ensureInitialized();

  // ✅ Configurar opciones de la ventana para Windows
  WindowOptions windowOptions = const WindowOptions(
    size: Size(1280, 800),
    minimumSize: Size(800, 600),
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.normal,
    windowButtonVisibility: true,
  );

  // ✅ Aplicar configuración de ventana
  await windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
    await windowManager.maximize(); // ✅ Ventana maximizada al inicio
  });

  // ✅ Debug: Verificar que main se ejecuta
  print('🚀 MAIN() EJECUTADO');
  print('🚀 Iniciando Álbum de Sellos Españoles...');

  // Ejecutar la aplicación
  runApp(const SellosEspanaApp());
}

/// Aplicación principal del Álbum de Sellos Españoles en Pesetas.
class SellosEspanaApp extends StatelessWidget {
  const SellosEspanaApp({super.key});

  @override
  Widget build(BuildContext context) {
    print('🔍 SellosEspanaApp.build() EJECUTADO');

    return MultiProvider(
      providers: [
        // ✅ Provider principal para gestionar la colección de sellos
        ChangeNotifierProvider(create: (_) => AlbumProvider()),
      ],
      child: MaterialApp(
        // ═══════════════════════════════════════════════════════════════
        // CONFIGURACIÓN BÁSICA
        // ═══════════════════════════════════════════════════════════════
        title: 'Álbum de Sellos Españoles',
        debugShowCheckedModeBanner: false,

        // ✅ DEBUG: Verificar navegación
        navigatorObservers: [RouteObserver<Route>()],

        // ═══════════════════════════════════════════════════════════════
        // TEMA Y ESTILOS
        // ═══════════════════════════════════════════════════════════════
        theme: ThemeData(
          // Colores principales inspirados en cuero y oro
          primarySwatch: Colors.brown,
          primaryColor: const Color(0xFF8B4513),
          scaffoldBackgroundColor: const Color(0xFF1A0F0A),

          // Configuración de AppBar
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
              bodyLarge: TextStyle(fontSize: 16, color: Color(0xFF4A3420)),
              bodyMedium: TextStyle(fontSize: 14, color: Color(0xFF4A3420)),
            ),
          ),

          // Configuración de tarjetas
          cardTheme: CardThemeData(
            color: const Color(0xFFFAF0E6),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),

        // ═══════════════════════════════════════════════════════════════
        // RUTAS DE NAVEGACIÓN
        // ═══════════════════════════════════════════════════════════════
        // ✅ OPCIÓN 1: Usar home (recomendado para app simple)
        home: const HomeScreen(),

        // ✅ OPCIÓN 2: Usar initialRoute (alternativa)
        // initialRoute: '/',
        // routes: {
        //   '/': (context) => const HomeScreen(),
        // },

        // ═══════════════════════════════════════════════════════════════
        // CONFIGURACIÓN DE ERRORES DE RUTA
        // ═══════════════════════════════════════════════════════════════
        onGenerateRoute: (settings) {
          print('🔍 onGenerateRoute: ${settings.name}');

          // Manejo de rutas no encontradas
          if (settings.name == null) {
            print('⚠️ Ruta nula, redirigiendo a HomeScreen');
            return MaterialPageRoute(builder: (context) => const HomeScreen());
          }

          // Rutas adicionales (futuras)
          switch (settings.name) {
            case '/':
              print('✅ Ruta: / → HomeScreen');
              return MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              );
            // 🔜 Futuras rutas:
            // case '/era':
            //   return MaterialPageRoute(
            //     builder: (context) => EraScreen(eraId: settings.arguments as String),
            //   );
            // case '/series':
            //   return MaterialPageRoute(
            //     builder: (context) => SeriesScreen(series: settings.arguments as Series),
            //   );
            default:
              print('⚠️ Ruta no encontrada: ${settings.name}');
              return null;
          }
        },

        // ═══════════════════════════════════════════════════════════════
        // CONFIGURACIÓN MULTIPLATAFORMA
        // ═══════════════════════════════════════════════════════════════
        // El layout se adapta automáticamente gracias al diseño responsive
        // de los widgets (LuxuryBook, EraNavigation, etc.)
      ),
    );
  }
}
