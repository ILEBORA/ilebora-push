import 'dart:async';
import 'dart:io';

class BoraPushServer {
  final List<WebSocket> connectedClients = [];

  void start() async {
    final server = await HttpServer.bind('localhost', 8080);
    print('Server started on port 8080');

    await for (var request in server) {
      if (WebSocketTransformer.isUpgradeRequest(request)) {
        handleWebSocket(request);
      } else {
        // Handle regular HTTP requests
        // ...
      }
    }
  }

  Future<void> handleWebSocket(HttpRequest request) async {
    final socket = await WebSocketTransformer.upgrade(request);

    // Add the connected client to the list
    connectedClients.add(socket);

    // Handle incoming messages
    socket.listen((dynamic data) {
      // Handle incoming messages (if needed)
    });

    // Handle disconnections
    socket.done.then((_) {
      connectedClients.remove(socket);
      print('Client disconnected');
    });
  }

  void sendUpdate(String message) {
    for (var client in connectedClients) {
      client.add(message);
    }
  }
}

void main() {
  final pushServer = BoraPushServer();
  pushServer.start();
}