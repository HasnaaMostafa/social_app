import 'dart:async';
import 'dart:isolate';
import 'package:async/async.dart';
import 'game_engine.dart';

class ConcurrentGameEngine implements GameEngine {
  Isolate? isolate;
  SendPort? sendPort;

  final ReceivePort receivePort = ReceivePort();
  late final StreamQueue receiveQueue = StreamQueue(receivePort);

  @override
  Future<UiState> start() async {
    if (isolate == null) {
      isolate = await Isolate.spawn(isolateEntryPoint, receivePort.sendPort);
      sendPort = await receiveQueue.next;
    }
    sendPort!.send('start');
    return await receiveQueue.next;
  }

  @override
  Future<UiState> reportMove(int row, int col) async {
    sendPort!.send([row, col]);
    return await receiveQueue.next;
  }

  @override
  Future<UiState> makeMove() async {
    sendPort!.send('makeMove');
    return await receiveQueue.next;
  }

  @override
  void dispose() {
    receiveQueue.cancel();
    receivePort.close();
    isolate?.kill();
    isolate = null;
  }
}

void isolateEntryPoint(SendPort sendPort) {
  final receivePort = ReceivePort();
  sendPort.send(receivePort.sendPort);

  final engine = GameEngine();

  receivePort.listen((Object? message) async {
    if (message == 'start') {
      sendPort.send(await engine.start());
    } else if (message == 'makeMove') {
      sendPort.send(await engine.makeMove());
    } else if (message is List<int> && message.length == 2) {
      sendPort.send(await engine.reportMove(message.first, message.last));
    }
  });
}
