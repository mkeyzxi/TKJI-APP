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
        title: const Text(
          'MAPP-FIT',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.primary,
        elevation: 0,
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Welcome Card
            _buildWelcomeCard(),

            const SizedBox(height: 32),

            // 2. Quick Actions Section
            Text('Mulai Tes', style: AppTextStyles.heading2),
            const SizedBox(height: 16),
            _buildActionCard(
              context,
              icon: Icons.fitness_center,
              title: 'Tes TKJI Baru',
              subtitle: 'Lakukan tes kesegaran jasmani',
              color: AppColors.primary,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BiodataScreen()),
              ),
            ),
            const SizedBox(height: 16),
            _buildActionCard(
              context,
              icon: Icons.calculate,
              title: 'Hitung Skor Langsung',
              subtitle: 'Kalkulasi skor tanpa biodata',
              color: Colors.indigo,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => QuickCalculateScreen()),
              ),
            ),

            const SizedBox(height: 32),

            // 3. Info Section - Menggunakan Component List (Bukan bullet point lagi)
            Text('Tentang TKJI', style: AppTextStyles.heading2),
            const SizedBox(height: 16),
            _buildInfoCard(
              title: 'Tes Kesegaran Jasmani Indonesia',
              description:
                  'TKJI adalah tes standar untuk mengukur tingkat kesegaran jasmani seseorang melalui 5 komponen uji fisik.',
              icon: Icons.info_outline,
            ),

            const SizedBox(height: 16),

            // CARD KOMPONEN BARU (Tanpa Simbol "•")
            _buildDetailedComponentCard(),

            const SizedBox(height: 32),

            // 4. Tabel Standar Penilaian
            Text('Standar Penilaian TKJI', style: AppTextStyles.heading2),
            const SizedBox(height: 16),
            _buildTKJITable(
              title: "Norma Penilaian TKJI Putra",
              data: [
                ['5', '< 7,2', '> 19', '> 41', '> 73', '< 3’14”'],
                ['4', '7,3–8,3', '14–18', '30–40', '60–72', '3’15”–4’25”'],
                ['3', '8,4–9,6', '9–13', '21–29', '50–59', '4’26”–5’12”'],
                ['2', '9,7–11,0', '5–8', '10–20', '39–49', '5’13”–6’33”'],
                ['1', '> 11,1', '0–4', '0–9', '< 38', '> 6’34”'],
              ],
            ),
            const SizedBox(height: 20),
            _buildTKJITable(
              title: "Norma Penilaian TKJI Putri",
              data: [
                ['5', '< 8,4', '> 40', '> 29', '> 50', '< 3’52”'],
                ['4', '8,5–9,8', '20–39', '20–28', '39–49', '3’53”–4’56”'],
                ['3', '9,9–11,4', '8–19', '10–19', '31–38', '4’57”–5’58”'],
                ['2', '11,5–13,4', '2–7', '3–9', '23–30', '5’59”–7’23”'],
                ['1', '> 13,5', '0–2', '0–2', '< 23', '> 7’23”'],
              ],
            ),

            const SizedBox(height: 32),

            // 5. Kategori Hasil (Desain Baru)
            _buildScoreCategoryCard(),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  // WIDGET BARU: List Komponen dengan Ikon
  Widget _buildDetailedComponentCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              // Icon(Icons.list_alt_rounded, color: AppColors.primary),
              // SizedBox(width: 10),
              Text('5 Komponen Tes', style: AppTextStyles.subheading),
            ],
          ),
          const SizedBox(height: 16),
          _buildComponentItem(
            Icons.speed,
            'Lari 60 Meter',
            'Tes kecepatan sprint',
          ),
          _buildDivider(),
          _buildComponentItem(
            Icons.accessibility_new,
            'Gantung Angkat/Menahan',
            'Putra: Angkat Tubuh | Putri: Menahan',
          ),
          _buildDivider(),
          _buildComponentItem(
            Icons.fitness_center,
            'Baring Duduk',
            'Sit-up selama 60 detik',
          ),
          _buildDivider(),
          _buildComponentItem(
            Icons.height,
            'Loncat Tegak',
            'Vertical jump untuk daya ledak',
          ),
          _buildDivider(),
          _buildComponentItem(
            Icons.directions_run,
            'Lari Jarak Jauh',
            'Putra: 1200m | Putri: 1000m',
          ),
        ],
      ),
    );
  }

  Widget _buildComponentItem(IconData icon, String title, String subtitle) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: AppColors.primary, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTextStyles.subheading.copyWith(fontSize: 14),
              ),
              Text(
                subtitle,
                style: AppTextStyles.caption.copyWith(color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // WIDGET BARU: Kategori Skor yang lebih bersih
  Widget _buildScoreCategoryCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        // Menggunakan warna putih dengan border halus agar selaras dengan kartu lainnya
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primary.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.stars_rounded, color: AppColors.primary, size: 20),
              const SizedBox(width: 8),
              const Text(
                'Kategori Hasil Akhir',
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Menggunakan skema warna yang lebih "lembut" dan konsisten
          _buildScoreRow('22 - 25', 'Baik Sekali', Colors.blue.shade700),
          _buildScoreRow('18 - 21', 'Baik', Colors.green.shade600),
          _buildScoreRow('14 - 17', 'Sedang', Colors.orange.shade700),
          _buildScoreRow('10 - 13', 'Kurang', Colors.red.shade600),
          _buildScoreRow('05 - 09', 'Kurang Sekali', Colors.red.shade900),
        ],
      ),
    );
  }

  Widget _buildScoreRow(String range, String label, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Label Skor
          Text(
            range,
            style: TextStyle(
              color: Colors.grey.shade700,
              fontWeight: FontWeight.w600,
            ),
          ),
          // Badge Kategori
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              // Warna background mengikuti warna kategori tapi sangat transparan
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(
                20,
              ), // Membuat bentuk pill/kapsul
              border: Border.all(color: color.withOpacity(0.3)),
            ),
            child: Text(
              label,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() => Divider(color: Colors.grey.shade100, height: 20);
}

