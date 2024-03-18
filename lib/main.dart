import 'package:astronomy_gallery/data/datasource/remote/api/apod_api.dart';
import 'package:astronomy_gallery/data/repositories/apod_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:astronomy_gallery/presentation/home/ui/home_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final dio = Dio();
    return RepositoryProvider(
      create: (context) => APODRepository(apodApi: APODApi(dio)),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: HomePage(),
      ),
    );
  }
}
