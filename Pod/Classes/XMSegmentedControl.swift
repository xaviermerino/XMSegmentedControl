//
//  XMSegmentedControl.swift
//  XMSegmentedControl
//
//  Created by Xavier Merino on 9/29/15.
//  Updated by Xavier Merino on 11/28/15.
//  Copyright © 2015 Xavier Merino. All rights reserved.
//

import UIKit

///The delegate of `XMSegmentedControl` must adopt `XMSegmentedControlDelegate` protocol. It allows retrieving information on which segment was tapped.
public protocol XMSegmentedControlDelegate {
    /// Tells the delegate that a specific segment is now selected.
    func xmSegmentedControl(xmSegmentedControl: XMSegmentedControl, selectedSegment: Int)
}

/**
 Highlighted Styles for the selected segments.
 - Background: The background of the selected segment is highlighted.
 - TopEdge: The top edge of the selected segment is highlighted.
 - BottomEdge: The bottom edge of the selected segmenet is highlighted.
 */
public enum XMSelectedItemHighlightStyle {
    case Background
    case TopEdge
    case BottomEdge
}

/**
 Content Type for the segmented control.
 - Text: The segmented control displays only text.
 - Icon: The segmented control displays only icons/images.
 - Hybrid: The segmented control displays icons and text.
 - HybridVertical: The segmented control displays icons and text in vertical arrangement.
 */
public enum XMContentType {
    case Text
    case Icon
    case Hybrid
    case HybridVertical
}

@IBDesignable
public class XMSegmentedControl: UIView {

    public var delegate: XMSegmentedControlDelegate?
    private var highlightView: UIView!
    
    /**
     Defines the height of the highlighted edge if `selectedItemHighlightStyle` is either `TopEdge` or `BottomEdge`
     - Note: Changes only take place if `selectedItemHighlightStyle` is either `TopEdge` or `BottomEdge`
     */
    public var edgeHighlightHeight: CGFloat = 5.0
    
    /// Changes the background of the selected segment.
    @IBInspectable public var highlightColor = UIColor(red: 42/255, green: 132/255, blue: 210/255, alpha: 1) {
        didSet {
            self.update()
        }
    }
    
    /// Changes the font color or the icon tint color for the segments.
    @IBInspectable public var tint = UIColor.whiteColor() {
        didSet {
            self.update()
        }
    }
    
    /// Changes the font color or the icon tint for the selected segment.
    @IBInspectable public var highlightTint = UIColor.whiteColor() {
        didSet {
            self.update()
        }
    }
    
    /**
     Sets the segmented control content type to `Text` and uses the content of the array to create the segments.
     - Note: Only six elements will be displayed.
     */
    public var segmentTitle: [String] = []{
        didSet {
            segmentTitle = segmentTitle.count > 6 ? Array(segmentTitle[0..<6]) : segmentTitle
            contentType = .Text
            self.update()
        }
    }
    
    /**
     Sets the segmented control content type to `Icon` and uses the content of the array to create the segments.
     - Note: Only six elements will be displayed.
     */
    public var segmentIcon: [UIImage] = []{
        didSet {
            segmentIcon = segmentIcon.count > 6 ? Array(segmentIcon[0..<6]) : segmentIcon
            contentType = .Icon
            self.update()
        }
    }
    
    /**
     Sets the segmented control content type to `Hybrid` (i.e. displaying icons and text) and uses the content of the tuple to create the segments.
     - Note: Only six elements will be displayed.
     */
    public var segmentContent: (text: [String], icon: [UIImage]) = ([], []) {
        didSet {
            guard segmentContent.text.count == segmentContent.icon.count else {
                print("Text and Icon arrays out of sync.")
                return
            }

            if segmentContent.text.count > 6 {
                segmentContent.text = Array(segmentContent.text[0..<6])
            } else {
                segmentContent.text = segmentContent.text
            }

            if segmentContent.icon.count > 6 {
                segmentContent.icon = Array(segmentContent.icon[0..<6])
            } else {
                segmentContent.icon = segmentContent.icon
            }

            segmentContent.icon = segmentContent.icon.map(resizeImage)

            contentType = .Hybrid
            self.update()
        }
    }

