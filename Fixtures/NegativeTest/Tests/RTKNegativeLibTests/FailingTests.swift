import Testing
@testable import RTKNegativeLib

@Test func alwaysFails() async throws {
    #expect(stub() == 99, "Simulated test failure for `rtk swift test` negative runs.")
}
