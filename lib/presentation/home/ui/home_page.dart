import 'package:astronomy_gallery/data/repositories/apod_repository.dart';
import 'package:astronomy_gallery/presentation/home/cubit/home_cubit.dart';
import 'package:astronomy_gallery/presentation/home/ui/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          HomeCubit(context.read<APODRepository>())..getAstronomyPictures(),
      child: const HomeView(),
    );
  }
}
