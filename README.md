# Synchronous Unit Tests

Mobile applications are usually multi-threaded. We perform UI operations on the main thread and dispatch heavy tasks (e.g. network requests, JSON parsing, writing to a file on a disk) to background threads. If we wanted to test an object that uses a background thread to perform work, we would use an `XCTestExpectation` and wait for an async operation to finish. Is there another option to test it?

[Video from the presentation](https://engineers.sg/video/synchronous-unit-tests-ios-dev-scout--2300)
