import UIKit
import XCTest
import LeagueAPI

class Tests: XCTestCase {

    var apiWrapper: MSCoreLeagueApi?
    
    override func setUp() {
        super.setUp()
        
        apiWrapper = MSCoreLeagueApi(withKey: "84361dd6-8ee9-4f8f-902b-6a3cc52672cf", usingRegion: .northAmerica)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        apiWrapper?.initializeStaticData()
        XCTAssert(true, "Pass")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure() {
            // Put the code you want to measure the time of here.
        }
    }
    
}
