import '../pages/compose_page.dart';
import '../pages/compose_painter.dart';
import '../pages/inbox_page.dart';
import '../pages/login_page.dart';
import '../pages/system_page.dart';
import '../pages/ticket_page.dart';
import '../pages/validation_page.dart';
import '../pages/data_approval_screen.dart';

var routes = {
  InboxPage.routeName: (ctx) => const InboxPage(),
  SystemPage.routeName: (ctx) => const SystemPage(),
  ValidationPage.routeName: (ctx) => const ValidationPage(),
  ComposePage.routeName: (ctx) => const ComposePage(),
  TicketPage.routeName: (ctx) => const TicketPage(),
  LoginPage.routeName: (ctx) => const LoginPage(),
  ComposePainter.routeName: (ctx) => const ComposePainter(),
  DataApprovalScreen.routeName: (ctx) => const DataApprovalScreen(),
};