    /**
     Sets the segmented control content type to `HybridVertical` (i.e. displaying icons and text in vertical arrangement) and uses the content of the tuple to create the segments.
     - Note: Only six elements will be displayed.
     */

    public func setupVerticalSegmentContent(content: (text: [String], icon: [UIImage])) {
        segmentContent = content

        contentType = .HybridVertical
        self.update()
    }
    
    
    /// The segment index of the selected item.
    public var selectedSegment: Int = 0
    
    /**
     Sets the font for the text displayed in the segmented control if `contentType` is `Text`
     - Note: Changes only take place if `contentType` is `Text`
     */
    public var font = UIFont(name: "AvenirNext-DemiBold", size: 15)!
    
    /// Sets the segmented control selected item highlight style to `Background`, `TopEdge` or `BottomEdge`.
    public var selectedItemHighlightStyle: XMSelectedItemHighlightStyle = .Background
    
    /// Sets the segmented control content type to `Text` or `Icon`
    public var contentType: XMContentType = .Text
    
    /// Initializes and returns a newly allocated XMSegmentedControl object with the specified frame rectangle. It sets the segments of the control from the given `segmentTitle` array and the highlight style for the selected item.
    public init (frame: CGRect, segmentTitle: [String], selectedItemHighlightStyle: XMSelectedItemHighlightStyle) {
        super.init (frame: frame)

        self.commonInit(segmentTitle, highlightStyle: selectedItemHighlightStyle)
    }
    
    /// Initializes and returns a newly allocated XMSegmentedControl object with the specified frame rectangle. It sets the segments of the control from the given `segmentIcon` array and the highlight style for the selected item.
    public init (frame: CGRect, segmentIcon: [UIImage], selectedItemHighlightStyle: XMSelectedItemHighlightStyle) {
        super.init (frame: frame)

        self.commonInit(segmentIcon, highlightStyle: selectedItemHighlightStyle)
    }
    
    /// Initializes and returns a newly allocated XMSegmentedControl object with the specified frame rectangle. It sets the segments of the control from the given `segmentContent` tuple and the highlight style for the selected item. Notice that the tuple consists of an array containing the titles and another array containing the icons. The two arrays must be the same size.
    public init (frame: CGRect, segmentContent: ([String], [UIImage]), selectedItemHighlightStyle: XMSelectedItemHighlightStyle) {
        super.init (frame: frame)

        self.commonInit(segmentContent, highlightStyle: selectedItemHighlightStyle)
    }

    /**
     Initializes and returns a newly allocated XMSegmentedControl object with the specified frame rectangle. It sets the segments of the control from the given `verticalSegmentContent` tuple and the highlight style for the selected item. Notice that the tuple consists of an array containing the titles and another array containing the icons. The two arrays must be the same size.

     The `contentType` is `HybridVertical`
    */
    public convenience init (frame: CGRect, verticalSegmentContent: ([String], [UIImage]), selectedItemHighlightStyle:XMSelectedItemHighlightStyle) {
        self.init (frame: frame, segmentContent: verticalSegmentContent, selectedItemHighlightStyle: selectedItemHighlightStyle)
        setupVerticalSegmentContent(verticalSegmentContent)
    }
    
