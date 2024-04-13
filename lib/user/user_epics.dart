import 'dart:async';
import 'package:myapp/store/app_store.dart';
import 'package:myapp/user/user_reducer.dart';
import 'package:myapp/user/user_services.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';


Stream<dynamic> getMessageEpic(Stream<dynamic> actions, EpicStore<GlobalState> store) {
  return actions
      .where((action) => action is GetMessageAction)
      .asyncMap((action) => UserService.getMessage())
      .flatMap<dynamic>((value) => Stream.fromIterable([
            GetMessageResponse(value),
          ]))
      .onErrorResume((error, stackTrace) => Stream.fromIterable([
            OnGetMessageError('An error occurred while fetching message'),
          ]));
}


List<Stream<dynamic> Function(Stream<dynamic>, EpicStore<GlobalState>)> userEffects = [
  getMessageEpic,
];