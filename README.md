# XMSegmentedControl

[![Version](https://img.shields.io/cocoapods/v/XMSegmentedControl.svg?style=flat)](http://cocoapods.org/pods/XMSegmentedControl)
[![License](https://img.shields.io/cocoapods/l/XMSegmentedControl.svg?style=flat)](http://cocoapods.org/pods/XMSegmentedControl)
[![Platform](https://img.shields.io/cocoapods/p/XMSegmentedControl.svg?style=flat)](http://cocoapods.org/pods/XMSegmentedControl)

## Overview
XMSegmentedControl is a customizable segmented control. It allows using Text, Icons, or a combination of Icons and Text as the segments.

![Screenshot](http://zippy.gfycat.com/SlimZestyGermanspitz.gif)

## Requirements
* iOS 8+

## Installation
You can install XMSegmentedControl manually by simply copying `XMSegmentedControl.swift` into your project's workspace.  

XMSegmentedControl is available through [CocoaPods](http://cocoapods.org).  To install it, simply add the following line to your Podfile:

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
* Conform to the `XMSegmentedControlDelegate` protocol by implementing `func xmSegmentedControl(xmSegmentedControl: XMSegmentedControl, selectedSegment: Int)` to receive notifications on which segment was selected.

```Swift
func xmSegmentedControl(xmSegmentedControl: XMSegmentedControl, selectedSegment: Int) {
print("SegmentedControl Selected Segment: \(selectedSegment)")
}
```
Alternatively, create a XMSegmentedControl from code.

### Text Only Segmented Control
The example below creates a text-only segmented control.
```Swift
let segmentedControl3 = XMSegmentedControl(frame: CGRect(x: 0, y: 164, width: self.view.frame.width, height: 44), segmentTitle: ["Hello", "World", "Three"], selectedItemHighlightStyle: XMSelectedItemHighlightStyle.TopEdge)

segmentedControl3.backgroundColor = UIColor(red: 22/255, green: 150/255, blue: 122/255, alpha: 1)
segmentedControl3.highlightColor = UIColor(red: 25/255, green: 180/255, blue: 145/255, alpha: 1)
segmentedControl3.tint = UIColor.whiteColor()
segmentedControl3.highlightTint = UIColor.blackColor()

self.view.addSubview(segmentedControl3)
```

![TextOnly](https://dl.dropboxusercontent.com/u/72507896/XMSegmentedControlScreenshots/textonly.png)

### Icon Only Segmented Control
The example below creates an icon-only segmented control.
``` Swift
let icons1:[UIImage] = [UIImage(named: "icon1")!, UIImage(named: "icon2")!, UIImage(named: "icon3")!, UIImage(named: "icon4")!, UIImage(named: "icon5")!, UIImage(named: "icon6")!]

let segmentedControl4 = XMSegmentedControl(frame: CGRect(x: 0, y: 214, width: self.view.frame.width, height: 44), segmentIcon: icons1, selectedItemHighlightStyle: XMSelectedItemHighlightStyle.Background)

segmentedControl4.backgroundColor = UIColor(red: 128/255, green: 59/255, blue: 159/255, alpha: 1)
segmentedControl4.highlightColor = UIColor(red: 144/255, green: 79/255, blue: 173/255, alpha: 1)
segmentedControl4.tint = UIColor.whiteColor()

self.view.addSubview(segmentedControl4)
```

![IconOnly](https://dl.dropboxusercontent.com/u/72507896/XMSegmentedControlScreenshots/icononly.png)

### Icon + Text Segmented Control
The example below creates an Icon + Text segmented control.
``` Swift
let backgroundColor = UIColor(red: 205/255, green: 74/255, blue: 1/255, alpha: 1)
let highlightColor = UIColor(red: 226/255, green: 114/255, blue: 31/255, alpha: 1)

let titles = ["Hello", "World", "Two"]
let icons = [UIImage(named: "icon1")!, UIImage(named: "icon2")!, UIImage(named: "icon3")!]
let frame = CGRect(x: 0, y: 114, width: self.view.frame.width, height: 44)

let segmentedControl2 = XMSegmentedControl(frame: frame, segmentContent: (titles, icons), selectedItemHighlightStyle: XMSelectedItemHighlightStyle.BottomEdge)

segmentedControl2.backgroundColor = backgroundColor
segmentedControl2.highlightColor = highlightColor
segmentedControl2.tint = UIColor.whiteColor()
segmentedControl2.highlightTint = UIColor.blackColor()

self.view.addSubview(segmentedControl2)
```

![IconText](https://dl.dropboxusercontent.com/u/72507896/XMSegmentedControlScreenshots/texticon.tiff)

For more examples see the Example Project provided.

## Example Project

To run the example project, clone the repo, and run `pod install` from the Example directory first.
Icons in the example project are provided by http://icons8.com

## Author

Xavier Merino, xaviermerino@gmail.com

## License

XMSegmentedControl is available under the MIT license. See the LICENSE file for more info.