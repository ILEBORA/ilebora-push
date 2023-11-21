A dart package designed to facilitate real-time communication between server and client applications using the Server-Sent Events (SSE) protocol. It provides two main components, the BoraPushServer and BoraPushClient, allowing developers to easily implement real-time updates in their Dart-based web applications.

## Features:

  - **Server-Sent Events (SSE) Support:**
        The package enables the implementation of server-sent events, allowing servers to push real-time updates to connected clients over a single HTTP connection.

  - **BoraPushServer:**
        The BoraPushServer class provides a server-side implementation for managing connections, maintaining a list of connected clients, and broadcasting updates to all connected clients.

  - **BoraPushClient:**
        The BoraPushClient class is designed for use on the client side, allowing easy connection to a server supporting SSE and handling incoming real-time updates.

  - **Simple API:**
        Developers can create and configure instances of BoraPushServer and BoraPushClient with minimal code, making it straightforward to integrate real-time communication into their applications.

## Example Usage:

- **Server-Side (BoraPushServer):**

```dart

void main() {
  final pushServer = BoraPushServer();
  pushServer.start();
}
```

- **Client-Side (BoraPushClient):**

```dart

void main() {
  final pushClient = BoraPushClient.connect(uri: Uri.parse('https://example.com'));
  pushClient.stream.listen((data) {
    // Handle incoming updates
  });
}
```

## Note:

    The package assumes a server supporting SSE (e.g., Dart HTTP server with WebSocket support) for optimal functionality.
    Developers can customize and extend the provided classes based on their specific real-time communication requirements.