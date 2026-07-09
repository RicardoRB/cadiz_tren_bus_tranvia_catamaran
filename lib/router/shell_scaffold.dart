import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../core/platform/scaffold_adaptativo.dart';

class ShellScaffold extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const ShellScaffold({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return ScaffoldAdaptativo(navigationShell: navigationShell);
  }
}
