import XCTest
@testable import GiltKit

class SaleTests: XCTestCase {

    func testDictionaryInit() {
        let dictionary = [
            "name": "Video Games",
            "description": "The best video games",
            "image_urls": [
                "676x686": [
                    [
                        "url": "http://cdn1.gilt.com/images/share/uploads/0000/0005/0632/506321259/orig.jpg"
                    ]
                ]
            ],
            "size": 15,
            "store": "kids"
        ]
        let sale = Sale(dictionary: dictionary)!
        XCTAssertNotNil(sale)
    }
}
