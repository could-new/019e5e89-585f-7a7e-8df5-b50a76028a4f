import 'package:flutter/material.dart';

void main() {
  runApp(const ShreeRamApp());
}

class ShreeRamApp extends StatelessWidget {
  const ShreeRamApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shree Ram',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepOrange,
          primary: Colors.deepOrange,
          secondary: Colors.amber,
          surface: const Color(0xFFFFFDF5),
        ),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
        ),
        cardTheme: CardTheme(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MainNavigationScreen(),
      },
    );
  }
}

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const BhajansScreen(),
    const WisdomScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    // For wide screens, use a NavigationRail. For narrow screens, use BottomNavigationBar.
    final bool isWide = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      body: isWide
          ? Row(
              children: [
                NavigationRail(
                  selectedIndex: _currentIndex,
                  onDestinationSelected: (int index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  labelType: NavigationRailLabelType.all,
                  destinations: const [
                    NavigationRailDestination(
                      icon: Icon(Icons.home_outlined),
                      selectedIcon: Icon(Icons.home),
                      label: Text('Darshan'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.library_music_outlined),
                      selectedIcon: Icon(Icons.library_music),
                      label: Text('Bhajans'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.menu_book_outlined),
                      selectedIcon: Icon(Icons.menu_book),
                      label: Text('Wisdom'),
                    ),
                  ],
                ),
                const VerticalDivider(thickness: 1, width: 1),
                Expanded(child: _screens[_currentIndex]),
              ],
            )
          : _screens[_currentIndex],
      bottomNavigationBar: isWide
          ? null
          : NavigationBar(
              selectedIndex: _currentIndex,
              onDestinationSelected: (int index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.home_outlined),
                  selectedIcon: Icon(Icons.home),
                  label: 'Darshan',
                ),
                NavigationDestination(
                  icon: Icon(Icons.library_music_outlined),
                  selectedIcon: Icon(Icons.library_music),
                  label: 'Bhajans',
                ),
                NavigationDestination(
                  icon: Icon(Icons.menu_book_outlined),
                  selectedIcon: Icon(Icons.menu_book),
                  label: 'Wisdom',
                ),
              ],
            ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jai Shri Ram', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Card(
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        children: [
                          Icon(Icons.wb_sunny, size: 64, color: Theme.of(context).colorScheme.primary),
                          const SizedBox(height: 16),
                          Text(
                            'Daily Chaupai',
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'मङ्गल भवन अमङ्गल हारी।\nद्रवहु सुदसरथ अजर बिहारी॥',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20, height: 1.5, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Mangal Bhavan Amangal Haari,\nDravahu Sudasarath Ajar Bihari.',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Quick Actions',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final crossAxisCount = constraints.maxWidth > 500 ? 3 : 2;
                      return GridView.count(
                        crossAxisCount: crossAxisCount,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                        childAspectRatio: 1.2,
                        children: [
                          _buildActionCard(context, 'Aarti', Icons.local_fire_department_outlined),
                          _buildActionCard(context, 'Chalisa', Icons.menu_book_outlined),
                          _buildActionCard(context, 'Temples', Icons.temple_hindu_outlined),
                          _buildActionCard(context, 'Donate', Icons.volunteer_activism_outlined),
                        ],
                      );
                    }
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionCard(BuildContext context, String title, IconData icon) {
    return Card(
      elevation: 1,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Opening $title...')),
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 36, color: Theme.of(context).colorScheme.primary),
            const SizedBox(height: 12),
            Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }
}

class BhajansScreen extends StatelessWidget {
  const BhajansScreen({super.key});

  final List<Map<String, String>> _bhajans = const [
    {'title': 'Shri Ram Chandra Kripalu', 'duration': '5:42'},
    {'title': 'Mangal Bhavan Amangal Hari', 'duration': '8:15'},
    {'title': 'Ram Siya Ram', 'duration': '4:30'},
    {'title': 'Hum Katha Sunate', 'duration': '10:05'},
    {'title': 'Kabhi Ram Banke', 'duration': '6:20'},
    {'title': 'Raghupati Raghav Raja Ram', 'duration': '5:10'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bhajans & Chants'),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _bhajans.length,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) {
          final bhajan = _bhajans[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              child: const Icon(Icons.music_note),
            ),
            title: Text(bhajan['title']!),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(bhajan['duration']!),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.play_circle_outline),
                  color: Theme.of(context).colorScheme.primary,
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Playing ${bhajan['title']}')),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class WisdomScreen extends StatelessWidget {
  const WisdomScreen({super.key});

  final List<Map<String, String>> _kandas = const [
    {'title': 'Bala Kanda', 'desc': 'The childhood and early life of Lord Ram.'},
    {'title': 'Ayodhya Kanda', 'desc': 'The preparations for Ram\\'s crowning and his exile.'},
    {'title': 'Aranya Kanda', 'desc': 'Life in the forest and Sita\\'s abduction.'},
    {'title': 'Kishkindha Kanda', 'desc': 'Meeting Hanuman and the Vanara army.'},
    {'title': 'Sundara Kanda', 'desc': 'Hanuman\\'s journey to Lanka and discovery of Sita.'},
    {'title': 'Yuddha Kanda', 'desc': 'The great war between Ram and Ravana.'},
    {'title': 'Uttara Kanda', 'desc': 'Ram\\'s return to Ayodhya and his reign.'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ramayana Epic'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _kandas.length,
                itemBuilder: (context, index) {
                  final kanda = _kandas[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ExpansionTile(
                      leading: CircleAvatar(
                        backgroundColor: Theme.of(context).colorScheme.secondary,
                        foregroundColor: Colors.white,
                        child: Text('${index + 1}'),
                      ),
                      title: Text(kanda['title']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            kanda['desc']!,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        }
      ),
    );
  }
}
