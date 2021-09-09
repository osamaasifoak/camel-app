import 'package:flutter/foundation.dart' show DiagnosticPropertiesBuilder, DiagnosticsProperty;
import 'package:flutter/widgets.dart';

class ListenableBuilder<L extends Listenable> extends StatefulWidget {
  /// Creates a widget that rebuilds when the given [listenable] changes.
  const ListenableBuilder({
    Key? key,
    required this.listenable,
    required this.builder,
  }) : super(key: key);

  /// The [Listenable] to which this widget is listening.
  final L listenable;

  @protected
  final Widget Function(BuildContext context, L state) builder;

  @override
  _ListenableBuilderState<L> createState() => _ListenableBuilderState<L>();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Listenable>('listenable', listenable));
  }
}

class _ListenableBuilderState<L extends Listenable> extends State<ListenableBuilder<L>> {
  @override
  void initState() {
    super.initState();
    widget.listenable.addListener(_handleChange);
  }

  @override
  void didUpdateWidget(ListenableBuilder<L> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.listenable != oldWidget.listenable) {
      oldWidget.listenable.removeListener(_handleChange);
      widget.listenable.addListener(_handleChange);
    }
  }

  @override
  void dispose() {
    widget.listenable.removeListener(_handleChange);
    super.dispose();
  }

  void _handleChange() => setState(() {/* no-op */});

  @override
  Widget build(BuildContext context) => widget.builder(context, widget.listenable);
}
