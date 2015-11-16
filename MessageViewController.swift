//
//  MessageViewController.swift
//  WEEK3_CECILIA_HW
//
//  Created by Chang, Cecilia on 11/13/15.
//  Copyright © 2015 Cee. All rights reserved.
//

import UIKit

class MessageViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var MessageOnlyView: UIView!
    @IBOutlet weak var PopupView: UIView!
    @IBOutlet weak var FeedImageView: UIImageView!
    
    @IBOutlet weak var archiveIcon: UIImageView!
    @IBOutlet weak var deleteIcon: UIImageView!
    @IBOutlet weak var listIcon: UIImageView!
    @IBOutlet weak var laterIcon: UIImageView!
    

    @IBOutlet weak var LeftIconView: UIView!
    @IBOutlet weak var RightIconView: UIView!
    
    @IBOutlet weak var PanBackground: UIView!
    @IBOutlet weak var BigView: UIView!
    @IBOutlet var BigScrollViewPan: UIScreenEdgePanGestureRecognizer!
    
    var MessageOnlyOriginalCenter: CGPoint!
    var LeftIconOrigionalCenter: CGPoint!
    var RightIconOrigionalCenter: CGPoint!
    
    
    
    var BigViewOrigionalCenter: CGPoint!
    var OrigionalInitialCenter: CGPoint!
    var MessageLeftOffset: CGFloat!
    var MessageRightOffset: CGFloat!
    var MessageLeftOrigin: CGPoint!
    var MessageRightOrigin: CGPoint!
    
  
    var endState  = 0
    let list = 1
    let later = 2
    let archive = 3
    let delete = 4
    
    let YellowColor = UIColor(
        red:255/256,
        green:231/256,
        blue:83/256,
        alpha:1.0)


    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentSize = CGSize(width: 320, height: 1431)
        MessageOnlyOriginalCenter = MessageOnlyView.center
        RightIconOrigionalCenter = RightIconView.center
        LeftIconOrigionalCenter = LeftIconView.center
        BigViewOrigionalCenter = BigView.center


        
        BigScrollViewPan = UIScreenEdgePanGestureRecognizer(target: self, action: "onEdgePan:")
        BigScrollViewPan.edges = UIRectEdge.Left
        view.addGestureRecognizer(BigScrollViewPan)
        
       
        
        // Do any additional setup after loading the view.
        
