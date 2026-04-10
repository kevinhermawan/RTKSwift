import Testing
@testable import RTKSwift

@Test func positiveAnswer() async throws {
    #expect(rtkAnswer() == 42)
}
