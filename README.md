# XMSegmentedControl

[![Version](https://img.shields.io/cocoapods/v/XMSegmentedControl.svg?style=flat)](http://cocoapods.org/pods/XMSegmentedControl)
[![License](https://img.shields.io/cocoapods/l/XMSegmentedControl.svg?style=flat)](http://cocoapods.org/pods/XMSegmentedControl)
[![Platform](https://img.shields.io/cocoapods/p/XMSegmentedControl.svg?style=flat)](http://cocoapods.org/pods/XMSegmentedControl)

## Overview

XMSegmentedControl is a customizable segmented control. It allows using Text, Icons, or a combination of Icons and Text as the segments.

![Screenshot](https://dl.dropboxusercontent.com/u/72507896/XMSegmentedControlScreenshots/screenshot1.png)

## Requirements

* iOS8+

## Installation

XMSegmentedControl is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "XMSegmentedControl"
```

## Usage

* Import XMSegmentedControl into your project. 

```Swift
import XMSegmentedControl
```

* Use the Storyboard and drag a UIView. 
* Select the view and under the Identity Inspector select `XMSegmentedControl` under class. 

Alternatively, create a XMSegmentedControl from code.

```Swift
let backgroundColor = UIColor(red: 205/255, green: 74/255, blue: 1/255, alpha: 1)
let highlightColor = UIColor(red: 226/255, green: 114/255, blue: 31/255, alpha: 1)

let titles = ["Hello", "World", "Two"]
let frame = CGRect(x: 0, y: 114, width: self.view.frame.width, height: 44)

let segmentedControl2 = XMSegmentedControl(frame: frame, segmentTitle: titles, selectedItemHighlightStyle: .BottomEdge)

segmentedControl2.backgroundColor = backgroundColor
segmentedControl2.highlightColor = highlightColor
segmentedControl2.tint = UIColor.whiteColor()
segmentedControl.delegate = self

self.view.addSubview(segmentedControl2)
```
* Conform to the `XMSegmentedControlDelegate` protocol by implementing `func xmSegmentedControl(xmSegmentedControl: XMSegmentedControl, selectedSegment: Int)` to receive notifications on which segment was selected.

```Swift
func xmSegmentedControl(xmSegmentedControl: XMSegmentedControl, selectedSegment: Int) {
print("SegmentedControl Selected Segment: \(selectedSegment)")
}
```
For more examples see the Example Project provided.

## Example Project

To run the example project, clone the repo, and run `pod install` from the Example directory first.
Icons in the example project are provided by icons8.com

## Author

Xavier Merino, xaviermerino@gmail.com

## License

XMSegmentedControl is available under the MIT license. See the LICENSE file for more info.

