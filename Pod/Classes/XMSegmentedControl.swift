//
//  XMSegmentedControl.swift
//  XMSegmentedControl
//
//  Created by Xavier Merino on 9/29/15.
//  Copyright © 2015 Xavier Merino. All rights reserved.
//

import UIKit


///The delegate of `XMSegmentedControl` must adopt `XMSegmentedControlDelegate` protocol. It allows retrieving information on which segment was tapped.
public protocol XMSegmentedControlDelegate {
    /// Tells the delegate that a specific segment is now selected.
    func xmSegmentedControl(xmSegmentedControl: XMSegmentedControl, selectedSegment:Int)
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
*/
public enum XMContentType {
    case Text
    case Icon
}

@IBDesignable
public class XMSegmentedControl: UIView {
    public var delegate:XMSegmentedControlDelegate?
    private var highlightView:UIView!
    
    /**
    Defines the height of the highlighted edge if `selectedItemHighlightStyle` is either `TopEdge` or `BottomEdge`
    - Note: Changes only take place if `selectedItemHighlightStyle` is either `TopEdge` or `BottomEdge`
    */
    public var edgeHighlightHeight:CGFloat = 5.0
    
    /// Changes the background of the selected segment.
    @IBInspectable public var highlightColor:UIColor = UIColor(red: 42/255, green: 132/255, blue: 210/255, alpha: 1) {
        didSet {
            update()
        }
    }
    
    /// Changes the font color or the icon tint color for the segments.
    @IBInspectable public var tint:UIColor = UIColor.whiteColor() {
        didSet {
            update()
        }
    }
    
    /// Changes the font color or the icon tint for the selected segment.
    @IBInspectable public var highlightTint:UIColor = UIColor.whiteColor() {
        didSet {
            update()
        }
    }
    
    /**
    Sets the segmented control content type to `Text` and uses the content of the array to create the segments.
    - Note: Only six elements will be displayed.
    */
    public var segmentTitle:[String] = []{
        didSet {
            segmentTitle = segmentTitle.count > 6 ? Array(segmentTitle[0..<6]) : segmentTitle
            contentType = .Text
            update()
        }
    }
    
    /**
    Sets the segmented control content type to `Icon` and uses the content of the array to create the segments.
    - Note: Only six elements will be displayed.
    */
    public var segmentIcon:[UIImage] = []{
        didSet {
            segmentIcon = segmentIcon.count > 6 ? Array(segmentIcon[0..<6]) : segmentIcon
            contentType = .Icon
            update()
        }
    }
    
    /**
    Sets the font for the text displayed in the segmented control if `contentType` is `Text`
    - Note: Changes only take place if `contentType` is `Text`
    */
    public var font:UIFont = UIFont(name: "AvenirNext-DemiBold", size: 15)!
    
    /// Sets the segmented control selected item highlight style to `Background`, `TopEdge` or `BottomEdge`.
    public var selectedItemHighlightStyle:XMSelectedItemHighlightStyle = .Background
    
    /// Sets the segmented control content type to `Text` or `Icon`
    public var contentType:XMContentType = .Text
    
    /// Initializes and returns a newly allocated XMSegmentedControl object with the specified frame rectangle. It sets the segments of the control from the given `segmentTitle` array and the highlight style for the selected item.
    public init (frame: CGRect, segmentTitle: [String], selectedItemHighlightStyle:XMSelectedItemHighlightStyle) {
        super.init (frame: frame)
        commonInit(segmentTitle, highlightStyle: selectedItemHighlightStyle)
    }
    
    /// Initializes and returns a newly allocated XMSegmentedControl object with the specified frame rectangle. It sets the segments of the control from the given `segmentIcon` array and the highlight style for the selected item.
    public init (frame: CGRect, segmentIcon: [UIImage], selectedItemHighlightStyle:XMSelectedItemHighlightStyle) {
        super.init (frame: frame)
        commonInit(segmentIcon, highlightStyle: selectedItemHighlightStyle)
    }
    
    /// Common initializer.
    private func commonInit(data:[AnyObject], highlightStyle:XMSelectedItemHighlightStyle){
        if let segmentTitle = data as? [String] {
            self.segmentTitle = segmentTitle
        } else if let segmentIcon = data as? [UIImage] {
            self.segmentIcon = segmentIcon
        }
        self.backgroundColor = UIColor(red: 45/255, green: 62/255, blue: 100/255, alpha: 1)
        self.selectedItemHighlightStyle = highlightStyle
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(red: 45/255, green: 62/255, blue: 100/255, alpha: 1)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = UIColor(red: 45/255, green: 62/255, blue: 100/255, alpha: 1)
    }
    
