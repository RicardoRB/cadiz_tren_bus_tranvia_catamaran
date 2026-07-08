import 'package:fluent_ui/fluent_ui.dart' hide Colors;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:macos_ui/macos_ui.dart';
import 'controlador_plataforma.dart';
import 'tipo_plataforma.dart';

class PaginaAdaptativa extends ConsumerWidget {
  final Widget title;
  final Widget body;
  final List<Widget>? actions;

  const PaginaAdaptativa({
    super.key,
    required this.title,
    required this.body,
    this.actions,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plataforma = ref.watch(controladorPlataformaProvider);

    switch (plataforma) {
      case TipoPlataforma.windows:
        return ScaffoldPage(
          header: PageHeader(
            title: title,
            commandBar: actions != null
                ? CommandBar(
                    primaryItems: actions!
                        .map((action) => CommandBarBuilderItem(
                              wrappedItem: action,
                              builder: (context, mode, w) => w,
                            ))
                        .toList(),
                  )
                : null,
          ),
          content: body,
        );

      case TipoPlataforma.macos:
        return MacosScaffold(
          toolBar: ToolBar(
            title: title,
            actions: actions
                ?.map((action) => ToolBarIconButton(
                      label: '',
                      icon: action,
                      onPressed: () {}, // Action already has its own handler
                      showLabel: false,
                    ))
                .toList(),
          ),
          children: [
            ContentArea(builder: (context, scrollController) => body),
          ],
        );

      case TipoPlataforma.ios:
        return CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            middle: title,
            trailing: actions != null
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: actions!,
                  )
                : null,
          ),
          child: SafeArea(child: body),
        );

      case TipoPlataforma.android:
      case TipoPlataforma.web:
      case TipoPlataforma.linux:
      default:
        return Scaffold(
          appBar: AppBar(
            title: title,
            actions: actions,
          ),
          body: body,
        );
    }
  }
}
