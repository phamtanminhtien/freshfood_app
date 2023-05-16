import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:freshfood_app/module/auth/screens/login.dart';
import 'package:google_fonts/google_fonts.dart';
import 'module/providers/walletconnect.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => WalletProvider()),
    ], child: const FreshfoodApp()),
  );
}

const Radius navigatorBarRadius = Radius.circular(20);

class FreshfoodApp extends StatelessWidget {
  const FreshfoodApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fresh Food App',
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: GoogleFonts.getFont('Poppins').fontFamily,
      ),
      home: const FreshFoodHomePage(title: 'Fresh Food App'),
    );
  }
}

class FreshFoodHomePage extends StatefulWidget {
  const FreshFoodHomePage({super.key, required this.title});

  final String title;

  @override
  State<FreshFoodHomePage> createState() => _FreshFoodHomePageState();
}

class _FreshFoodHomePageState extends State<FreshFoodHomePage> {
  @override
  void initState() {
    super.initState();
    WalletProvider walletProvider =
        Provider.of<WalletProvider>(context, listen: false);
    walletProvider.initWalletConnect();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: LoginScreen(),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
