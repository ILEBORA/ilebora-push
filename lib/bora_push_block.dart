// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';

import 'bora_push_client.dart';

// Events
abstract class BoraPushEvent {}

class ConnectEvent extends BoraPushEvent {
  final Uri uri;
  final bool withCredentials;
  final bool closeOnError;

  ConnectEvent({
    required this.uri,
    this.withCredentials = false,
    this.closeOnError = true,
  });
}

class CloseEvent extends BoraPushEvent {}

// States
abstract class BoraPushState {}

class ConnectedState extends BoraPushState {
  final Stream<dynamic> stream;

  ConnectedState(this.stream);
}

class ClosedState extends BoraPushState {}

class ErrorState extends BoraPushState {
  final String errorMessage;

  ErrorState(this.errorMessage);
}

// BLoC
class BoraPushBloc extends Bloc<BoraPushEvent, BoraPushState> {
  BoraPushClient _pushClient;

  BoraPushBloc(
    this._pushClient,
  ) : super(ClosedState()) {
    _pushClient = BoraPushClient.create();
  }

  @override
  Stream<BoraPushState> mapEventToState(BoraPushEvent event) async* {
    if (event is ConnectEvent) {
      try {
        _pushClient = BoraPushClient.connect(
          uri: event.uri,
          withCredentials: event.withCredentials,
          closeOnError: event.closeOnError,
        );

        yield ConnectedState(_pushClient.stream);
      } catch (e) {
        yield ErrorState('Failed to connect: $e');
      }
    } else if (event is CloseEvent) {
      _pushClient.close();
      yield ClosedState();
    }
  }
}