    /// Common initializer.
    private func commonInit(data: Any, highlightStyle: XMSelectedItemHighlightStyle) {
        if let segmentTitle = data as? [String] {
            self.segmentTitle = segmentTitle
        } else if let segmentIcon = data as? [UIImage] {
            self.segmentIcon = segmentIcon
        } else if let segmentContent = data as? ([String], [UIImage]) {
            self.segmentContent = segmentContent
        }

        backgroundColor = UIColor(red: 45/255, green: 62/255, blue: 100/255, alpha: 1)
        selectedItemHighlightStyle = highlightStyle
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = UIColor(red: 45/255, green: 62/255, blue: 100/255, alpha: 1)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        backgroundColor = UIColor(red: 45/255, green: 62/255, blue: 100/255, alpha: 1)
    }
    
    /// Prepares the render of the view for the Storyboard.
    override public func prepareForInterfaceBuilder() {
        segmentTitle = ["Only", "For", "Show"]
        backgroundColor = UIColor(red: 45/255, green: 62/255, blue: 100/255, alpha: 1)
    }
    
    override public func layoutSubviews() {
        self.update()
    }
    
    /// Forces the segmented control to reload.
    public func update() {
        func addSegments(startingPosition starting: CGFloat, sections: Int, width: CGFloat, height: CGFloat) {
            for (var i = 0; i < sections; i++) {
                let frame = CGRect(x: starting + (CGFloat(i) * width), y: 0, width: width, height: height)
                let tab = UIButton(type: UIButtonType.System)
                tab.frame = frame
                
                switch contentType {
                case .Icon:
                    tab.imageEdgeInsets = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
                    tab.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
                    tab.tintColor = i == selectedSegment ? highlightTint : tint
                    tab.setImage(segmentIcon[i], forState: .Normal)
                case .Text:
                    tab.setTitle(segmentTitle[i], forState: .Normal)
                    tab.setTitleColor(i == selectedSegment ? highlightTint : tint, forState: .Normal)
                    tab.titleLabel?.font = font
                case .Hybrid:
                    let insetAmount: CGFloat = 8 / 2.0
                    tab.imageEdgeInsets = UIEdgeInsetsMake(12, -insetAmount, 12, insetAmount)
                    tab.titleEdgeInsets = UIEdgeInsetsMake(0, insetAmount*2, 0, 0)
                    tab.contentEdgeInsets = UIEdgeInsetsMake(0, insetAmount, 0, insetAmount)
                    tab.contentHorizontalAlignment = .Center
                    tab.setTitle(segmentContent.text[i], forState: .Normal)
                    tab.setImage(segmentContent.icon[i], forState: .Normal)
                    tab.titleLabel?.font = font
                    tab.imageView?.contentMode = .ScaleAspectFit
                    tab.tintColor = i == selectedSegment ? highlightTint : tint
                case .HybridVertical:
                    let insetAmount: CGFloat = 8 / 2.0
                    let bottomTitleInset: CGFloat = 20

                    let image: UIImage = segmentContent.icon[i]
                    let imageSize = image.size
                    let horizontalInset = (width - imageSize.width)/2

                    tab.imageEdgeInsets = UIEdgeInsetsMake(insetAmount*2, horizontalInset, height - imageSize.height + insetAmount, horizontalInset)
                    tab.titleEdgeInsets = UIEdgeInsetsMake(height - bottomTitleInset, -imageSize.width / 2, insetAmount*2, imageSize.width / 2)
                    tab.contentEdgeInsets = UIEdgeInsetsMake(0, insetAmount, 0, insetAmount)
                    tab.contentHorizontalAlignment = .Center
                    tab.setTitle(segmentContent.text[i], forState: .Normal)
                    tab.setImage(image, forState: .Normal)
                    tab.titleLabel?.font = UIFont(name: font.fontName, size: font.pointSize / 2.0)
                    tab.imageView?.contentMode = .ScaleAspectFit
                    tab.tintColor = i == selectedSegment ? highlightTint : tint
                }
                
                tab.tag = i
                tab.addTarget(self, action: "segmentPressed:", forControlEvents: .TouchUpInside)
                self.addSubview(tab)
            }
        }
        
        func addHighlightView(startingPosition starting: CGFloat, width: CGFloat) {
            switch selectedItemHighlightStyle {
            case .Background:
                highlightView = UIView(frame: CGRect(x: starting, y: 0, width: width, height: frame.height))
            case .TopEdge:
                highlightView = UIView(frame: CGRect(x: starting, y: 0, width: width, height: edgeHighlightHeight))
            case .BottomEdge:
                highlightView = UIView(frame: CGRect(x: starting, y: frame.height - edgeHighlightHeight, width: width, height: edgeHighlightHeight))
            }

            highlightView.backgroundColor = highlightColor
            self.addSubview(highlightView)
        }
        
        (subviews as [UIView]).forEach { $0.removeFromSuperview() }
        let totalWidth = frame.width

        if contentType == .Text {
            guard segmentTitle.count > 0 else {
                print("segment titles (segmentTitle) are not set")
                return
            }

            let tabBarSections = segmentTitle.count
            let sectionWidth = totalWidth / CGFloat(tabBarSections)
            addHighlightView(startingPosition: CGFloat(selectedSegment) * sectionWidth, width: sectionWidth)
            addSegments(startingPosition: 0, sections: tabBarSections, width: sectionWidth, height: frame.height)
        } else if contentType == .Icon {
            let tabBarSections = segmentIcon.count
            let sectionWidth = totalWidth / 6
            let availableSpace = totalWidth - (sectionWidth * CGFloat(6 - tabBarSections))
            let startingXPosition = (totalWidth - availableSpace) / 2
            addHighlightView(startingPosition: startingXPosition + (sectionWidth * CGFloat(selectedSegment)), width: sectionWidth)
            addSegments(startingPosition: startingXPosition, sections: tabBarSections, width: sectionWidth, height: frame.height)
        } else { // Hybrid
            let tabBarSections = segmentContent.text.count
            let sectionWidth = totalWidth / CGFloat(tabBarSections)
            addHighlightView(startingPosition: CGFloat(selectedSegment) * sectionWidth, width: sectionWidth)
            addSegments(startingPosition: 0, sections: tabBarSections, width: sectionWidth, height: frame.height)
        }
    }
    
