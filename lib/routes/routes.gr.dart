// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:pdf_ops/MainScreen.dart' as _i1;
import 'package:pdf_ops/pages/PdfOperationsList.dart' as _i2;

abstract class $AppRouter extends _i3.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i3.PageFactory> pagesMap = {
    MainRoute.name: (routeData) {
      return _i3.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.MainScreen(),
      );
    },
    PdfOperationsList.name: (routeData) {
      return _i3.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.PdfOperationsList(),
      );
    },
  };
}

/// generated route for
/// [_i1.MainScreen]
class MainRoute extends _i3.PageRouteInfo<void> {
  const MainRoute({List<_i3.PageRouteInfo>? children})
      : super(
          MainRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainRoute';

  static const _i3.PageInfo<void> page = _i3.PageInfo<void>(name);
}

/// generated route for
/// [_i2.PdfOperationsList]
class PdfOperationsList extends _i3.PageRouteInfo<void> {
  const PdfOperationsList({List<_i3.PageRouteInfo>? children})
      : super(
          PdfOperationsList.name,
          initialChildren: children,
        );

  static const String name = 'PdfOperationsList';

  static const _i3.PageInfo<void> page = _i3.PageInfo<void>(name);
}
