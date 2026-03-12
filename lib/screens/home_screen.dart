import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/luxury_book.dart';
import '../widgets/era_navigation.dart';
import 'era_screen.dart';

/// Pantalla principal del álbum de sellos.
/// 
/// Esta pantalla integra:
/// - Panel lateral de navegación por épocas (EraNavigation)
/// - Libro de lujo como contenedor principal (LuxuryBook)
/// - Contenido dinámico según la época seleccionada (EraScreen)
/// 
/// Diseñada para ser responsive en Windows (escritorio) y dispositivos móviles.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // ID de la época actualmente seleccionada
  String? _selectedEraId;

  @override
  Widget build(BuildContext context) {
    // Detectar si es dispositivo móvil o escritorio
    final isMobile = MediaQuery.of(context).size.width < 800;

    return Scaffold(
      backgroundColor: const Color(0xFF1A0F0A),
      
      body: isMobile
          ? _buildMobileLayout()
          : _buildDesktopLayout(),
    );
  }

  /// Layout para escritorio: panel lateral + libro principal
  Widget _buildDesktopLayout() {
    return Row(
      children: [
        // Panel lateral de navegación (épocas)
        EraNavigation(
          width: 300,
          selectedEraId: _selectedEraId,
          onEraSelected: (eraId) {
            setState(() {
              _selectedEraId = eraId;
            });
          },
        ),
        
        // Área principal con el libro de lujo
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: LuxuryBook(
              title: 'Álbum de Sellos Españoles',
              subtitle: 'Colección en Pesetas',
              maxWidth: 1400,
              child: _selectedEraId == null
                  ? _buildWelcomePage()
                  : EraScreen(eraId: _selectedEraId!),
            ),
          ),
        ),
      ],
    );
  }

  /// Layout para móvil: AppBar + contenido
  Widget _buildMobileLayout() {
    return Column(
      children: [
        // AppBar personalizada
        AppBar(
          title: Text(
            'Álbum de Sellos',
            style: GoogleFonts.cinzel(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: const Color(0xFFD4AF37),
            ),
          ),
          backgroundColor: const Color(0xFF8B4513),
          elevation: 2,
          actions: [
            // Botón para seleccionar época
            IconButton(
              icon: const Icon(Icons.menu_book, color: Color(0xFFD4AF37)),
              onPressed: () => _showEraSelector(),
              tooltip: 'Seleccionar época',
            ),
          ],
        ),
        
        // Contenido principal
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: LuxuryBook(
              title: 'Álbum de Sellos Españoles',
              subtitle: 'Colección en Pesetas',
              child: _selectedEraId == null
                  ? _buildWelcomePage()
                  : EraScreen(eraId: _selectedEraId!),
            ),
          ),
        ),
      ],
    );
  }

  /// Muestra un dialog para seleccionar época (móvil)
  void _showEraSelector() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF2C1810),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return EraNavigation(
          width: double.infinity,
          selectedEraId: _selectedEraId,
          onEraSelected: (eraId) {
            setState(() {
              _selectedEraId = eraId;
            });
            Navigator.pop(context);
          },
        );
      },
    );
  }

  /// Página de bienvenida cuando no hay época seleccionada
  Widget _buildWelcomePage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icono decorativo
          Container(
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: const Color(0xFFD4AF37).withOpacity(0.2),
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0xFFD4AF37),
                width: 3,
              ),
            ),
            child: const Icon(
              Icons.auto_stories,
              size: 80,
              color: Color(0xFFD4AF37),
            ),
          ),
          
          const SizedBox(height: 30),
          
          // Título de bienvenida
          Text(
            'Bienvenido a tu Álbum de Sellos',
            style: GoogleFonts.cinzel(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF2C1810),
            ),
            textAlign: TextAlign.center,
          ),
          
          const SizedBox(height: 15),
          
          // Subtítulo descriptivo
          Text(
            'Selecciona una época del menú lateral\npara comenzar tu colección',
            textAlign: TextAlign.center,
            style: GoogleFonts.cormorantGaramond(
              fontSize: 18,
              color: Colors.brown[700],
              height: 1.5,
            ),
          ),
          
          const SizedBox(height: 40),
          
          // Instrucciones
          _buildInstructionStep(
            Icons.touch_app,
            '1. Selecciona una época',
            'Explora las 6 épocas históricas',
          ),
          
          _buildInstructionStep(
            Icons.shopping_bag,
            '2. Abre sobres sorpresa',
            'Consigue sellos aleatorios',
          ),
          
          _buildInstructionStep(
            Icons.bookmark,
            '3. Completa tu álbum',
            'Colecciona todos los sellos',
          ),
          
          const SizedBox(height: 30),
          
          // Botón de acción
          ElevatedButton.icon(
            icon: const Icon(Icons.explore),
            label: const Text(
              'Comenzar Colección',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFD4AF37),
              foregroundColor: const Color(0xFF2C1810),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            ),
            onPressed: () {
              // Seleccionar primera época por defecto
              setState(() {
                _selectedEraId = 'isabel_ii';
              });
            },
          ),
        ],
      ),
    );
  }

  /// Widget para cada paso de instrucción
  Widget _buildInstructionStep(IconData icon, String title, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.brown[700], size: 24),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.cormorantGaramond(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown[800],
                ),
              ),
              Text(
                description,
                style: GoogleFonts.cormorantGaramond(
                  fontSize: 14,
                  color: Colors.brown[600],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}