    /**
    Prepares the render of the view for the Storyboard.
    */
    override public func prepareForInterfaceBuilder() {
        segmentTitle = ["Only", "For", "Show"]
        self.backgroundColor = UIColor(red: 45/255, green: 62/255, blue: 100/255, alpha: 1)
    }
    
    override public func layoutSubviews() {
        update()
    }
    
    /// Forces the segmented control to reload.
    public func update(){
        func addSegments(startingPosition starting:CGFloat, sections:Int, width:CGFloat, height:CGFloat){
            for (var i = 0; i < sections; i++){
                let frame = CGRect(x: starting + (CGFloat(i) * width), y: 0, width: width, height: height)
                let tab:UIButton = UIButton(type: UIButtonType.System)
                tab.frame = frame
                
                switch contentType {
                case .Icon:
                    tab.imageEdgeInsets = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
                    tab.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
                    tab.tintColor = i == 0 ? highlightTint : tint
                    tab.setImage(segmentIcon[i], forState: .Normal)
                    
                case .Text:
                    tab.setTitle(segmentTitle[i], forState: .Normal)
                    tab.setTitleColor(i == 0 ? highlightTint : tint, forState: .Normal)
                    tab.titleLabel?.font = font
                }
                
                tab.tag = i
                tab.addTarget(self, action: "segmentPressed:", forControlEvents: UIControlEvents.TouchUpInside)
                self.addSubview(tab)
            }
        }
        
        func addHighlightView(startingPosition starting:CGFloat, width:CGFloat){
            switch selectedItemHighlightStyle {
            case .Background:
                highlightView = UIView(frame: CGRect(x: starting, y: 0, width: width, height: self.frame.height))
            case .TopEdge:
                highlightView = UIView(frame: CGRect(x: starting, y: 0, width: width, height: edgeHighlightHeight))
            case .BottomEdge:
                highlightView = UIView(frame: CGRect(x: starting, y: self.frame.height - edgeHighlightHeight, width: width, height: edgeHighlightHeight))
            }
            highlightView.backgroundColor = highlightColor
            self.addSubview(highlightView)
        }
        
        (self.subviews as [UIView]).forEach { $0.removeFromSuperview() }
        let totalWidth = self.frame.width
        
        if contentType == .Text {
            let tabBarSections:Int = segmentTitle.count
            let sectionWidth = totalWidth / CGFloat(tabBarSections)
            addHighlightView(startingPosition: 0, width: sectionWidth)
            addSegments(startingPosition: 0, sections: tabBarSections, width: sectionWidth, height: self.frame.height)
        } else {
            let tabBarSections:Int = segmentIcon.count
            let sectionWidth = totalWidth / 6
            let availableSpace = totalWidth - (sectionWidth * CGFloat(6 - tabBarSections))
            let startingXPosition = (totalWidth - availableSpace) / 2
            addHighlightView(startingPosition: startingXPosition, width: sectionWidth)
            addSegments(startingPosition: startingXPosition, sections: tabBarSections, width: sectionWidth, height: self.frame.height)
        }
    }
    
    
    /// Called whenever a segment is pressed. Sends the information to the delegate.
    @objc private func segmentPressed(sender:UIButton){
        
        func isUIButton(view:UIView) -> Bool {
            return view is UIButton ? true : false
        }
        
        let xPosition:CGFloat = sender.frame.origin.x
        let newPosition:CGPoint = CGPoint(x: xPosition, y: highlightView.frame.origin.y)
        
        UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            self.highlightView.frame.origin = newPosition
            
            switch(self.contentType){
            case .Icon:
                ((self.subviews.filter(isUIButton)) as! [UIButton]).forEach { $0.tintColor = self.tint }
                sender.tintColor = self.highlightTint
            case .Text:
                ((self.subviews.filter(isUIButton)) as! [UIButton]).forEach { $0.setTitleColor(self.tint, forState: .Normal) }
                sender.setTitleColor(self.highlightTint, forState: .Normal)
            }
            
            }, completion: nil)
        
        delegate?.xmSegmentedControl(self, selectedSegment: sender.tag)
    }
}