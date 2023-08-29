// Unsupported runner.
Future<void> run() => _throw();

/// Throws an [UnsupportedError] to indicate this platform is unsupported.
Never _throw() => throw UnsupportedError('Cannot run on this platform');
