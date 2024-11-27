import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordle/features/random_word/presentation/bloc/bloc.dart';

class SearchBox extends StatefulWidget {
  const SearchBox({super.key});

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      onSubmitted: onSubmitted,
    );
  }

  void onSubmitted(String value) {
    if (value.isEmpty) return;

    BlocProvider.of<WordBloc>(context).add(GetWordByRandomWordEvent(value));
  }
}
