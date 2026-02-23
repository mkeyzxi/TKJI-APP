import 'package:flutter/material.dart';
import '../utils/constants.dart';
import 'biodata_screen.dart';
import 'history_screen.dart';
import 'quick_calculate_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [_HomeContent(), HistoryScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        backgroundColor: Colors.white,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Riwayat'),
        ],
      ),
    );
  }
}

class _HomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Kebugaran Jasmani',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.primary,
        elevation: 0,
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Card
            _buildWelcomeCard(),
            SizedBox(height: 32),

            // Quick Actions
            Text('Mulai Tes', style: AppTextStyles.heading2),
            SizedBox(height: 16),
            _buildActionCard(
              context,
              icon: Icons.fitness_center,
              title: 'Tes TKJI Baru',
              subtitle: 'Lakukan tes kesegaran jasmani',
              color: AppColors.primary,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BiodataScreen()),
                );
              },
            ),
            SizedBox(height: 16),
            _buildActionCard(
              context,
              icon: Icons.calculate,
              title: 'Hitung Skor Langsung',
              subtitle: 'Kalkulasi skor tanpa biodata',
              color: Colors.indigo,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuickCalculateScreen(),
                  ),
                );
              },
            ),
            SizedBox(height: 24),

            // Info Section
            Text('Tentang TKJI', style: AppTextStyles.heading2),
            SizedBox(height: 16),
            _buildInfoCard(
              title: 'Tes Kesegaran Jasmani Indonesia',
              description:
                  'TKJI adalah tes standar untuk mengukur tingkat kesegaran jasmani seseorang. Tes ini terdiri dari 5 komponen utama yang mengukur berbagai aspek kebugaran.',
              icon: Icons.info_outline,
            ),
            SizedBox(height: 16),
            _buildInfoCard(
              title: '5 Komponen Tes',
              description:
                  '• Lari 60 meter\n• Gantung Angkat Tubuh\n• Baring Duduk (Sit-up)\n• Loncat Tegak\n• Lari Jarak Jauh (1000m/1200m)',
              icon: Icons.list,
            ),
            SizedBox(height: 16),
            _buildInfoCard(
              title: 'Kategori Hasil',
              description:
                  '• 22-25: Baik Sekali\n• 18-21: Baik\n• 14-17: Sedang\n• 10-13: Kurang\n• 5-9: Kurang Sekali',
              icon: Icons.assessment,
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeCard() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.primary.withOpacity(0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Selamat Datang!',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Aplikasi Tes Kesegaran Jasmani Indonesia (TKJI)',
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 14,
            ),
          ),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.info, size: 16, color: Colors.white),
                SizedBox(width: 8),
                Text(
                  'Ukur kesegaran jasmani Anda',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(child: Icon(icon, color: color, size: 30)),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTextStyles.subheading),
                  SizedBox(height: 4),
                  Text(subtitle, style: AppTextStyles.caption),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: color, size: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required String title,
    required String description,
    required IconData icon,
  }) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.surface, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: AppColors.primary, size: 24),
              SizedBox(width: 12),
              Expanded(child: Text(title, style: AppTextStyles.subheading)),
            ],
          ),
          SizedBox(height: 12),
          Text(
            description,
            style: AppTextStyles.bodyText.copyWith(
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
