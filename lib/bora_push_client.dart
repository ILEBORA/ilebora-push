import 'dart:async';
import "package:universal_html/html.dart" as html;

class BoraPushClient {
	late final html.EventSource eventSource;
	late final StreamController<String> streamController;

	/// Create a BoraPushClient with a blank EventSource.
	factory BoraPushClient.create() {
		final eventSource = html.EventSource('');
		final streamController = StreamController<String>();
		
		// Return an instance of BoraPushClient
		return BoraPushClient._internal(eventSource, streamController);
	}

	/// Connect to an SSE endpoint with the specified URI and options.
	factory BoraPushClient.connect({
		required Uri uri,
		bool withCredentials = false,
		bool closeOnError = true,
	}) {
		// print('SSE connect...');
		final streamController = StreamController<String>();
		final eventSource = html.EventSource(uri.toString(), withCredentials: withCredentials);

		eventSource.addEventListener('message', (html.Event message) {
		// print('SSE Event listener...');
		streamController.add((message as html.MessageEvent).data as String);
		});

		/// Close if the endpoint is not working
		if (closeOnError) {
		eventSource.onError.listen((event) {
			// print('On error...');
			eventSource?.close();
			streamController?.close();
		});
		}

		return BoraPushClient._internal(eventSource, streamController);
	}

	/// Get the SSE stream.
	Stream get stream => streamController.stream;

	/// Check if the stream is closed.
	bool isClosed() => streamController == null || streamController.isClosed;

	/// Close the SSE connection.
	void close() {
		// print('SSE Close...');
		eventSource?.close();
		streamController?.close();
	}

	BoraPushClient._internal(this.eventSource, this.streamController);

	factory BoraPushClient.test(eventSource, streamController) {
		return BoraPushClient._internal(eventSource, streamController);
	}
}
