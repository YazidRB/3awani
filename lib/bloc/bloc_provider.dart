import 'package:aawani/bloc/instagram_bloc.dart';
import 'package:flutter/material.dart';

class InstagramBlocProvider extends InheritedWidget {
  const InstagramBlocProvider({
    Key? key,
    required this.instagramBloc,
    required Widget child,
  }) : super(key: key, child: child);

  final InstagramBloc instagramBloc;

  static InstagramBlocProvider? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<InstagramBlocProvider>();

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;
}