    /// Called whenever a segment is pressed. Sends the information to the delegate.
    @objc private func segmentPressed(sender: UIButton) {
        func isUIButton(view: UIView) -> Bool {
            return view is UIButton ? true : false
        }

        let xPosition = sender.frame.origin.x
        let newPosition = CGPoint(x: xPosition, y: highlightView.frame.origin.y)
        
        UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            self.highlightView.frame.origin = newPosition
            
            switch(self.contentType) {
            case .Icon, .Hybrid, .HybridVertical:
                ((self.subviews.filter(isUIButton)) as! [UIButton]).forEach { $0.tintColor = self.tint }
                sender.tintColor = self.highlightTint
            case .Text:
                ((self.subviews.filter(isUIButton)) as! [UIButton]).forEach { $0.setTitleColor(self.tint, forState: .Normal) }
                sender.setTitleColor(self.highlightTint, forState: .Normal)
            }
            
            }, completion: nil)
        
        selectedSegment = sender.tag
        delegate?.xmSegmentedControl(self, selectedSegment: selectedSegment)
    }
    
    /// Press indexed tab
    public func pressTabWithIndex(index: Int) {
        for subview in self.subviews where subview.tag == index {
            if subview is UIButton {
                segmentPressed(subview as! UIButton)
                return
            }
        }
    }
    
    /// Scales an Image to the size provided. It takes into account alpha. And it uses the screen's scale to resize.
    private func resizeImage(image:UIImage) -> UIImage {
        let maxSize = CGSize(width: frame.height / 2, height: frame.height / 2)
        let ratio = image.size.width / image.size.height
        let size = CGSize(width: maxSize.width*ratio, height: maxSize.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        image.drawInRect(CGRect(origin: CGPointZero, size: size))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return scaledImage
    }
}