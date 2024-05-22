import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:thecodystoreadminpanel/inner_screens/add_product.dart';
import 'package:thecodystoreadminpanel/screens/main_screen.dart';
import 'consts/theme_data.dart';
import 'controllers/MenuController.dart';
import 'providers/dark_theme_provider.dart';
import 'firebase_options.dart';

void main() async{
  
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(  options: DefaultFirebaseOptions.currentPlatform,);
    runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();
  void getCurrentAppTheme() async {
    themeChangeProvider.setDarkTheme =
        await themeChangeProvider.darkThemePreference.getTheme();
  }

  @override
  void initState() {
    getCurrentAppTheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CustomMenuController(),
        ),
        ChangeNotifierProvider(
          create: (_) {
            return themeChangeProvider;
          },
        ),
      ],
      child: Consumer<DarkThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'The Cody Store Admin Panel',
            theme: Styles.themeData(themeProvider.getDarkTheme, context),
            home: const MainScreen(),
            builder: EasyLoading.init(),
            routes: {
                UploadProductForm.routeName: (context) =>
                    const UploadProductForm(),
              }
          );
        },
      ),
    );
  }
}
