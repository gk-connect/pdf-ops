import 'package:auto_route/auto_route.dart';
import 'package:pdf_ops/routes/routes.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: MainRoute.page, path: '/'),
        AutoRoute(page: PdfOperationsList.page, path: '/pdf-route'),
      ];
}
