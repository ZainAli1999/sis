import 'dart:async';
import 'dart:developer';

void runInBackground(Future<void> Function() task, {String? label}) {
  unawaited(
    Future(() async {
      try {
        await task();
      } catch (e, st) {
        log("⚠️ Error in background task${label != null ? ' [$label]' : ''}: $e",
            stackTrace: st);
      }
    }),
  );
}
