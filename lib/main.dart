import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:window_manager/window_manager.dart';

import 'providers/album_provider.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
    size: Size(1280, 800),
    minimumSize: Size(800, 600),
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.normal,
    windowButtonVisibility: true,
  );

  await windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
    await windowManager.maximize();
  });

  print('🚀 MAIN() EJECUTADO');
  print('🚀 Iniciando Álbum de Sellos Españoles...');

  runApp(const SellosEspanaApp());
}

class SellosEspanaApp extends StatelessWidget {
  const SellosEspanaApp({super.key});

  @override
  Widget build(BuildContext context) {
    print('🔍 SellosEspanaApp.build() EJECUTADO');

    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AlbumProvider())],
      child: MaterialApp(
        title: 'Álbum de Sellos Españoles',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.brown,
          primaryColor: const Color(0xFF8B4513),
          scaffoldBackgroundColor: const Color(0xFF1A0F0A),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF8B4513),
            foregroundColor: Color(0xFFD4AF37),
            elevation: 2,
            centerTitle: true,
          ),
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
          cardTheme: CardThemeData(
            color: const Color(0xFFFAF0E6),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
