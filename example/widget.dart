import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ilebora_push/bora_push_block.dart';
import 'package:ilebora_push/ilebora_push.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) => BoraPushBloc(BoraPushClient.create()),
        child: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final TextEditingController _uriController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final BoraPushBloc pushBloc = BlocProvider.of<BoraPushBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('BoraPush Example'),
      ),
      body: BlocBuilder<BoraPushBloc, BoraPushState>(
        builder: (context, state) {
          if (state is ConnectedState) {
            return Column(
              children: [
                Text('Connected to SSE'),
                StreamBuilder<dynamic>(
                  stream: state.stream,
                  builder: (context, snapshot) {
                    return Text(snapshot.data ?? 'No data');
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    pushBloc.add(CloseEvent());
                  },
                  child: Text('Disconnect'),
                ),
              ],
            );
          } else if (state is ClosedState) {
            return Column(
              children: [
                Text('Connection closed'),
                ElevatedButton(
                  onPressed: () {
                    final uri = Uri.parse(_uriController.text);
                    pushBloc.add(ConnectEvent(uri: uri));
                  },
                  child: Text('Connect'),
                ),
              ],
            );
          } else if (state is ErrorState) {
            return Column(
              children: [
                Text('Error: ${state.errorMessage}'),
                ElevatedButton(
                  onPressed: () {
                    pushBloc.add(CloseEvent());
                  },
                  child: Text('Try Again'),
                ),
              ],
            );
          }

          // Default state
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
