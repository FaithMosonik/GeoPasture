import 'dart:async';
import 'package:flutter/foundation.dart';

/// Handles retry attempts with exponential backoff.
///
/// How it works:
///   Attempt 1 fails → wait 1 minute  → retry
///   Attempt 2 fails → wait 2 minutes → retry
///   Attempt 3 fails → wait 4 minutes → retry
///   Attempt 4 fails → wait 8 minutes → retry
///   Attempt 5 fails → give up until next connectivity restoration
///
/// The wait time doubles after each failure: 1min → 2min → 4min → 8min
class RetryHandler {
  /// Maximum number of attempts before giving up
  final int maxAttempts;

  /// Base delay for the first retry
  final Duration baseDelay;

  /// Maximum delay cap — backoff won't exceed this
  final Duration maxDelay;

  const RetryHandler({
    this.maxAttempts = 5,
    this.baseDelay = const Duration(minutes: 1),
    this.maxDelay = const Duration(minutes: 30),
  });

  /// Executes [operation] with exponential backoff retry logic.
  ///
  /// [operationName] is used for logging only.
  /// [onRetry] is called before each retry attempt with the current attempt
  /// number and the error that caused the failure — use this to update
  /// SYNC_LOG retry_count via the sync repository.
  ///
  /// Returns true if the operation eventually succeeded, false if all
  /// attempts were exhausted.
  Future<bool> execute({
    required String operationName,
    required Future<void> Function() operation,
    Future<void> Function(int attempt, Object error)? onRetry,
  }) async {
    int attempt = 0;

    while (attempt < maxAttempts) {
      try {
        await operation();
        if (attempt > 0) {
          debugPrint(
            '[RetryHandler] $operationName succeeded on attempt ${attempt + 1}.',
          );
        }
        return true;
      } on UnimplementedError {
        // Firestore not configured yet — don't retry, just rethrow
        rethrow;
      } catch (error) {
        attempt++;

        if (attempt >= maxAttempts) {
          debugPrint(
            '[RetryHandler] $operationName failed after $maxAttempts attempts. Giving up.',
          );
          return false;
        }

        // Calculate backoff delay: baseDelay * 2^(attempt-1)
        // e.g. attempt 1 → 1min, attempt 2 → 2min, attempt 3 → 4min
        final delay = _calculateDelay(attempt);

        debugPrint(
          '[RetryHandler] $operationName failed (attempt $attempt/$maxAttempts). '
          'Retrying in ${delay.inSeconds}s. Error: $error',
        );

        // Notify caller so they can update SYNC_LOG retry_count
        await onRetry?.call(attempt, error);

        // Wait before retrying
        await Future.delayed(delay);
      }
    }

    return false;
  }

  /// Calculates the delay for a given attempt number.
  /// Doubles each time but never exceeds [maxDelay].
  Duration _calculateDelay(int attempt) {
    final multiplier = 1 << (attempt - 1); // 2^(attempt-1)
    final delay = Duration(
      milliseconds: baseDelay.inMilliseconds * multiplier,
    );
    return delay > maxDelay ? maxDelay : delay;
  }
}
