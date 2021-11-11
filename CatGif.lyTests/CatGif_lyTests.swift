/*
 * 2021 Aidan Haley
 */

import XCTest
@testable import CatGif_ly

class CatGif_lyTests: XCTestCase {
    
    var sut: FeedView.FeedViewModel!

    override func setUpWithError() throws {
        sut = FeedView.FeedViewModel.init(service: MockAPIService())
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    //MARK: - Tests
    
    func test_getPosts() {
        XCTAssertTrue(sut.posts.isEmpty)
        
        sut.getPosts()
        
        XCTAssertEqual(sut.posts.count, 3)
    }

}
