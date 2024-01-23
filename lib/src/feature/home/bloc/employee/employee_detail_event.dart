/// Business Logic Component EmployeeDetail_event Events
sealed class EmployeeDetailEvent {
  const EmployeeDetailEvent();

  /// Fetch
  const factory EmployeeDetailEvent.fetchReviews(int employeeId) =
      EmployeeDetailEvent$FetchReviews;
}

/// Fetch all EmployeeDetails.
class EmployeeDetailEvent$FetchReviews extends EmployeeDetailEvent {
  const EmployeeDetailEvent$FetchReviews(this.employeeId);

  final int employeeId;
}
