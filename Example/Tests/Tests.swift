import UIKit
import XCTest
import XMSegmentedControl

@testable
import XMSegmentedControl_Example

class Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testContentTypeHybrid() {
        let titles = ["Hello", "World", "Two"]
        let icons = [UIImage(named: "icon1")!, UIImage(named: "icon2")!, UIImage(named: "icon3")!]

        let frame = CGRect(x: 0, y: 114, width: 375, height: 44)
        let segmentedControl = XMSegmentedControl(frame: frame, segmentContent: (titles, icons), selectedItemHighlightStyle: XMSelectedItemHighlightStyle.bottomEdge)
        XCTAssertEqual(titles, segmentedControl.segmentContent.text)
        XCTAssertEqual(icons.count, segmentedControl.segmentContent.icon.count)
        XCTAssertEqual(segmentedControl.contentType, XMContentType.hybrid)
    }

    func testContentTypeHybridVertical() {
        let titles = ["Hello", "World", "Two"]
        let icons = [UIImage(named: "icon1")!, UIImage(named: "icon2")!, UIImage(named: "icon3")!]

        let frame = CGRect(x: 0, y: 114, width: 375, height: 44)
        let segmentedControl = XMSegmentedControl(frame: frame, verticalSegmentContent: (titles, icons), selectedItemHighlightStyle: XMSelectedItemHighlightStyle.bottomEdge)
        XCTAssertEqual(titles, segmentedControl.segmentContent.text)
        XCTAssertEqual(icons.count, segmentedControl.segmentContent.icon.count)
        XCTAssertEqual(segmentedControl.contentType, XMContentType.hybridVertical)
    }

    func testContentTypeText() {
        let titles = ["Hello", "World", "Two"]

        let segmentedControl = XMSegmentedControl(frame: CGRect(x: 0, y: 224, width: 375, height: 44), segmentTitle: titles, selectedItemHighlightStyle: XMSelectedItemHighlightStyle.topEdge)
        XCTAssertEqual(titles, segmentedControl.segmentTitle)
        XCTAssertEqual(segmentedControl.contentType, XMContentType.text)
    }

    func testContentTypeIcon() {
        let icons: [UIImage] = [UIImage(named: "icon1")!, UIImage(named: "icon2")!, UIImage(named: "icon3")!, UIImage(named: "icon4")!, UIImage(named: "icon5")!, UIImage(named: "icon6")!]

        let segmentedControl = XMSegmentedControl(frame: CGRect(x: 0, y: 274, width: 375, height: 44), segmentIcon: icons, selectedItemHighlightStyle: XMSelectedItemHighlightStyle.background)
        XCTAssertEqual(icons, segmentedControl.segmentIcon)
        XCTAssertEqual(segmentedControl.contentType, XMContentType.icon)
    }

}
