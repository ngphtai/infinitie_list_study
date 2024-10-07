import 'package:flutter/material.dart';
import 'package:infinitie_list/presentation/counter/bloc/counter_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterView extends StatelessWidget {
  const CounterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Counter"),
      ),
      body: Center(
        child: BlocBuilder<CounterBloc, CounterState>(
          builder: (context, state) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                BlocListener<CounterBloc, CounterState>(
                  listenWhen: (previous, current) => current.count % 10 == 0,
                  listener: (context, state) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("reached ${state.count} !")));
                  },
                  child: BlocBuilder<CounterBloc, CounterState>(
                    builder: (context, state) {
                      return Text('Counter: ${state.count}',
                          style: Theme.of(context).textTheme.titleLarge);
                    },
                  ),
                ),
                const Padding(padding: EdgeInsets.all(4)),
                TextButton(
                  onPressed: () {
                    context.read<CounterBloc>().add(CounterIncrementPressed());
                  },
                  child: const Text('Increment counter'),
                ),
                const Padding(padding: EdgeInsets.all(4)),
                TextButton(
                  onPressed: () {
                    context.read<CounterBloc>().add(CounterDecrementPressed());
                  },
                  child: const Text('Decrement counter'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
