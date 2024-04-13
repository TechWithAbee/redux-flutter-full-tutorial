import 'package:redux/redux.dart';

class UserState {
  final bool isLoading;
  final String message;

  UserState({this.isLoading = false, this.message = ''});

  UserState copyWith({bool? isLoading, String? message}) {
    return UserState(
      isLoading: isLoading ?? this.isLoading,
      message: message ?? this.message,
    );
  }
}

class GetMessageAction {
  GetMessageAction();
}

UserState getMessageReducer(UserState state, GetMessageAction action) {
  return state.copyWith(isLoading: true);
}

class GetMessageResponse {
  final String message;

  GetMessageResponse(this.message);
}

UserState getMessageResponseReducer(UserState state, GetMessageResponse action) {
  return state.copyWith(isLoading: false, message: action.message);
}

class OnGetMessageError {
  final String errorMessage;

  OnGetMessageError(this.errorMessage);
}

UserState onGetMessageErrorReducer(UserState state, OnGetMessageError action) {
  return state.copyWith(isLoading: false, message: action.errorMessage);
}


Reducer<UserState> userReducer = combineReducers<UserState>([
  TypedReducer<UserState, GetMessageAction>(getMessageReducer),
  TypedReducer<UserState, GetMessageResponse>(getMessageResponseReducer),
  TypedReducer<UserState, OnGetMessageError>(onGetMessageErrorReducer),
]);