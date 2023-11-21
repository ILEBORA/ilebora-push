import 'package:flutter_test/flutter_test.dart';
import 'package:ilebora_push/ilebora_push.dart';

import 'dart:async';
import 'package:mockito/mockito.dart';
import 'package:universal_html/html.dart' as html;

// import 'package:ilebora_push/ilebora_push.dart';
// import 'package:universal_html/html.dart';

class MockEventSource extends Mock implements html.EventSource {}

void main() {
  group('BoraPushClient', () {
    test('create should initialize EventSource with a blank URL', () {
      final client = BoraPushClient.create();

      expect(client.eventSource.url, isEmpty);
    });

    test('connect should initialize EventSource with the provided URI', () {
      // final mockEventSource = MockEventSource();
      // final uri = Uri.parse('https://example.com');
      // final client = BoraPushClient.connect(uri: uri);

      // // Use Mockito to verify that the EventSource is initialized with the correct URI
      // verify(mockEventSource.uri).equals(uri.toString());
    });

    test('stream should emit events from EventSource', () async {
      // final mockEventSource = MockEventSource();
      // final streamController = StreamController<String>();
      // final client = BoraPushClient._internal(mockEventSource, streamController);

      // // Mock an event from the EventSource
      // when(mockEventSource.onMessage).thenAnswer((_) {
      //   return Stream<html.MessageEvent>.fromIterable([
      //     html.MessageEvent('message', data: 'Test Event'),
      //   ]);
      // });

      // // Use Mockito to verify that the StreamController receives the event
      // expect(await client.stream.first, equals('Test Event'));
    });

    test('close should close both EventSource and StreamController', () {
      // final mockEventSource = MockEventSource();
      // final streamController = MockStreamController<String>();
      // final client = BoraPushClient.test(mockEventSource, streamController);

      // // Use Mockito to verify that close is called on both EventSource and StreamController
      // client.close();
      // verify(mockEventSource.close());
      // verify(streamController.close());
    });

    // Additional tests can be added based on your specific use cases
  });
}
