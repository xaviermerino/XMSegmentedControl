//
//  ViewController.swift
//  XMSegmentedControl
//
//  Created by xaviermerino on 10/01/2015.
//  Copyright (c) 2015 Xavier Merino. All rights reserved.
//

import UIKit
import XMSegmentedControl

class ViewController: UIViewController, XMSegmentedControlDelegate {

    @IBOutlet weak var segmentedControl1: XMSegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
            Initialized from Storyboard
        */
        
        segmentedControl1.delegate = self
        segmentedControl1.segmentTitle = ["Hello", "World"]
        
        /*
            Examples created from code
            The segmented control can only display up to six elements. 
            It will ignore the excess.
        */
        
        // SegmentedControl2
        
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

        let backgroundColor8 = UIColor(red: 160/255, green: 74/255, blue: 1/255, alpha: 1)
        let highlightColor8 = UIColor(red: 181/255, green: 114/255, blue: 31/255, alpha: 1)

        let titles8 = ["Hello", "World", "Eight"]

        // SegmentedControl8
        let segmentedControl8 = XMSegmentedControl(frame: CGRect(x: 0, y: 164, width: self.view.frame.width, height: 44), verticalSegmentContent: (titles8, icons), selectedItemHighlightStyle: XMSelectedItemHighlightStyle.BottomEdge)
        segmentedControl8.backgroundColor = backgroundColor8
        segmentedControl8.highlightColor = highlightColor8
        segmentedControl8.tint = UIColor.whiteColor()
        segmentedControl8.highlightTint = UIColor.blackColor()

        self.view.addSubview(segmentedControl8)
        
        // SegmentedControl3
        
        let segmentedControl3 = XMSegmentedControl(frame: CGRect(x: 0, y: 214, width: self.view.frame.width, height: 44), segmentTitle: ["Hello", "World", "Three"], selectedItemHighlightStyle: XMSelectedItemHighlightStyle.TopEdge)
        segmentedControl3.backgroundColor = UIColor(red: 22/255, green: 150/255, blue: 122/255, alpha: 1)
        segmentedControl3.highlightColor = UIColor(red: 25/255, green: 180/255, blue: 145/255, alpha: 1)
        segmentedControl3.tint = UIColor.whiteColor()
        segmentedControl3.highlightTint = UIColor.blackColor()
        self.view.addSubview(segmentedControl3)
        
        // SegmentedControl4
        
        let icons1:[UIImage] = [UIImage(named: "icon1")!, UIImage(named: "icon2")!, UIImage(named: "icon3")!, UIImage(named: "icon4")!, UIImage(named: "icon5")!, UIImage(named: "icon6")!]
        let segmentedControl4 = XMSegmentedControl(frame: CGRect(x: 0, y: 264, width: self.view.frame.width, height: 44), segmentIcon: icons1, selectedItemHighlightStyle: XMSelectedItemHighlightStyle.Background)
        segmentedControl4.backgroundColor = UIColor(red: 128/255, green: 59/255, blue: 159/255, alpha: 1)
        segmentedControl4.highlightColor = UIColor(red: 144/255, green: 79/255, blue: 173/255, alpha: 1)
        segmentedControl4.tint = UIColor.whiteColor()
        self.view.addSubview(segmentedControl4)
        
        // SegmentedControl5
        
        let icons2:[UIImage] = [UIImage(named: "icon2")!, UIImage(named: "icon3")!, UIImage(named: "icon4")!, UIImage(named: "icon5")!, UIImage(named: "icon6")!, UIImage(named: "icon7")!, UIImage(named: "icon1")!]
        let segmentedControl5 = XMSegmentedControl(frame: CGRect(x: 0, y: 314, width: self.view.frame.width, height: 44), segmentIcon: icons2, selectedItemHighlightStyle: XMSelectedItemHighlightStyle.BottomEdge)
        segmentedControl5.backgroundColor = UIColor(red: 184/255, green: 50/255, blue: 38/255, alpha: 1)
        segmentedControl5.highlightColor = UIColor(red: 228/255, green: 66/255, blue: 53/255, alpha: 1)
        segmentedControl5.tint = UIColor.whiteColor()
        self.view.addSubview(segmentedControl5)
        
        // SegmentedControl6
        
        let icons3:[UIImage] = [UIImage(named: "icon2")!, UIImage(named: "icon3")!, UIImage(named: "icon4")!, UIImage(named: "icon5")!, UIImage(named: "icon6")!]
        let segmentedControl6 = XMSegmentedControl(frame: CGRect(x: 0, y: 364, width: self.view.frame.width, height: 44), segmentIcon: icons3, selectedItemHighlightStyle: XMSelectedItemHighlightStyle.TopEdge)
        segmentedControl6.backgroundColor = UIColor(red: 35/255, green: 164/255, blue: 85/255, alpha: 1)
        segmentedControl6.highlightColor = UIColor(red: 41/255, green: 197/255, blue: 102/255, alpha: 1)
        segmentedControl6.tint = UIColor.whiteColor()
        self.view.addSubview(segmentedControl6)
        
        // SegmentedControl7
        
        let icons4:[UIImage] = [UIImage(named: "icon2")!, UIImage(named: "icon3")!, UIImage(named: "icon4")!, UIImage(named: "icon5")!]
        let segmentedControl7 = XMSegmentedControl(frame: CGRect(x: 0, y: 414, width: self.view.frame.width, height: 44), segmentIcon: icons4, selectedItemHighlightStyle: XMSelectedItemHighlightStyle.Background)
        segmentedControl7.backgroundColor = UIColor(red: 39/255, green: 54/255, blue: 70/255, alpha: 1)
        segmentedControl7.highlightColor = UIColor(red: 118/255, green: 201/255, blue: 220/255, alpha: 1)
        segmentedControl7.tint = UIColor.whiteColor()
        segmentedControl7.highlightTint = UIColor(red: 39/255, green: 54/255, blue: 70/255, alpha: 1)
        self.view.addSubview(segmentedControl7)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func xmSegmentedControl(xmSegmentedControl: XMSegmentedControl, selectedSegment: Int) {
        if xmSegmentedControl == segmentedControl1 {
            print("SegmentedControl1 Selected Segment: \(selectedSegment)")
        }
    }
}

