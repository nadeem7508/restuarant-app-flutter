
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

import 'package:zainab_restuarant_app/app.dart';
import 'package:zainab_restuarant_app/firebase_options.dart';
import 'package:zainab_restuarant_app/pages/app/provider/cart_provider.dart';
import 'package:zainab_restuarant_app/pages/app/provider/favorites_provider.dart';

Future<void> main() async {

 WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);

 await GetStorage.init(); // Initialize local storage
  runApp(
     MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => FavoritesProvider()), // Initialize FavoriteProvider
        ChangeNotifierProvider(create: (context) => CartProvider()), // Initialize cartprovider
      ],
   child: const App()));
}


