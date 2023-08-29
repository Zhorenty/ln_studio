import '/runner_unsupported.dart'
    if (dart.library.html) 'runner_web.dart'
    if (dart.library.io) 'runner_io.dart' as runner;

/// Entry point of application.
Future<void> main() async => runner.run();
