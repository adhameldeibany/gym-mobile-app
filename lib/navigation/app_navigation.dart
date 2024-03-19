import 'package:flockergym/Booking/Coach/coach_screen.dart';
import 'package:flockergym/Booking/Coach/coachview_screen.dart';
import 'package:flockergym/Booking/bookclass_screen.dart';
import 'package:flockergym/Booking/booksession_screen.dart';
import 'package:flockergym/Booking/schedule_screen.dart';
import 'package:flockergym/Classes/class_2.dart';
import 'package:flockergym/Classes/class_screen.dart';
import 'package:flockergym/Classes/details_class.dart';
import 'package:flockergym/Classes/offer_screen.dart';
import 'package:flockergym/Home/Features/Challenges/challenge_screen.dart';
import 'package:flockergym/Home/Features/Invitations/invitations_screen.dart';
import 'package:flockergym/Home/Features/Store/details_screen.dart';
import 'package:flockergym/Home/Features/Store/store_screen.dart';
import 'package:flockergym/Home/Features/Subscription/subscription_screen.dart';
import 'package:flockergym/Home/Features/Workout/workout_view.dart';
import 'package:flockergym/Home/Features/checkin_screen.dart';
import 'package:flockergym/Home/Features/training_plan.dart';
import 'package:flockergym/Home/home_screen.dart';
import 'package:flockergym/NewBackend/Models/ClassModel.dart';
import 'package:flockergym/NewBackend/Models/ClassesDaysModel.dart';
import 'package:flockergym/NewBackend/Models/StoreItem.dart';
import 'package:flockergym/Notifications/notifications_screen.dart';
import 'package:flockergym/Plans/plans_screen.dart';
import 'package:flockergym/Profile/profile_screen.dart';
import 'package:flockergym/navigation/wrapper/main_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

late StatefulNavigationShell navigationshell;

String searchtext = "";

class AppNavigation {


  AppNavigation._();

  static String initial = "/home";


  static getSearchtext(String searchtex){
    searchtext = searchtex;
  }

  // Private navigators
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _NavigatorHome =
      GlobalKey<NavigatorState>(debugLabel: 'Home');
  static final _NavigatorClasses =
      GlobalKey<NavigatorState>(debugLabel: 'Classes');
  static final _NavigatorCheckin =
      GlobalKey<NavigatorState>(debugLabel: 'Checkin');
  static final _NavigatorPlans =
      GlobalKey<NavigatorState>(debugLabel: 'Plans');
  static final _NavigatorNotifications =
      GlobalKey<NavigatorState>(debugLabel: 'Notifications');

