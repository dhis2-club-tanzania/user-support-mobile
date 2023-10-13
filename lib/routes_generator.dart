import 'package:flutter/material.dart';
import 'package:user_support_mobile/pages/home_page.dart';
import '../pages/compose_page.dart';
import '../pages/compose_painter.dart';
import '../pages/inbox_page.dart';
import '../pages/login_page.dart';
import '../pages/system_page.dart';
import '../pages/ticket_page.dart';
import '../pages/validation_page.dart';
import '../pages/data_approval_screen.dart';
import 'modules/module-authentication/login/login-page.dart';

class RoutesGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case InboxPage.routeName:
        return MaterialPageRoute(builder: (_) => const InboxPage());
      case HomePage.routeName:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case HomeLogin.routeName:
        return MaterialPageRoute(builder: (_) => const HomeLogin());
      case SystemPage.routeName:
        return MaterialPageRoute(builder: (_) => const SystemPage());
      case ValidationPage.routeName:
        return MaterialPageRoute(builder: (_) => const ValidationPage());
      case ComposePage.routeName:
        return MaterialPageRoute(builder: (_) => const ComposePage());
      case TicketPage.routeName:
        return MaterialPageRoute(builder: (_) => const TicketPage());
      case HomeLogin.routeName:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case ComposePainter.routeName:
        return MaterialPageRoute(builder: (_) => const ComposePainter());
      case DataApprovalScreen.routeName:
        return MaterialPageRoute(builder: (_) => const DataApprovalScreen());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> wip() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            tooltip: '',
            onPressed: () {
              Navigator.pop(_);
            },
          ),
          title: const Text('WIP 🚧'),
        ),
        body: const Center(child: Text('Work In Progress 🚧')),
      );
    });
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            tooltip: '',
            onPressed: () {
              MaterialPageRoute(builder: (_) => const HomePage());
            },
          ),
          title: const Text('Error'),
        ),
        body: const Center(child: Text('ERROR')),
      );
    });
  }
}
