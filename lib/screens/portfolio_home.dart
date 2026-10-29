import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants.dart';
import '../widgets/common_widgets.dart';
import '../widgets/experience_item.dart';

class PortfolioHome extends StatefulWidget {
  const PortfolioHome({super.key});

  @override
  State<PortfolioHome> createState() => _PortfolioHomeState();
}

class _PortfolioHomeState extends State<PortfolioHome>
    with SingleTickerProviderStateMixin {
  late final AnimationController _blueRotationController;
  final ScrollController _scroll = ScrollController();

  final GlobalKey _homeKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _experienceKey = GlobalKey();
  final GlobalKey _certificatesKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _blueRotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
  }

  Future<void> _launchURL(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      debugPrint('Tidak dapat membuka $urlString');
    }
  }

  void _go(GlobalKey key) {
    final ctx = key.currentContext;

    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 550),
        curve: Curves.easeInOut,
        alignment: 0,
      );
    }
  }

  @override
  void dispose() {
    _blueRotationController.dispose();
    _scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // LATAR BELAKANG DENGAN GRADASI PUTIH KE BIRU ELEGAN
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [linkedinBgStart, linkedinBgEnd],
          ),
        ),
        child: SelectionArea(
          child: Stack(
            children: [
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.only(top: 76),
                  child: CustomScrollView(
                    controller: _scroll,
                    slivers: [
                      SliverToBoxAdapter(key: _homeKey, child: _hero()),
                      SliverToBoxAdapter(key: _aboutKey, child: _about()),
                      SliverToBoxAdapter(key: _skillsKey, child: _skills()),
                      SliverToBoxAdapter(
                        key: _experienceKey,
                        child: _experience(),
                      ),
                      SliverToBoxAdapter(
                        key: _certificatesKey,
                        child: _certificates(),
                      ),
                      SliverToBoxAdapter(key: _contactKey, child: _contact()),
                      SliverToBoxAdapter(child: _footer()),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Material(
                  color: linkedinCard.withValues(alpha: 0.9),
                  elevation: 2,
                  shadowColor: linkedinBlue.withValues(alpha: 0.1),
                  child: SafeArea(bottom: false, child: _nav()),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.small(
        backgroundColor: linkedinBlue,
        foregroundColor: Colors.white,
        onPressed: () => _go(_homeKey),
        child: const Icon(Icons.arrow_upward_rounded),
      ),
    );
  }

  // NAVIGASI
  Widget _nav() => Container(
        decoration: const BoxDecoration(
          color: linkedinCard,
          border: Border(bottom: BorderSide(color: linkedinBorder)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1180),
            child: LayoutBuilder(
              builder: (context, c) {
                final compact = c.maxWidth < 760;

                return Row(
                  children: [
                    const Text(
                      'Moh. Rafli Abbas',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: linkedinDarkText,
                      ),
                    ),
                    const Spacer(),
                    if (!compact) ...[
                      _navButton('Home', () => _go(_homeKey)),
                      _navButton('About', () => _go(_aboutKey)),
                      _navButton('Skills', () => _go(_skillsKey)),
                      _navButton('Pengalaman', () => _go(_experienceKey)),
                      _navButton('Sertifikat', () => _go(_certificatesKey)),
                      _navButton('Contact', () => _go(_contactKey)),
                    ] else
                      PopupMenuButton<String>(
                        icon: const Icon(Icons.menu_rounded, color: linkedinDarkText),
                        color: linkedinCard,
                        onSelected: (v) {
                          final map = {
                            'Home': _homeKey,
                            'About': _aboutKey,
                            'Skills': _skillsKey,
                            'Pengalaman': _experienceKey,
                            'Sertifikat': _certificatesKey,
                            'Contact': _contactKey,
                          };

                          final key = map[v];
                          if (key != null) _go(key);
                        },
                        itemBuilder: (_) => [
                          'Home',
                          'About',
                          'Skills',
                          'Pengalaman',
                          'Sertifikat',
                          'Contact',
                        ]
                            .map((s) => PopupMenuItem(
                                  value: s,
                                  child: Text(s, style: const TextStyle(color: linkedinDarkText)),
                                ))
                            .toList(),
                      ),
                  ],
                );
              },
            ),
          ),
        ),
      );

  Widget _navButton(String label, VoidCallback onTap) => TextButton(
        onPressed: onTap,
        child: Text(
          label,
          style: const TextStyle(
            color: linkedinMutedText,
            fontWeight: FontWeight.w600,
          ),
        ),
      );

  // HERO SECTION
  Widget _hero() => _section(
        child: LayoutBuilder(
          builder: (context, c) {
            final narrow = c.maxWidth < 760;

            final intro = Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: linkedinChipBg,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    "SELAMAT DATANG DI PORTFOLIO SAYA",
                    style: TextStyle(
                      color: linkedinBlue,
                      fontSize: 12,
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: narrow ? 38 : 56,
                      height: 1.1,
                      fontWeight: FontWeight.w800,
                      color: linkedinDarkText,
                    ),
                    children: const [
                      TextSpan(text: 'Moh Rafli\n'),
                      TextSpan(
                        text: 'Abbas',
                        style: TextStyle(color: linkedinBlue),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Academic Tutor & Researcher',
                  style: TextStyle(
                    fontSize: 20,
                    color: linkedinMutedText,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 14),
                const Text(
                  'Professional dengan pengalaman luas dalam dunia akademis, penelitian sosial & kebijakan publik, serta konsultasi proyek strategis.',
                  style: TextStyle(color: linkedinMutedText, height: 1.7, fontSize: 15),
                ),
                const SizedBox(height: 24),
                Wrap(
                  spacing: 12,
                  runSpacing: 10,
                  children: [
                    FilledButton.icon(
                      onPressed: () => _go(_experienceKey),
                      icon: const Icon(Icons.work_outline, size: 18),
                      label: const Text('Lihat Pengalaman'),
                      style: FilledButton.styleFrom(
                        backgroundColor: linkedinBlue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      ),
                    ),
                    OutlinedButton.icon(
                      onPressed: () => _go(_contactKey),
                      icon: const Icon(Icons.mail_outline, size: 18),
                      label: const Text('Hubungi Saya'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: linkedinBlue,
                        side: const BorderSide(color: linkedinBlue, width: 1.5),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                const Wrap(
                  spacing: 9,
                  runSpacing: 9,
                  children: [
                    MiniTag(text: 'Research Skills'),
                    MiniTag(text: 'Project Management'),
                    MiniTag(text: 'Lecturer'),
                  ],
                ),
              ],
            );

            final portrait = Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 240,
                    height: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: RadialGradient(
                        colors: [
                          linkedinBlue.withValues(alpha: 0.15),
                          linkedinBlue.withValues(alpha: 0.0),
                        ],
                        radius: 0.85,
                      ),
                    ),
                  ),
                  AnimatedBuilder(
                    animation: _blueRotationController,
                    builder: (context, child) {
                      final angle = _blueRotationController.value * 2 * math.pi;

                      return ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 280),
                        child: AspectRatio(
                          aspectRatio: 3 / 4,
                          child: Container(
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: SweepGradient(
                                transform: GradientRotation(angle),
                                colors: const [
                                  linkedinBlue,
                                  Color(0xFF004182),
                                  Color(0xFF70B5F9),
                                  linkedinBlue,
                                ],
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: linkedinBlue.withValues(alpha: 0.2),
                                  blurRadius: 15,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: linkedinCard,
                                borderRadius: BorderRadius.circular(17),
                              ),
                              clipBehavior: Clip.antiAlias,
                              child: Image.asset(
                                'assets/foto/profile.jpeg',
                                fit: BoxFit.cover,
                                alignment: Alignment.topCenter,
                                errorBuilder: (context, error, stackTrace) => Container(
                                  color: linkedinChipBg,
                                  child: const Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.person_outline, color: linkedinBlue, size: 48),
                                        SizedBox(height: 8),
                                        Text('Foto Profile', style: TextStyle(color: linkedinMutedText, fontSize: 12)),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            );

            return _card(
              Padding(
                padding: const EdgeInsets.all(12),
                child: narrow
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          intro,
                          const SizedBox(height: 36),
                          SizedBox(height: 330, child: portrait),
                        ],
                      )
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(flex: 6, child: intro),
                          const SizedBox(width: 40),
                          Expanded(
                            flex: 5,
                            child: SizedBox(height: 380, child: portrait),
                          ),
                        ],
                      ),
              ),
            );
          },
        ),
      );

  // ABOUT SECTION
  Widget _about() => _section(
        child: LayoutBuilder(
          builder: (context, c) {
            final narrow = c.maxWidth < 760;

            final profile = _card(
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SectionTitle(
                    icon: Icons.person_outline,
                    title: 'Tentang Saya',
                  ),
                  SizedBox(height: 14),
                  Text(
                    'Saya adalah akademisi, peneliti, dan konsultan yang berdedikasi tinggi dalam riset kebijakan pemerintahan, studi sosial, serta manajemen proyek. Dengan pengalaman mengajar di berbagai perguruan tinggi dan mengelola riset strategis.',
                    style: TextStyle(color: linkedinMutedText, height: 1.7),
                  ),
                  SizedBox(height: 20),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      FeatureWidget(
                        icon: Icons.search_rounded,
                        title: 'Academic Researcher',
                      ),
                      FeatureWidget(icon: Icons.analytics_outlined, title: 'Project Consultant'),
                      FeatureWidget(
                        icon: Icons.school_outlined,
                        title: 'Higher Ed Educator',
                      ),
                    ],
                  ),
                ],
              ),
            );

            final details = _card(
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InfoRow(
                    icon: Icons.badge_outlined,
                    label: 'Nama Lengkap',
                    value: 'Moh Rafli Abbas',
                  ),
                  InfoRow(
                    icon: Icons.alternate_email,
                    label: 'Email',
                    value: 'mohrafliabbas@gmail.com',
                  ),
                  InfoRow(
                    icon: Icons.location_on_outlined,
                    label: 'Lokasi',
                    value: 'Indonesia',
                  ),
                  InfoRow(
                    icon: Icons.card_membership_outlined,
                    label: 'Status',
                    value: 'Awardee LPDP & Academic Tutor',
                  ),
                ],
              ),
            );

            return narrow
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [profile, const SizedBox(height: 16), details],
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 6, child: profile),
                      const SizedBox(width: 18),
                      Expanded(flex: 4, child: details),
                    ],
                  );
          },
        ),
      );

  // SKILLS SECTION
  Widget _skills() => _section(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionTitle(
              icon: Icons.psychology_outlined,
              title: 'Keahlian & Kompetensi',
            ),
            const SizedBox(height: 20),
            LayoutBuilder(
              builder: (context, c) {
                final count = c.maxWidth > 900
                    ? 2
                    : c.maxWidth > 580
                    ? 2
                    : 1;

                final groups = [
                  ('Riset & Akademis', Icons.menu_book_rounded, ['Research Skills', 'Policy Analysis', 'Social Movement', 'Lecturer']),
                  ('Manajemen & Konsultansi', Icons.account_tree_outlined, ['Project Management', 'Project Consultant', 'Advocacy', 'Community Learning']),
                ];

                return Wrap(
                  spacing: 14,
                  runSpacing: 14,
                  children: groups
                      .map(
                        (g) => SizedBox(
                          width: (c.maxWidth - (count - 1) * 14) / count,
                          child: _skillCard(
                            title: g.$1,
                            icon: g.$2,
                            skills: g.$3,
                          ),
                        ),
                      )
                      .toList(),
                );
              },
            ),
          ],
        ),
      );

  Widget _skillCard({
    required String title,
    required IconData icon,
    required List<String> skills,
  }) {
    return _card(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: linkedinChipBg,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: linkedinBlue, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: linkedinDarkText,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: skills.map((s) => MiniTag(text: s)).toList(),
          ),
        ],
      ),
    );
  }

  // EXPERIENCE SECTION
  Widget _experience() => _section(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionTitle(
              icon: Icons.history_edu_outlined,
              title: 'Pengalaman Professional & Riset',
            ),
            const SizedBox(height: 20),
            _card(
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  ExperienceDetailItem(
                    title: 'Academic Tutor',
                    company: 'Universitas Terbuka · Kontrak',
                    period: 'Apr 2023 - Saat ini · 3 thn 7 bln',
                    location: 'Indonesia · Jarak jauh',
                    description:
                        'Universitas Terbuka (UT) adalah Perguruan Tinggi Negeri (PTN) ke-45 di Indonesia yang menerapkan sistem belajar terbuka dan jarak jauh. Sistem pembelajaran ini telah terbukti efektif dalam meningkatkan jangkauan dan pemerataan kesempatan pendidikan tinggi berkualitas bagi seluruh warga negara Indonesia, termasuk mereka yang tinggal di daerah terpencil.',
                    skills: ['Research Skills'],
                  ),
                  Divider(height: 32, color: linkedinBorder),
                  ExperienceDetailItem(
                    title: 'Scholarship Holder (Awardee LPDP)',
                    company: 'LPDP Kementerian Keuangan RI · Kontrak',
                    period: 'Agt 2021 - Saat ini · 5 thn 3 bln',
                    location: 'Indonesia',
                    description:
                        'Beasiswa Pendidikan Indonesia (LPDP) untuk program Magister dan Doktoral adalah program beasiswa yang didanai oleh pemerintah Indonesia dan dikelola oleh LPDP guna membiayai pendidikan tinggi di institusi dalam atau luar negeri.',
                  ),
                  Divider(height: 32, color: linkedinBorder),
                  ExperienceDetailItem(
                    title: 'Project Consultant',
                    company: 'CV Mitra Madani Indonesia · Paruh Waktu',
                    period: 'Jul 2019 - Saat ini · 7 thn 4 bln',
                    location: 'Jl. Srikandi, Pekanbaru, Riau, Indonesia',
                    description: 'Memberikan konsultasi profesional untuk berbagai perencanaan proyek dan eksekusi program.',
                  ),
                  Divider(height: 32, color: linkedinBorder),
                  ExperienceDetailItem(
                    title: 'Researcher & Project Manager',
                    company: 'Universitas Kristen Indonesia (UKI) · Purnawaktu',
                    period: 'Mei 2019 - Okt 2020 · 1 thn 6 bln',
                    location: 'Jakarta Raya, Indonesia',
                    description:
                        '• Peneliti (Researcher) di Center for Social Justice and Global Responsibility (CSJGR) (Jul 2019 - Okt 2020 · 1 thn 4 bln)\n'
                        '  Terlibat dalam riset berbasis komunitas, aktivisme, advokasi, pengabdian, serta pembelajaran dan penelitian sosial.\n\n'
                        '• Manajer Proyek (Project Manager) di Institute ASEAN Studies (IAS) (Mei 2019 - Okt 2020 · 1 thn 6 bln)\n'
                        '  Berfokus pada pilar Komunitas Sosial-Budaya ASEAN, khususnya "minoritas etnis dan gerakan sosial di Asia Tenggara".',
                    skills: ['Researcher', 'Project Management'],
                  ),
                  Divider(height: 32, color: linkedinBorder),
                  ExperienceDetailItem(
                    title: 'Researcher',
                    company: 'LK2PSP (Pusat Kajian Kebijakan Pemerintah dan Pedesaan) · Purnawaktu',
                    period: 'Apr 2015 - Des 2018 · 3 thn 9 bln',
                    location: 'Halmahera, Maluku Utara, Indonesia',
                    description:
                        'Lembaga riset yang bergerak di bidang jasa layanan konsultasi, pelatihan, dan bimbingan teknis terkait berbagai program pemerintahan daerah, desa, dan nasional.',
                  ),
                  Divider(height: 32, color: linkedinBorder),
                  ExperienceDetailItem(
                    title: 'Dosen Ilmu Politik (Lecturer Political Science)',
                    company: 'Universitas Bangka Belitung · Purnawaktu',
                    period: 'Agt 2015 - Des 2017 · 2 thn 5 bln',
                    location: 'Kepulauan Bangka Belitung, Indonesia',
                    description:
                        'Mengampu perkuliahan pada program studi Ilmu Politik serta melaksanakan riset akademis di lingkungan FISIP Universitas Bangka Belitung.',
                    skills: ['Lecturer'],
                  ),
                  Divider(height: 32, color: linkedinBorder),
                  ExperienceDetailItem(
                    title: 'Dosen Ilmu Politik (Lecturer Political Science)',
                    company: "Universitas Islam Darul 'Ulum · Purnawaktu",
                    period: 'Jul 2015 - Des 2015 · 6 bln',
                    location: 'Lamongan, Jawa Timur, Indonesia',
                    description: 'Mengajar dan membimbing mahasiswa dalam bidang studi Ilmu Politik di Universitas Islam Darul \'Ulum (UNISDA) Lamongan.',
                    skills: ['Lecturer'],
                  ),
                  Divider(height: 32, color: linkedinBorder),
                  ExperienceDetailItem(
                    title: 'Penerima Beasiswa Program Magister (BPPS)-Dikti',
                    company: 'Kementerian Pendidikan dan Kebudayaan RI · Purnawaktu',
                    period: 'Jul 2012 - Agt 2014 · 2 thn 2 bln',
                    location: 'Indonesia',
                    description: 'Penerima beasiswa penuh BPPS Dikti untuk melanjutkan studi pascasarjana jenjang Magister (S2).',
                  ),
                  Divider(height: 32, color: linkedinBorder),
                  ExperienceDetailItem(
                    title: 'Dosen Ilmu Pemerintahan (Lecturer of Governance Science)',
                    company: 'Universitas Tompotika Luwuk · Purnawaktu',
                    period: 'Mei 2007 - Agt 2010 · 3 thn 4 bln',
                    location: 'Luwuk, Sulawesi Tengah, Indonesia',
                    description: 'Mengampu mata kuliah bidang Ilmu Pemerintahan di Universitas Tompotika Luwuk Banggai.',
                    skills: ['Lecturer'],
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  // CERTIFICATES SECTION
  Widget _certificates() => _section(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionTitle(
              icon: Icons.workspace_premium_outlined,
              title: 'Sertifikat & Lisensi',
            ),
            const SizedBox(height: 6),
            const Text(
              'Sertifikasi profesional pendukung keahlian',
              style: TextStyle(color: linkedinMutedText),
            ),
            const SizedBox(height: 20),
            LayoutBuilder(
              builder: (context, c) {
                final count = c.maxWidth > 900
                    ? 3
                    : c.maxWidth > 600
                    ? 2
                    : 1;

                final certs = [
                  (
                    'Research Methodology',
                    'Sertifikasi Metodologi Riset Lanjutan',
                    'assets/certificates/research.jpeg',
                  ),
                  (
                    'Policy Analysis Expert',
                    'Pelatihan Analisis Kebijakan Publik',
                    'assets/certificates/policy.jpeg',
                  ),
                  (
                    'Project Management Professional',
                    'Sertifikasi Manajemen Proyek Strategis',
                    'assets/certificates/pm.jpeg',
                  ),
                ];

                return Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: certs
                      .map(
                        (cert) => SizedBox(
                          width: (c.maxWidth - (count - 1) * 16) / count,
                          child: _card(
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: AspectRatio(
                                    aspectRatio: 16 / 10,
                                    child: Image.asset(
                                      cert.$3,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) => Container(
                                        color: linkedinChipBg,
                                        child: const Center(
                                          child: Icon(Icons.workspace_premium, color: linkedinBlue, size: 36),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  cert.$1,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: linkedinDarkText,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  cert.$2,
                                  style: const TextStyle(color: linkedinMutedText, height: 1.5, fontSize: 13),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                      .toList(),
                );
              },
            ),
          ],
        ),
      );

  // CONTACT SECTION
  Widget _contact() => _section(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionTitle(
              icon: Icons.contact_mail_outlined,
              title: 'Hubungi Saya',
            ),
            const SizedBox(height: 6),
            const Text(
              'Mari terhubung dan berdiskusi seputar riset atau kolaborasi akademis',
              style: TextStyle(color: linkedinMutedText),
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                _contactCard(
                  icon: Icons.email_outlined,
                  title: 'Email',
                  subtitle: 'mohrafliabbas@gmail.com',
                  onTap: () => _launchURL('mailto:mohrafliabbas@gmail.com'),
                ),
                _contactCard(
                  icon: Icons.phone_android_outlined,
                  title: 'WhatsApp',
                  subtitle: '+62 823-1305-4827',
                  onTap: () => _launchURL('https://wa.me/6282313054827'),
                ),
                _contactCard(
                  icon: Icons.code,
                  title: 'LinkedIn',
                  subtitle: 'Moh Rafli Abbas',
                  onTap: () => _launchURL('https://linkedin.com/in/moh-rafli-abbas'),
                ),
              ],
            ),
          ],
        ),
      );

  Widget _contactCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 300,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: linkedinCard,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: linkedinBorder),
          boxShadow: [
            BoxShadow(
              color: linkedinBlue.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: linkedinChipBg,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: linkedinBlue, size: 22),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: linkedinDarkText,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(color: linkedinMutedText, fontSize: 12),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // FOOTER
  Widget _footer() => Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
        decoration: const BoxDecoration(
          color: linkedinCard,
          border: Border(top: BorderSide(color: linkedinBorder)),
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1180),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '© 2026 Moh. Rafli Abbas. All rights reserved.',
                  style: TextStyle(color: linkedinMutedText, fontSize: 13),
                ),
                Text(
                  'Academic Portfolio',
                  style: TextStyle(
                    color: linkedinBlue,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Widget _section({required Widget child}) {
    return SizedBox(
      width: double.infinity,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1180),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: child,
          ),
        ),
      ),
    );
  }

  Widget _card(Widget child) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: linkedinCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: linkedinBorder),
        boxShadow: [
          BoxShadow(
            color: linkedinBlue.withValues(alpha: 0.06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}