import 'package:flutter/material.dart';
import 'package:pizzeria/models/cart.dart';
import 'package:pizzeria/ui/boisson_list.dart';
import 'package:pizzeria/ui/confirmation.dart';
import 'package:pizzeria/ui/panier.dart';
import 'package:pizzeria/ui/pizza_list.dart';
import 'package:pizzeria/ui/salade_list.dart';
import 'package:pizzeria/ui/dessert_list.dart';
import 'package:pizzeria/ui/profil.dart';
import 'package:provider/provider.dart';
import 'models/menu.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => Cart(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pizzéria',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.amber,
        primaryColor: Colors.amber,
        scaffoldBackgroundColor: const Color(0xFF121212),
        colorScheme: const ColorScheme.dark(
          primary: Colors.amber,
          secondary: Colors.amberAccent,
          surface: Color(0xFF1E1E1E),
        ),
        cardTheme: CardThemeData(
          color: const Color(0xFF1E1E1E),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: Colors.white.withOpacity(0.05)),
          ),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF121212),
          elevation: 0,
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.amber),
          titleTextStyle: TextStyle(
            color: Colors.amber,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color(0xFF1E1E1E),
          selectedItemColor: Colors.amber,
          unselectedItemColor: Colors.white60,
          elevation: 10,
          type: BottomNavigationBarType.fixed,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.amber,
            foregroundColor: Colors.black,
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            textStyle: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold),
          titleLarge: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          bodyLarge: TextStyle(color: Colors.white70),
          bodyMedium: TextStyle(color: Colors.white60),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MainScreen(),
        '/panier': (context) => const Panier(),
        '/confirmation': (context) => const Confirmation(),
        '/profil': (context) => const Profil(),
      },
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  void _onItemTapped(int index) {
    if (index == _selectedIndex) {
      // Pop to root of the current tab if tapped again
      _navigatorKeys[index].currentState?.popUntil((route) => route.isFirst);
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var cart = context.watch<Cart>();
    int totalItems = cart.totalItems();

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) return;
        final NavigatorState? navigator = _navigatorKeys[_selectedIndex].currentState;
        if (navigator != null && navigator.canPop()) {
          navigator.pop();
        } else if (_selectedIndex != 0) {
          setState(() {
            _selectedIndex = 0;
          });
        }
      },
      child: Scaffold(
        body: IndexedStack(
          index: _selectedIndex,
          children: [
            _buildNavigator(0, const MyHomePageContent()),
            _buildNavigator(1, const Panier()),
            _buildNavigator(2, const Profil()),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            const BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Accueil',
            ),
            BottomNavigationBarItem(
              icon: Badge(
                label: Text('$totalItems'),
                isLabelVisible: totalItems > 0,
                child: const Icon(Icons.shopping_cart_outlined),
              ),
              activeIcon: Badge(
                label: Text('$totalItems'),
                isLabelVisible: totalItems > 0,
                child: const Icon(Icons.shopping_cart),
              ),
              label: 'Panier',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: 'Profil',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }

  Widget _buildNavigator(int index, Widget rootPage) {
    return Navigator(
      key: _navigatorKeys[index],
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          settings: settings,
          builder: (context) {
            // Handle named routes inside tabs
            if (settings.name == '/confirmation') {
              return const Confirmation();
            }
            return rootPage;
          },
        );
      },
    );
  }
}

class MyHomePageContent extends StatelessWidget {
  const MyHomePageContent({super.key});

  final _menus = const [
    Menu(1, 'Salades', 'salade.jpg', Colors.lightGreen),
    Menu(2, 'Pizzas', 'pizza.jpg', Colors.redAccent),
    Menu(3, 'Desserts', 'dessert.jpg', Colors.brown),
    Menu(4, 'Boissons', 'boisson.jpg', Colors.lightBlue),
  ];

  @override
  Widget build(BuildContext context) {
    var cart = context.watch<Cart>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('NOTRE PIZZÉRIA'),
      ),
      body: ListView.builder(
        itemCount: _menus.length,
        itemBuilder: (context, index) => InkWell(
          onTap: () {
            switch (_menus[index].type) {
              case 1: // Salades
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SaladeList()),
                );
                break;
              case 2: // Pizza
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PizzaList(cart: cart)),
                );
                break;
              case 3: // Desserts
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DessertList()),
                );
                break;
              case 4: // Boissons
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const BoissonList()),
                );
                break;
              default:
              // Assuming there is a default case or handling for other types
            }
          },
          child: _buildRow(_menus[index]),
        ),
        itemExtent: 180,
      ),
    );
  }

  Widget _buildRow(Menu menu) {
    return Container(
      height: 180,
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: const BorderRadius.all(Radius.circular(16.0)),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(16.0)),
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: Image.asset(
                'assets/images/menus/${menu.image}',
                fit: BoxFit.cover,
                color: Colors.black.withOpacity(0.3),
                colorBlendMode: BlendMode.darken,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withOpacity(0.8),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              left: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    menu.title.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontFamily: 'Roboto',
                      fontSize: 28,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
