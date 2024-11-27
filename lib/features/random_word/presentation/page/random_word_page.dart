import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordle/features/random_word/presentation/bloc/bloc.dart';
import 'package:wordle/features/random_word/presentation/widgets/search_box.dart';
import 'package:wordle/injection_container.dart';

class RandomWordPage extends StatelessWidget {
  const RandomWordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Random word"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: BlocProvider(
              create: (_) => sl<WordBloc>(),
              child: BlocBuilder<WordBloc, WordState>(
                builder: (context, state) {
                  Widget resultContent;
                  switch (state) {
                    case Empty _:
                      resultContent = const Text("Search something...");
                      break;
                    case Loading _:
                      resultContent = const CircularProgressIndicator();
                      break;
                    case Loaded _:
                      resultContent = Column(children: state.words.map((word) => Text(word.result)).toList());
                      break;
                    case Error _:
                      resultContent = Text(state.message, style: const TextStyle(color: Colors.red));
                      break;
                    default:
                      return const SizedBox();
                  }
                  return Column(
                    children: [
                      // Search box
                      const SearchBox(),

                      // Result content
                      resultContent,
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
