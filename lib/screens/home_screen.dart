import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/luxury_book.dart';
import '../widgets/era_navigation.dart';
import 'era_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _selectedEraId;

  @override
  Widget build(BuildContext context) {
    print('🏠 HOME SCREEN BUILD - _selectedEraId: $_selectedEraId');
    final isMobile = MediaQuery.of(context).size.width < 800;

    return Scaffold(
      backgroundColor: const Color(0xFF1A0F0A),
      body: isMobile ? _buildMobileLayout() : _buildDesktopLayout(),
    );
  }

  Widget _buildDesktopLayout() {
    print('🖥️ _buildDesktopLayout() - Era: $_selectedEraId');

    return Row(
      children: [
        EraNavigation(
          width: 300,
          selectedEraId: _selectedEraId,
          onEraSelected: (eraId) {
            print('🔘 Era seleccionada: $eraId');
            setState(() => _selectedEraId = eraId);
          },
          onHeaderTap: () {
            print('🏠 Header tap - Volviendo al inicio');
            setState(() => _selectedEraId = null);
          },
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: LuxuryBook(
              title: 'Álbum de Sellos Españoles',
              subtitle: 'Colección en Pesetas',
              maxWidth: 1400,
              child: _buildBookContent(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout() {
    print('📱 _buildMobileLayout() - Era: $_selectedEraId');

    return Column(
      children: [
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
          leading: IconButton(
            icon: const Icon(Icons.home, color: Color(0xFFD4AF37)),
            onPressed: () {
              print('🏠 Botón home móvil');
              setState(() => _selectedEraId = null);
            },
            tooltip: 'Volver al inicio',
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.menu_book, color: Color(0xFFD4AF37)),
              onPressed: () => _showEraSelector(),
              tooltip: 'Seleccionar época',
            ),
          ],
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: LuxuryBook(
              title: 'Álbum de Sellos Españoles',
              subtitle: 'Colección en Pesetas',
              child: _buildBookContent(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBookContent() {
    print('📚 _buildBookContent() - _selectedEraId: $_selectedEraId');

    if (_selectedEraId == null) {
      print('📚 Mostrando página de bienvenida');
      return _buildWelcomePage();
    } else {
      print('📚 Mostrando EraScreen para: $_selectedEraId');
      return EraScreen(eraId: _selectedEraId!);
    }
  }

  void _showEraSelector() {
    print('📋 _showEraSelector()');

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
            print('🔘 Era desde bottom sheet: $eraId');
            setState(() => _selectedEraId = eraId);
            Navigator.pop(context);
          },
          onHeaderTap: () {
            setState(() => _selectedEraId = null);
            Navigator.pop(context);
          },
        );
      },
    );
  }

  Widget _buildWelcomePage() {
    print('👋 _buildWelcomePage() renderizado');

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: const Color(0xFFD4AF37).withValues(alpha: 0.2),
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFFD4AF37), width: 3),
            ),
            child: const Icon(
              Icons.auto_stories,
              size: 80,
              color: Color(0xFFD4AF37),
            ),
          ),
          const SizedBox(height: 30),
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
          Text(
            'Selecciona una época del menú lateral\npara comenzar tu colección',
            textAlign: TextAlign.center,
            style: GoogleFonts.cormorantGaramond(
              fontSize: 18,
              color: Color(0xFF6B4423),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 40),
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
          ElevatedButton.icon(
            icon: const Icon(Icons.explore),
            label: const Text(
              'Abrir Sobre',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFD4AF37),
              foregroundColor: const Color(0xFF2C1810),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            ),
            onPressed: () {
              print('🔘 Botón "Abrir Sobre" pulsado');
              setState(() => _selectedEraId = 'isabel_ii');
            },
          ),
        ],
      ),
    );
  }

  Widget _buildInstructionStep(
    IconData icon,
    String title,
    String description,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: const Color(0xFF6B4423), size: 24),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.cormorantGaramond(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF5A3921),
                ),
              ),
              Text(
                description,
                style: GoogleFonts.cormorantGaramond(
                  fontSize: 14,
                  color: const Color(0xFF7B5A3A),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
