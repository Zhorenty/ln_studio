/// Business Logic Component News_event Events
sealed class NewsEvent {
  const NewsEvent();

  /// Fetch
  const factory NewsEvent.fetchAll() = NewsEvent$FetchAll;
}

/// Fetch all Newss.
class NewsEvent$FetchAll extends NewsEvent {
  const NewsEvent$FetchAll();
}
