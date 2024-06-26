import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'data/datasource/local/entities/apod_entity.dart';
import 'data/datasource/remote/api/apod_api.dart';
import 'data/repositories/apod_repository.dart';
import 'presentation/home/ui/home_page.dart';

Future main() async {
  await dotenv.load();
  await Hive.initFlutter();
  final Box box = await Hive.openBox('myBox');
  Hive.registerAdapter(APODEntityAdapter());
  runApp(const MyApp());

  WidgetsBinding.instance.addPostFrameCallback((_) {
    box.close();
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final Dio dio = Dio();
    return RepositoryProvider(
      create: (BuildContext context) => APODRepository(apodApi: APODApi(dio)),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: HomePage(),
      ),
    );
  }
}
