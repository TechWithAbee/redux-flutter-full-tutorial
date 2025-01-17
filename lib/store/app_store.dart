import 'package:flutter/material.dart';
import 'package:myapp/user/user_epics.dart';
import 'package:myapp/user/user_reducer.dart';
import 'package:redux/redux.dart' as redux;
import 'package:redux_epics/redux_epics.dart';
import 'app_state.dart';


GlobalState appStateReducer(GlobalState state, action) => GlobalState(
  appState: AppState(
    userState: userReducer(state.appState.userState, action),
  ));

class GlobalState {
  AppState appState;

  GlobalState({required this.appState});
}

final epic = combineEpics<GlobalState>([
  ...userEffects,
]);

final epicMiddleware = EpicMiddleware<GlobalState>(epic);

final initialState = GlobalState(
  appState: AppState(
    userState: UserState(),

));

var store = redux.Store<GlobalState>(appStateReducer,
  middleware: [epicMiddleware], initialState: initialState);