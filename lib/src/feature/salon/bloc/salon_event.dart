import '/src/feature/salon/models/salon.dart';

/// Business Logic Component salon_event Events
sealed class SalonEvent {
  const SalonEvent();

  /// Fetch
  const factory SalonEvent.fetchAll() = SalonEvent$FetchAll;

  /// Get current
  const factory SalonEvent.getCurrent() = SalonEvent$GetCurrent;

  /// Save current
  const factory SalonEvent.saveCurrent(Salon salon) = SalonEvent$SaveCurrent;
}

/// Fetch all salons.
class SalonEvent$FetchAll extends SalonEvent {
  const SalonEvent$FetchAll();
}

class SalonEvent$GetCurrent extends SalonEvent {
  const SalonEvent$GetCurrent();
}

class SalonEvent$SaveCurrent extends SalonEvent {
  const SalonEvent$SaveCurrent(this.salon);

  /// Current salon.
  final Salon salon;
}