//        Done with View Did Load, next = function x4
    }

    
  
    @IBAction func DidPanSingleMessage(panGestureRecognizer: UIPanGestureRecognizer) {
        
        let translation = panGestureRecognizer.translationInView(view)
    
        if panGestureRecognizer.state == UIGestureRecognizerState.Began {
    
        } else if panGestureRecognizer.state == UIGestureRecognizerState.Changed {
    //print("Gesture changed at: \(point)")
            let newCenterX = MessageOnlyOriginalCenter.x + translation.x
            MessageOnlyView.center = CGPoint(x: newCenterX, y: MessageOnlyOriginalCenter.y)
            
    
            //change the look underneath
            changePanVisual( translation.x )
        }
        else if panGestureRecognizer.state == UIGestureRecognizerState.Ended {
            //print("Gesture ended at: \(point)")
            print("endstate pan else ", endState)
            
            //trigger the next step
            if (endState == later){
                print("show reschedule view now ")
                UIView.animateWithDuration(0.4) { () -> Void in
                    self.PopupView.alpha =  1
                }
                
                
            }else {
                
                //upon releasing, return to original position
                resetVisuals()
                
                
            }
            
            
            
            }
            
    }
    
    func changePanVisual( dx: CGFloat ){
        // print(dx)
        
        // list icon, brown bg
        if (dx < -260 ){
            PanBackground.backgroundColor = UIColor.brownColor()
            RightIconView.center.x = RightIconOrigionalCenter.x + 60 + dx
            laterIcon.alpha = 0
            listIcon.alpha = 1
            endState = list
        }
            //later icon moves with the message, yellow bg
        else if (dx < -60){
            PanBackground.backgroundColor = YellowColor
            RightIconView.center.x = RightIconOrigionalCenter.x + 60 + dx
            laterIcon.alpha = 1
            listIcon.alpha = 0
            endState = later
        }
            //start to show later icon, grey bg
        else if (dx < 0 ){
            PanBackground.backgroundColor = UIColor.lightGrayColor()
            
            //later icon alpha transition from 0 to 1
            laterIcon.alpha = dx/(-60)
            listIcon.alpha = 0
            
            
        }
            // start to show archive icon, grey bg
        else if (dx < 60 ){
            PanBackground.backgroundColor = UIColor.lightGrayColor()
            
            archiveIcon.alpha = dx/60
        }
            //show archive icon, green bg
        else if (dx < 260){
            archiveIcon.alpha = 1
            LeftIconView.center.x = LeftIconOrigionalCenter.x - 60 + dx
            deleteIcon.alpha = 0
            PanBackground.backgroundColor = UIColor.greenColor()
            
            
            endState = archive
            
            
        }
            // show delete icon, red bg
        else {
            deleteIcon.alpha = 1
            archiveIcon.alpha = 0
            LeftIconView.center.x = LeftIconOrigionalCenter.x - 60 + dx
            PanBackground.backgroundColor = UIColor.redColor()
            endState = delete
            
        }
    }
    
    
    //initalize all icons to be transparent
    //and background to be grey
    func resetVisuals(){
        //TODO add animation
        MessageOnlyView.center = MessageOnlyOriginalCenter
        RightIconView.center = RightIconOrigionalCenter
        LeftIconView.center = LeftIconOrigionalCenter
        
        archiveIcon.alpha =  0
        deleteIcon.alpha = 0
        laterIcon.alpha = 0
        listIcon.alpha = 0
        
        PanBackground.backgroundColor = UIColor.lightGrayColor()
        
        RightIconView.center = RightIconOrigionalCenter
        LeftIconView.center = LeftIconOrigionalCenter
        
        endState  = 0
        
        PopupView.alpha =  0
    }
    

    
    @IBAction func didTapReschedulePopUpView(sender: UITapGestureRecognizer) {
        print("tap")
        //disappear
        UIView.animateWithDuration(0.4) { () -> Void in
            self.PopupView.alpha =  0
        }
        
        //move the feed up
        
        UIView.animateWithDuration(0.6) { () -> Void in
            self.FeedImageView.center.y  = self.FeedImageView.center.y  - 86
        }
    }
    
    @IBAction func didScreenEdgePan(sender: UIScreenEdgePanGestureRecognizer) {
    }
    func onEdgePan(panGestureRecognizer: UIScreenEdgePanGestureRecognizer){
        print("onedgepan")
        
        //        let point = panGestureRecognizer.locationInView(view) //the finger position
        
        let translation = panGestureRecognizer.translationInView(view) //the relavent movement
        
        
        
        if panGestureRecognizer.state == UIGestureRecognizerState.Began {
            
            //            print("Gesture began at: \(point)")
            
            
            
        } else if panGestureRecognizer.state == UIGestureRecognizerState.Changed {
            
            //            print("Gesture changed at: \(point)")
            
            BigView.center.x = BigViewOrigionalCenter.x + translation.x
            
            
            
        }
            
        else if panGestureRecognizer.state == UIGestureRecognizerState.Ended {
            
            
            let w = UIScreen.mainScreen().bounds.width
            if (BigView.center.x - BigViewOrigionalCenter.x < w/2.0){BigView.center.x = BigViewOrigionalCenter.x}
            
            else {
                BigView.center.x = BigViewOrigionalCenter.x + w + 20
            }
            
            
            
        }
        
    }

        override func didReceiveMemoryWarning(){
            super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