  // GoRouter configuration
  static GoRouter router = GoRouter(
    initialLocation: initial,
    debugLogDiagnostics: false,
    navigatorKey: _rootNavigatorKey,

    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          navigationshell = navigationShell;
          return MainWrapper(
            navigationShell: navigationShell,
          );
        },
        branches: <StatefulShellBranch>[
          StatefulShellBranch(
            navigatorKey: _NavigatorHome,
            routes: <RouteBase>[
              GoRoute(
                path: "/home",
                name: "Home",
                builder: (BuildContext context, GoRouterState state) => HomeScreen(),
                routes: [
                  GoRoute(
                    path: "Notifications",
                    name: "Notifications",
                    builder: (BuildContext context, GoRouterState state) => NotificationsScreen(),
                  ),
                  GoRoute(
                    path: 'Store',
                    name: 'Store',
                    pageBuilder: (context, state) => CustomTransitionPage<void>(
                      key: state.pageKey,
                      child: StoreScreen(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) =>
                              FadeTransition(opacity: animation, child: child),
                    ),
                  ),
                  GoRoute(
                    path: 'Details',
                    name: 'Details',
                    builder: (context, state) {
                      StoreItem storeitem = state.extra as StoreItem;
                      return DetailsScreen(storeItem: storeitem,);
                    },
                    // pageBuilder: (context, state) => CustomTransitionPage<void>(// 👈 casting is important
                    //   key: state.pageKey,
                    //   child: DetailsScreen(),
                    //   transitionsBuilder:
                    //       (context, animation, secondaryAnimation, child) =>
                    //       FadeTransition(opacity: animation, child: child),
                    // ),
                  ),
                  GoRoute(
                    path: 'Checkin',
                    name: 'Check-in',
                    pageBuilder: (context, state) => CustomTransitionPage<void>(
                      key: state.pageKey,
                      child: CheckinScreen(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) =>
                          FadeTransition(opacity: animation, child: child),
                    ),
                  ),
                  GoRoute(
                    path: 'Profile',
                    name: 'Profile',
                    pageBuilder: (context, state) => CustomTransitionPage<void>(
                      key: state.pageKey,
                      child: ProfileScreen(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) =>
                          FadeTransition(opacity: animation, child: child),
                    ),
                  ),
                  GoRoute(
                    path: 'Bookclass',
                    name: 'Book Class',
                    pageBuilder: (context, state) => CustomTransitionPage<void>(
                      key: state.pageKey,
                      child: BookclassScreen(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) =>
                          FadeTransition(opacity: animation, child: child),
                    ),
                  ),
                  GoRoute(
                    path: 'Trainingplan',
                    name: 'Trainingplan',
                    pageBuilder: (context, state) => CustomTransitionPage<void>(
                      key: state.pageKey,
                      child: TrainingplanScreen(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) =>
                          FadeTransition(opacity: animation, child: child),
                    ),
                  ),
                  GoRoute(
                    path: 'Invitations',
                    name: 'Invitations',
                    pageBuilder: (context, state) => CustomTransitionPage<void>(
                      key: state.pageKey,
                      child: InvitationsScreen(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) =>
                          FadeTransition(opacity: animation, child: child),
                    ),
                  ),
                  GoRoute(
                    path: 'Workout',
                    name: 'Workout',
                    pageBuilder: (context, state) => CustomTransitionPage<void>(
                      key: state.pageKey,
                      child: WorkoutView(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) =>
                          FadeTransition(opacity: animation, child: child),
                    ),
                  ),
                  GoRoute(
                    path: 'Subscription',
                    name: 'Subscription',
                    pageBuilder: (context, state) => CustomTransitionPage<void>(
                      key: state.pageKey,
                      child: SubscriptionScreen(navi: navigationshell),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) =>
                          FadeTransition(opacity: animation, child: child),
                    ),
                  ),
                  GoRoute(
                    path: 'Challenge',
                    name: 'Challenge',
                    pageBuilder: (context, state) => CustomTransitionPage<void>(
                      key: state.pageKey,
                      child: ChallengeScreen(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) =>
                          FadeTransition(opacity: animation, child: child),
                    ),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _NavigatorClasses,
            routes: <RouteBase>[
              GoRoute(
                path: "/Class",
                name: "Class",
                builder: (BuildContext context, GoRouterState state) {
                  return ClassesScreen2();
                },
                routes: [
                  GoRoute(
                    path: 'Detailsclass',
                    name: 'Detailsclass',
                    pageBuilder: (context, state) => CustomTransitionPage<void>(
                      key: state.pageKey,
                      child: DetailsclassScreen(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) =>
                          FadeTransition(opacity: animation, child: child),
                    ),
                  ),
                  GoRoute(
                    path: 'offer',
                    name: 'offer',
                    pageBuilder: (context, state) => CustomTransitionPage<void>(
                      key: state.pageKey,
                      child: OfferScreen(classModel: state.extra as ClassModel),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) =>
                          FadeTransition(opacity: animation, child: child),
                    ),
                  ),
                  GoRoute(
                    path: 'Schedule',
                    name: 'Schedule',
                    pageBuilder: (context, state) {
                      return CustomTransitionPage<void>(
                        key: state.pageKey,
                        child: ScheduleScreen(classes: state.extra as List<ClassesDaysModel>),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) =>
                            FadeTransition(opacity: animation, child: child),
                    );
                    },
                  ),
                  GoRoute(
                    path: 'BookSession',
                    name: 'BookSession',
                    pageBuilder: (context, state) {
                      return CustomTransitionPage<void>(
                        key: state.pageKey,
                        child: BookSessionScreen(classe: state.extra as List<ClassesDaysModel>),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) =>
                            FadeTransition(opacity: animation, child: child),
                    );
                    },
                  ),
                  GoRoute(
                    path: 'Coach/:day/:from/:to/:daylong/:classname/:clas',
                    name: 'Coach',
                    pageBuilder: (context, state) {
                      return CustomTransitionPage<void>(
                      key: state.pageKey,
                      child: CoachScreen(
                        day: state.pathParameters['day'].toString(),
                        daylong: state.pathParameters['daylong'].toString(),
                        from:  state.pathParameters['from'].toString(),
                        to:  state.pathParameters['to'].toString(),
                        classes: state.extra as List<ClassesDaysModel>,
                        classname: state.pathParameters['classname'].toString(),
                        clas: state.pathParameters['clas'].toString()
                      ),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) =>
                          FadeTransition(opacity: animation, child: child),
                    );
                    },
                  ),
                  GoRoute(
                    path: 'Coachview/:clas',
                    name: 'Coachview',
                    pageBuilder: (context, state) {
                      return CustomTransitionPage<void>(
                      key: state.pageKey,
                      child: CoachviewScreen(
                        coachname: state.extra as String,
                        clas: state.pathParameters['clas'].toString(),
                      ),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) =>
                          FadeTransition(opacity: animation, child: child),
                    );
                    },
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _NavigatorCheckin,
            routes: <RouteBase>[
              GoRoute(
                path: "/Checkin",
                name: "Checkin",
                builder: (BuildContext context, GoRouterState state) => CheckinScreen(),
                routes: [],
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _NavigatorPlans,
            routes: <RouteBase>[
              GoRoute(
                path: "/Plans",
                name: "Plans",
                builder: (BuildContext context, GoRouterState state) => PlansScreen(),
                routes: [],
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
