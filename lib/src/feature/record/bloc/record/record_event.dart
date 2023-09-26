/// {@template record_event}
/// RecordEvent class
/// {@endtemplate}
sealed class RecordEvent {
  /// {@macro record_event}
  const RecordEvent();

  factory RecordEvent.create(int clientId) = RecordEvent$Create;
}

final class RecordEvent$Create extends RecordEvent {
  const RecordEvent$Create(this.clientId);

  final int clientId;
}
