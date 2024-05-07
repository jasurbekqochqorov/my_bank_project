import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_bank_project/blocs/card/card_bloc.dart';
import 'package:my_bank_project/blocs/card/card_event.dart';
import 'package:my_bank_project/blocs/user_profile/user_bloc.dart';
import 'package:my_bank_project/data/repositories/cards_repositroy.dart';
import 'package:my_bank_project/data/repositories/user_profile_repositroy.dart';

import '../blocs/auth/auth_bloc.dart';
import '../data/repositories/auth_repository.dart';
import '../screen/routes.dart';
import '../services/local_notification_service.dart';

class App extends StatelessWidget {
  App({super.key});

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    LocalNotificationService.localNotificationService.init(navigatorKey);

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => AuthRepository()),
        RepositoryProvider(create: (_) => UserProfileRepository()),
        RepositoryProvider(create: (_) => CardsRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                AuthBloc(authRepository: context.read<AuthRepository>())
                  ..add(
                    CheckAuthenticationEvent(),
                  ),
          ),
          BlocProvider(
            create: (context) =>
            UserBloc(userProfileRepository: context.read<UserProfileRepository>())),

          BlocProvider(
              create: (context) =>
                  CardBloc(cardsRepository: context.read<CardsRepository>())..add(GetCardsDatabaseEvent())),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: RouteNames.splashScreen,
          navigatorKey: navigatorKey,
          onGenerateRoute: AppRoutes.generateRoute,
        ),
      ),
    );
  }
}
