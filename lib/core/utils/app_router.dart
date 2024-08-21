import 'package:auto_route/auto_route.dart';
import 'package:task_manager/modules/detail/presentation/pages/detail_page.dart';
import 'package:task_manager/modules/form/presentation/pages/form_page.dart';
import 'package:task_manager/modules/home/presentation/pages/home_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: HomeRoute.page,
          initial: true,
        ),
        AutoRoute(
          page: FormRoute.page,
        ),
        AutoRoute(
          page: DetailRoute.page,
        ),
      ];
}
