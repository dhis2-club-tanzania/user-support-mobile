import 'package:d2_touch/modules/auth/entities/user.entity.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:user_support_mobile/models/approve_model.dart';
import 'package:user_support_mobile/modules/module-authentication/metadatasync/initial-metadata-sync.dart';
import 'package:user_support_mobile/pages/data_approval_detail.dart';

import 'package:user_support_mobile/pages/user_approval_detail.dart';
import 'package:user_support_mobile/pages/dataset_screen.dart';
import 'package:user_support_mobile/pages/home_page.dart';
import 'package:user_support_mobile/pages/splash_page.dart';
import 'package:user_support_mobile/pages/user_account_screen.dart';
import 'package:user_support_mobile/pages/user_approval_screen.dart';


import '../pages/compose_page.dart';
import '../pages/compose_painter.dart';
import '../pages/inbox_page.dart';
import '../pages/login_page.dart';
import '../pages/system_page.dart';
import '../pages/ticket_page.dart';
import '../pages/user_approval_select.dart';
import '../pages/validation_page.dart';
import '../pages/data_approval_screen.dart';
import '../widgets/Utilities.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const SplashScreen();
      },
      routes: <RouteBase>[],
    ),
    GoRoute(path: '/sync', builder: (context, state) {
      return HomeMetadataSync(
        loggedInUser: state.extra as User,
      );

    }),
    GoRoute(
        path: '/home',
        builder: (context, state) => const HomePage(),
        routes: [
          GoRoute(
            path: 'dataset',
            builder: (BuildContext context, GoRouterState state) {
              return const DatasetScreen();
            },
          ),
          GoRoute(
            path: 'user_account',
            builder: (BuildContext context, GoRouterState state) {
              return const UserAccountScreen();
            },
          ),
          GoRoute(
            path: 'compose',
            builder: (BuildContext context, GoRouterState state) {
              return const ComposePage();
            },
          ),
          GoRoute(
            path: 'inbox/:isAuth',
            builder: (BuildContext context, GoRouterState state) {
              final bool isAuth = state.extra! as bool;
              return const InboxPage();
            },
          ),
          GoRoute(
            path: 'system',
            builder: (BuildContext context, GoRouterState state) {
              return const SystemPage();
            },
          ),
          GoRoute(
            path: 'validation',
            builder: (BuildContext context, GoRouterState state) {
              return const ValidationPage();
            },
          ),
          GoRoute(
            path: 'ticket',
            builder: (BuildContext context, GoRouterState state) {
              return const TicketPage();
            },
          ),
          GoRoute(
            name: 'login',
            path: 'login',
            builder: (BuildContext context, GoRouterState state) {
              return LoginPage();
            },
          ),
          GoRoute(
            path: 'composePainter',
            builder: (BuildContext context, GoRouterState state) {
              return const ComposePainter();
            },
          ),
          GoRoute(
            path: 'dataApproval',
            builder: (BuildContext context, GoRouterState state) {
              return const DataApprovalScreen();
            },
          ),
          GoRoute(
            path: 'userApproval',
            builder: (BuildContext context, GoRouterState state) {
              return const UserApprovalScreen();
            },
          ),
          GoRoute(
              path: 'request_details',
              builder: (context, state) {
                final dataApproval = state.extra as ApproveModel;
                return DataApprovalDetailPage(
                  dataApproval: dataApproval,
                );
              }),
          GoRoute(
              path: 'user_account_details',
              builder: (context, state) {
                final UserModel? userModel = state.extra as UserModel?;
                return UserApprovalDetailPage(
                  userApproval: userModel!,
                  userPayload: userModel.userPayload,
                );
              }),
          //GoRoute(
            //path: 'user_approval_select',
           // builder: (context, state) {
             // final UserModel? userModel = state.extra as UserModel?;
             // List<dynamic> accounts = UserUtils.addAccountData(userModel);
              //final dropdownhandler = _PageContentState();
             // return ApprovalTableDialogPage(
                //userApproval: userModel!,
               // userPayload: userModel.userPayload,
               // accounts: accounts,
                //showDropdown: (BuildContext context, String firstName, String lastName, UserModel userApproval) {
                 // dropdownhandler._showDropdown(context, firstName, lastName, userApproval);
                //},
              //);
            //},
         // ),
        ]),
  ],
);

