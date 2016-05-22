import XCTest
import DVR
@testable import GiltKit

class ClientTests: XCTestCase {

    func testListSales() {
        let dvr = Session(cassetteName: "api-listSales")
        let expectation = expectationWithDescription("Network")


        let client = Client(session: dvr)
        client.listSalesForStore(.Men, kind: .Upcoming) {
            XCTAssertLessThan(0, $0.count)
            expectation.fulfill()
        }
        waitForExpectationsWithTimeout(10, handler: nil)
    }
}