Widget _buildWelcomeCard() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 20,
    ), // Padding lebih proporsional
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [AppColors.primary, AppColors.primary.withOpacity(0.8)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Row Atas: Icon dan Judul (Tanpa Container tambahan)
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8), // rounded dikit aja
              child: Image.asset(
                "assets/icon/icon-tkji.png",
                height: 45,
                width: 45,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Text(
                'Selamat Datang!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Judul Deskripsi
        const Text(
          'Apa itu MAPP-FIT?',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 6),

        // Teks Definisi (Langsung di atas background utama)
        Text(
          'Mappideceng Assessment of Physical Performance, Fitness, and Integrated Technology (MAPP-FIT) adalah sistem asesmen kebugaran jasmani berbasis instrumen tes dan pengukuran standar yang terintegrasi dengan teknologi digital, berlandaskan filosofi Mappideceng (Bugis-Makassar) sebagai prinsip perbaikan kualitas raga secara terukur dan berkelanjutan.',
          textAlign: TextAlign.justify,
          style: TextStyle(
            color: Colors.white.withOpacity(0.9),
            fontSize: 12,
            height:
                1.4, // Line height tidak terlalu renggang tapi tetap terbaca
            fontFamily: 'Poppins',
          ),
        ),

        const SizedBox(height: 16),

        // Footer: Info Ringkas
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(
              0.1,
            ), // Efek gelap tipis agar badge menonjol
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.info_outline, size: 14, color: Colors.white),
              SizedBox(width: 6),
              Text(
                'Ukur kesegaran jasmani Anda sekarang',
                style: TextStyle(color: Colors.white, fontSize: 11),
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

Widget _buildTKJITable({
  required String title,
  required List<List<String>> data,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(title, style: AppTextStyles.subheading),
      const SizedBox(height: 12),
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.surface, width: 1),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: [
              DataColumn(label: Text('Skor')),
              DataColumn(label: Text('Lari 60m')),
              DataColumn(label: Text('Gantung')),
              DataColumn(label: Text('Sit-up')),
              DataColumn(label: Text('Loncat')),
              if (title.contains('Putra'))
                DataColumn(label: Text('Lari 1200m'))
              else
                DataColumn(label: Text('Lari 1000m')),
            ],
            rows: data
                .map(
                  (row) => DataRow(
                    cells: row.map((cell) => DataCell(Text(cell))).toList(),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    ],
  );
}
