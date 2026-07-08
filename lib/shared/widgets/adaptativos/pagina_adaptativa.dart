import 'package:fluent_ui/fluent_ui.dart' as fluent hide Colors, Icon, Text;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:macos_ui/macos_ui.dart' as macos;
import '../../../core/utils/controlador_plataforma.dart';

class PaginaAdaptativa extends ConsumerWidget {
  final Widget child;
  final String? title;
  final List<Widget>? actions;

  const PaginaAdaptativa({
    super.key,
    required this.child,
    this.title,
    this.actions,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plataforma = ref.watch(controladorPlataformaProvider);

    switch (plataforma) {
      case TipoPlataforma.windows:
        return fluent.ScaffoldPage(
          header: title != null
              ? fluent.PageHeader(
                  title: Text(title!),
                  commandBar: actions != null
                      ? fluent.CommandBar(
                          primaryItems: actions!.map((a) {
                            if (a is IconButton) {
                              return fluent.CommandBarButton(
                                onPressed: a.onPressed,
                                icon: a.icon,
                              );
                            }
                            return fluent.CommandBarBuilderItem(
                              wrappedItem: a,
                              builder: (context, mode, child) => child!,
                            );
                          }).toList(),
                        )
                      : null,
                )
              : null,
          content: child,
        );
      case TipoPlataforma.macos:
        return macos.MacosScaffold(
          toolBar: title != null
              ? macos.ToolBar(
                  title: Text(title!),
                  actions: actions?.map((a) {
                    if (a is IconButton) {
                      return macos.ToolBarIconButton(
                        label: a.tooltip ?? 'Acción',
                        icon: a.icon,
                        onPressed: a.onPressed,
                        showLabel: false,
                      );
                    }
                    return macos.CustomToolbarItem(
                      inToolbarBuilder: (context) => a,
                    );
                  }).toList(),
                )
              : null,
          children: [
            macos.ContentArea(builder: (context, scrollController) => child),
          ],
        );
      case TipoPlataforma.ios:
        return CupertinoPageScaffold(
          navigationBar: title != null
              ? CupertinoNavigationBar(
                  middle: Text(title!),
                  trailing: actions != null ? Row(mainAxisSize: MainAxisSize.min, children: actions!) : null,
                )
              : null,
          child: SafeArea(child: child),
        );
      default:
        return Scaffold(
          appBar: title != null
              ? AppBar(
                  title: Text(title!),
                  actions: actions,
                )
              : null,
          body: child,
        );
    }
  }
}
