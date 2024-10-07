import 'package:flutter/material.dart';
import 'package:infinitie_list/presentation/counter/bloc/counter_bloc.dart';
import 'package:infinitie_list/presentation/counter/view/counter_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterScreen extends StatelessWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CounterBloc(),
      child: const CounterView(),
    );
  }
}
