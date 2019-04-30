//
//  RotationToolBar.swift
//  SceneKitTry1
//
//  Created by Jean-Baptiste Bolh on 4/1/19.
//  Copyright © 2019 ahollar. All rights reserved.
//

import UIKit
import SceneKit

class RotationToolBar : UIView{
    
    var viewController: StudioViewController
    var xAxisSlider: UISlider?
    var yAxisSlider: UISlider?
    var zAxisSlider: UISlider?
    var lastSectionXSlider: Int
    var lastSectionYSlider: Int
    var lastSectionZSlider: Int
    
    init(controller: StudioViewController){
        self.viewController = controller
        self.lastSectionXSlider = -1
        self.lastSectionYSlider = -1
        self.lastSectionZSlider = -1
        
        let toolbar = CGRect(x:0,y:500,width:300,height:300)
        super.init(frame: toolbar)
        
        backgroundColor = UIColor.init(red:0.7,green:0.7,blue:0.7, alpha: 0)
        populateWithRotationSliders()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func populateWithRotationSliders(){
       
        //Counter-clockwise 90deg transformation setup
        let trans = CGAffineTransform(rotationAngle: CGFloat(-.pi * 0.5));
        
        //Create X Slider
        self.xAxisSlider = UISlider(frame: CGRect(x: 25, y: 50, width: 150, height: 50)) //Remember that width determines height since we are rotation 90 deg
        xAxisSlider!.minimumValue = -8
        xAxisSlider!.maximumValue = 8
        xAxisSlider!.setValue(0, animated: false)
        xAxisSlider!.transform = trans //Applying transformation
        xAxisSlider!.addTarget(self, action:#selector(rotateAxis(sender:)), for: .valueChanged)
        xAxisSlider!.tag = 0
        addSubview(xAxisSlider!)
        
        //Create Y Slider
        self.yAxisSlider = UISlider(frame: CGRect(x: 75, y: 50, width: 150, height: 50)) //xAxis slider
        yAxisSlider!.minimumValue = -8
        yAxisSlider!.maximumValue = 8
        yAxisSlider!.setValue(0, animated: false)
        yAxisSlider!.transform = trans
        yAxisSlider!.addTarget(self, action:#selector(rotateAxis(sender:)), for: .valueChanged)
        yAxisSlider!.tag = 1
        addSubview(yAxisSlider!)
        
        //Create Z Slider
        self.zAxisSlider = UISlider(frame: CGRect(x: 125, y: 50, width: 150, height: 50)) //xAxis slider
        zAxisSlider!.minimumValue = -8
        zAxisSlider!.maximumValue = 8
        zAxisSlider!.setValue(0, animated: false)
        zAxisSlider!.transform = trans
        zAxisSlider!.addTarget(self, action:#selector(rotateAxis(sender:)), for: .valueChanged)
        zAxisSlider!.tag = 2
        addSubview(zAxisSlider!)

    }
    
    func scaleSliders(height: Double){
        var oldFrameX = xAxisSlider!.frame
        self.xAxisSlider!.frame = CGRect(x: oldFrameX.minX, y: oldFrameX.minY, width: oldFrameX.width, height: CGFloat(height))
        var oldFrameY = yAxisSlider!.frame
        self.yAxisSlider!.frame = CGRect(x: oldFrameY.minX, y: oldFrameY.minY, width: oldFrameY.width, height: CGFloat(height))
        var oldFrameZ = zAxisSlider!.frame
        self.zAxisSlider!.frame = CGRect(x: oldFrameZ.minX, y: oldFrameZ.minY, width: oldFrameZ.width, height: CGFloat(height))
    }
    
    @objc
    //Setting up Scroller Sections
    func rotateAxis(sender: UISlider){
        //print("Value is: ", Double(sender.value))
        if(viewController.getCurrentShape() == nil){
            print("No Object Selected")
        }
        else{
            let myEuler = viewController.getCurrentShape()!.eulerAngles
            
            //Determining desired rotation
            var scrollSection = Int(sender.value)
            print(scrollSection)
            
            ////////////////// MAPPING SCROLL SECTIONS TO ROTATIONS //////////////////
            //For each of these, we only rotate if the slider has changed sections, to prevent the same rotation happening over and over
            if(scrollSection == 0 && Int(scrollSection) != self.lastSectionXSlider){
                if(self.lastSectionXSlider == -1) {
                    if(sender.tag == 0){ viewController.getCurrentShape()!.eulerAngles = SCNVector3(myEuler.x+(.pi/6.0), myEuler.y, myEuler.z) }
                    else if(sender.tag == 1){ viewController.getCurrentShape()!.eulerAngles = SCNVector3(myEuler.x, myEuler.y+(.pi/6.0), myEuler.z) }
                    else if(sender.tag == 2){ viewController.getCurrentShape()!.eulerAngles = SCNVector3(myEuler.x, myEuler.y, myEuler.z+(.pi/6.0)) }
                }
                else if(self.lastSectionXSlider == 1){
                    if(sender.tag == 0){ viewController.getCurrentShape()!.eulerAngles = SCNVector3(myEuler.x-(.pi/6.0), myEuler.y, myEuler.z) }
                    else if(sender.tag == 1){ viewController.getCurrentShape()!.eulerAngles = SCNVector3(myEuler.x, myEuler.y-(.pi/6.0), myEuler.z) }
                    else if(sender.tag == 2){ viewController.getCurrentShape()!.eulerAngles = SCNVector3(myEuler.x, myEuler.y, myEuler.z-(.pi/6.0)) }
                }
                else{
                    viewController.getCurrentShape()!.eulerAngles = SCNVector3(myEuler.x, myEuler.y, myEuler.z)
                }
                self.lastSectionXSlider = 0
            }
                
                //Positive Rotations (Top Half of Slider)
            else if(scrollSection == 1 && Int(scrollSection) != self.lastSectionXSlider){
                //myQuat = eulerToQuaternion(r: .pi/6, p: Double(myEuler.y), y: Double(myEuler.z))
                //viewController.getCurrentShape()!.orientation = myQuat
                if(self.lastSectionXSlider == 0){
                    if(sender.tag == 0){ viewController.getCurrentShape()!.eulerAngles = SCNVector3(myEuler.x+(.pi/6.0), myEuler.y, myEuler.z) }
                    else if(sender.tag == 1){ viewController.getCurrentShape()!.eulerAngles = SCNVector3(myEuler.x, myEuler.y+(.pi/6.0), myEuler.z) }
                    else if(sender.tag == 2){ viewController.getCurrentShape()!.eulerAngles = SCNVector3(myEuler.x, myEuler.y, myEuler.z+(.pi/6.0)) }
                }
                else if(self.lastSectionXSlider == 2){
                    if(sender.tag == 0){ viewController.getCurrentShape()!.eulerAngles = SCNVector3(myEuler.x-(.pi/12.0), myEuler.y, myEuler.z) }
                    else if(sender.tag == 1){ viewController.getCurrentShape()!.eulerAngles = SCNVector3(myEuler.x, myEuler.y-(.pi/12.0), myEuler.z) }
                    else if(sender.tag == 2){ viewController.getCurrentShape()!.eulerAngles = SCNVector3(myEuler.x, myEuler.y, myEuler.z-(.pi/12.0)) }
                }
                self.lastSectionXSlider = 1
            }
            else if(scrollSection == 2 && Int(scrollSection) != self.lastSectionXSlider){
                if(self.lastSectionXSlider == 1){
                    if(sender.tag == 0){ viewController.getCurrentShape()!.eulerAngles = SCNVector3(myEuler.x+(.pi/12.0), myEuler.y, myEuler.z) }
                    else if(sender.tag == 1){ viewController.getCurrentShape()!.eulerAngles = SCNVector3(myEuler.x, myEuler.y+(.pi/12.0), myEuler.z) }
                    else if(sender.tag == 2){ viewController.getCurrentShape()!.eulerAngles = SCNVector3(myEuler.x, myEuler.y, myEuler.z+(.pi/12.0)) }
                }
                if(self.lastSectionXSlider == 3){
                    if(sender.tag == 0){ viewController.getCurrentShape()!.eulerAngles = SCNVector3(myEuler.x-(.pi/12.0), myEuler.y, myEuler.z) }
                    else if(sender.tag == 1){ viewController.getCurrentShape()!.eulerAngles = SCNVector3(myEuler.x, myEuler.y-(.pi/12.0), myEuler.z) }
                    else if(sender.tag == 2){ viewController.getCurrentShape()!.eulerAngles = SCNVector3(myEuler.x, myEuler.y, myEuler.z-(.pi/12.0)) }
                }
                self.lastSectionXSlider = 2
            }
            else if(scrollSection == 3 && Int(scrollSection) != self.lastSectionXSlider){
                if(self.lastSectionXSlider == 2){
                    if(sender.tag == 0){ viewController.getCurrentShape()!.eulerAngles = SCNVector3(myEuler.x+(.pi/12.0), myEuler.y, myEuler.z) }
                    else if(sender.tag == 1){ viewController.getCurrentShape()!.eulerAngles = SCNVector3(myEuler.x, myEuler.y+(.pi/12.0), myEuler.z) }
                    else if(sender.tag == 2){ viewController.getCurrentShape()!.eulerAngles = SCNVector3(myEuler.x, myEuler.y, myEuler.z+(.pi/12.0)) }
                }
                if(self.lastSectionXSlider == 4){
                    if(sender.tag == 0){ viewController.getCurrentShape()!.eulerAngles = SCNVector3(myEuler.x-(.pi/6.0), myEuler.y, myEuler.z) }
                    else if(sender.tag == 1){ viewController.getCurrentShape()!.eulerAngles = SCNVector3(myEuler.x, myEuler.y-(.pi/6.0), myEuler.z) }
                    else if(sender.tag == 2){ viewController.getCurrentShape()!.eulerAngles = SCNVector3(myEuler.x, myEuler.y, myEuler.z-(.pi/6.0)) }
                }
                self.lastSectionXSlider = 3
            }
            else if(scrollSection == 4 && Int(scrollSection) != self.lastSectionXSlider){
                if(self.lastSectionXSlider == 3){
                    if(sender.tag == 0){ viewController.getCurrentShape()!.eulerAngles = SCNVector3(myEuler.x+(.pi/6.0), myEuler.y, myEuler.z) }
                    else if(sender.tag == 1){ viewController.getCurrentShape()!.eulerAngles = SCNVector3(myEuler.x, myEuler.y+(.pi/6.0), myEuler.z) }
                    else if(sender.tag == 2){ viewController.getCurrentShape()!.eulerAngles = SCNVector3(myEuler.x, myEuler.y, myEuler.z+(.pi/6.0)) }
                }
                if(self.lastSectionXSlider == 5){
                    if(sender.tag == 0){ viewController.getCurrentShape()!.eulerAngles = SCNVector3(myEuler.x-(.pi/6.0), myEuler.y, myEuler.z) }
                    else if(sender.tag == 1){ viewController.getCurrentShape()!.eulerAngles = SCNVector3(myEuler.x, myEuler.y-(.pi/6.0), myEuler.z) }
                    else if(sender.tag == 2){ viewController.getCurrentShape()!.eulerAngles = SCNVector3(myEuler.x, myEuler.y, myEuler.z-(.pi/6.0)) }
                }
                self.lastSectionXSlider = 4
            }
            else if(scrollSection == 5 && Int(scrollSection) != self.lastSectionXSlider){
                if(self.lastSectionXSlider == 4){
                    if(sender.tag == 0){ viewController.getCurrentShape()!.eulerAngles = SCNVector3(myEuler.x+(.pi/6.0), myEuler.y, myEuler.z) }
                    else if(sender.tag == 1){ viewController.getCurrentShape()!.eulerAngles = SCNVector3(myEuler.x, myEuler.y+(.pi/6.0), myEuler.z) }
                    else if(sender.tag == 2){ viewController.getCurrentShape()!.eulerAngles = SCNVector3(myEuler.x, myEuler.y, myEuler.z+(.pi/6.0)) }
                }
                if(self.lastSectionXSlider == 6){
                    if(sender.tag == 0){ viewController.getCurrentShape()!.eulerAngles = SCNVector3(myEuler.x-(.pi/12.0), myEuler.y, myEuler.z) }
                    else if(sender.tag == 1){ viewController.getCurrentShape()!.eulerAngles = SCNVector3(myEuler.x, myEuler.y-(.pi/12.0), myEuler.z) }
                    else if(sender.tag == 2){ viewController.getCurrentShape()!.eulerAngles = SCNVector3(myEuler.x, myEuler.y, myEuler.z-(.pi/12.0)) }
                }
                self.lastSectionXSlider = 5
            }
            else if(scrollSection == 6 && Int(scrollSection) != self.lastSectionXSlider){
                if(self.lastSectionXSlider == 5){
                    if(sender.tag == 0){ viewController.getCurrentShape()!.eulerAngles = SCNVector3(myEuler.x+(.pi/12.0), myEuler.y, myEuler.z) }
                    else if(sender.tag == 1){ viewController.getCurrentShape()!.eulerAngles = SCNVector3(myEuler.x, myEuler.y+(.pi/12.0), myEuler.z) }
                    else if(sender.tag == 2){ viewController.getCurrentShape()!.eulerAngles = SCNVector3(myEuler.x, myEuler.y, myEuler.z+(.pi/12.0)) }
                }
                if(self.lastSectionXSlider == 7){
                    if(sender.tag == 0){ viewController.getCurrentShape()!.eulerAngles = SCNVector3(myEuler.x-(.pi/12.0), myEuler.y, myEuler.z) }
                    else if(sender.tag == 1){ viewController.getCurrentShape()!.eulerAngles = SCNVector3(myEuler.x, myEuler.y-(.pi/12.0), myEuler.z) }
                    else if(sender.tag == 2){ viewController.getCurrentShape()!.eulerAngles = SCNVector3(myEuler.x, myEuler.y, myEuler.z-(.pi/12.0)) }
                }
                self.lastSectionXSlider = 6
            }
            else if(scrollSection == 7 && Int(scrollSection) != self.lastSectionXSlider){
                if(self.lastSectionXSlider == 6){
                    if(sender.tag == 0){ viewController.getCurrentShape()!.eulerAngles = SCNVector3(myEuler.x+(.pi/12.0), myEuler.y, myEuler.z) }
                    else if(sender.tag == 1){ viewController.getCurrentShape()!.eulerAngles = SCNVector3(myEuler.x, myEuler.y+(.pi/12.0), myEuler.z) }
                    else if(sender.tag == 2){ viewController.getCurrentShape()!.eulerAngles = SCNVector3(myEuler.x, myEuler.y, myEuler.z+(.pi/12.0)) }
                }
                if(self.lastSectionXSlider == 8){
                    if(sender.tag == 0){ viewController.getCurrentShape()!.eulerAngles = SCNVector3(myEuler.x-(.pi/6.0), myEuler.y, myEuler.z) }
                    else if(sender.tag == 1){ viewController.getCurrentShape()!.eulerAngles = SCNVector3(myEuler.x, myEuler.y-(.pi/6.0), myEuler.z) }
                    else if(sender.tag == 2){ viewController.getCurrentShape()!.eulerAngles = SCNVector3(myEuler.x, myEuler.y, myEuler.z-(.pi/6.0)) }
                }
                self.lastSectionXSlider = 7
            }
            else if(scrollSection == 8 && Int(scrollSection) != self.lastSectionXSlider){
                if(sender.tag == 0){ viewController.getCurrentShape()!.eulerAngles = SCNVector3(myEuler.x+(.pi/6.0), myEuler.y, myEuler.z) }
                else if(sender.tag == 1){ viewController.getCurrentShape()!.eulerAngles = SCNVector3(myEuler.x, myEuler.y+(.pi/6.0), myEuler.z) }
                else if(sender.tag == 2){ viewController.getCurrentShape()!.eulerAngles = SCNVector3(myEuler.x, myEuler.y, myEuler.z+(.pi/6.0)) }
                self.lastSectionXSlider = 8
            }
                
                //Negative Rotations (Bottom half of slider)
            else if(scrollSection == -1 && Int(scrollSection) != self.lastSectionXSlider){
                if(self.lastSectionXSlider == 0){
                    if(sender.tag == 0){ viewController.getCurrentShape()!.eulerAngles = SCNVector3(myEuler.x-(.pi/6.0), myEuler.y, myEuler.z) }
                    else if(sender.tag == 1){ viewController.getCurrentShape()!.eulerAngles = SCNVector3(myEuler.x, myEuler.y-(.pi/6.0), myEuler.z) }
                    else if(sender.tag == 2){ viewController.getCurrentShape()!.eulerAngles = SCNVector3(myEuler.x, myEuler.y, myEuler.z-(.pi/6.0)) }
                }
                if(self.lastSectionXSlider == -2){
                    if(sender.tag == 0){ viewController.getCurrentShape()!.eulerAngles = SCNVector3(myEuler.x+(.pi/12.0), myEuler.y, myEuler.z) }
                    else if(sender.tag == 1){ viewController.getCurrentShape()!.eulerAngles = SCNVector3(myEuler.x, myEuler.y+(.pi/12.0), myEuler.z) }
                    else if(sender.tag == 2){ viewController.getCurrentShape()!.eulerAngles = SCNVector3(myEuler.x, myEuler.y, myEuler.z+(.pi/12.0)) }
                }
                self.lastSectionXSlider = -1
            }
            else if(scrollSection == -2 && Int(scrollSection) != self.lastSectionXSlider){
                if(self.lastSectionXSlider == -1){
                    if(sender.tag == 0){ viewController.getCurrentShape()!.eulerAngles = SCNVector3(myEuler.x-(.pi/12.0), myEuler.y, myEuler.z) }
                    else if(sender.tag == 1){ viewController.getCurrentShape()!.eulerAngles = SCNVector3(myEuler.x, myEuler.y-(.pi/12.0), myEuler.z) }
                    else if(sender.tag == 2){ viewController.getCurrentShape()!.eulerAngles = SCNVector3(myEuler.x, myEuler.y, myEuler.z-(.pi/12.0)) }
                }
                if(self.lastSectionXSlider == -3){
                    if(sender.tag == 0){ viewController.getCurrentShape()!.eulerAngles = SCNVector3(myEuler.x+(.pi/12.0), myEuler.y, myEuler.z) }
                    else if(sender.tag == 1){ viewController.getCurrentShape()!.eulerAngles = SCNVector3(myEuler.x, myEuler.y+(.pi/12.0), myEuler.z) }
                    else if(sender.tag == 2){ viewController.getCurrentShape()!.eulerAngles = SCNVector3(myEuler.x, myEuler.y, myEuler.z+(.pi/12.0)) }
                }
                self.lastSectionXSlider = -2
            }
            else if(scrollSection == -3 && Int(scrollSection) != self.lastSectionXSlider){
                if(self.lastSectionXSlider == -2) {
                    if(sender.tag == 0){ viewController.getCurrentShape()!.eulerAngles = SCNVector3(myEuler.x-(.pi/12.0), myEuler.y, myEuler.z) }
                    else if(sender.tag == 1){ viewController.getCurrentShape()!.eulerAngles = SCNVector3(myEuler.x, myEuler.y-(.pi/12.0), myEuler.z) }
                    else if(sender.tag == 2){ viewController.getCurrentShape()!.eulerAngles = SCNVector3(myEuler.x, myEuler.y, myEuler.z-(.pi/12.0)) }
                }
                if(self.lastSectionXSlider == -4) {
                    if(sender.tag == 0){ viewController.getCurrentShape()!.eulerAngles = SCNVector3(myEuler.x+(.pi/6.0), myEuler.y, myEuler.z) }
                    else if(sender.tag == 1){ viewController.getCurrentShape()!.eulerAngles = SCNVector3(myEuler.x, myEuler.y+(.pi/6.0), myEuler.z) }
                    else if(sender.tag == 2){ viewController.getCurrentShape()!.eulerAngles = SCNVector3(myEuler.x, myEuler.y, myEuler.z+(.pi/6.0)) }
                }
                self.lastSectionXSlider = -3
            }
            else if(scrollSection == -4 && Int(scrollSection) != self.lastSectionXSlider){
                if(self.lastSectionXSlider == -3) {
                    if(sender.tag == 0){ viewController.getCurrentShape()!.eulerAngles = SCNVector3(myEuler.x-(.pi/6.0), myEuler.y, myEuler.z) }
                    else if(sender.tag == 1){ viewController.getCurrentShape()!.eulerAngles = SCNVector3(myEuler.x, myEuler.y-(.pi/6.0), myEuler.z) }
                    else if(sender.tag == 2){ viewController.getCurrentShape()!.eulerAngles = SCNVector3(myEuler.x, myEuler.y, myEuler.z-(.pi/6.0)) }
                }
                if(self.lastSectionXSlider == -5) {
                    if(sender.tag == 0){ viewController.getCurrentShape()!.eulerAngles = SCNVector3(myEuler.x+(.pi/6.0), myEuler.y, myEuler.z) }
                    else if(sender.tag == 1){ viewController.getCurrentShape()!.eulerAngles = SCNVector3(myEuler.x, myEuler.y+(.pi/6.0), myEuler.z) }
                    else if(sender.tag == 2){ viewController.getCurrentShape()!.eulerAngles = SCNVector3(myEuler.x, myEuler.y, myEuler.z+(.pi/6.0)) }
                }
                self.lastSectionXSlider = -4
            }
            else if(scrollSection == -5 && Int(scrollSection) != self.lastSectionXSlider){
                if(self.lastSectionXSlider == -4) {
                    if(sender.tag == 0){ viewController.getCurrentShape()!.eulerAngles = SCNVector3(myEuler.x-(.pi/6.0), myEuler.y, myEuler.z) }
                    else if(sender.tag == 1){ viewController.getCurrentShape()!.eulerAngles = SCNVector3(myEuler.x, myEuler.y-(.pi/6.0), myEuler.z) }
                    else if(sender.tag == 2){ viewController.getCurrentShape()!.eulerAngles = SCNVector3(myEuler.x, myEuler.y, myEuler.z-(.pi/6.0)) }
                }
                if(self.lastSectionXSlider == -6) {
                    if(sender.tag == 0){ viewController.getCurrentShape()!.eulerAngles = SCNVector3(myEuler.x+(.pi/12.0), myEuler.y, myEuler.z) }
                    else if(sender.tag == 1){ viewController.getCurrentShape()!.eulerAngles = SCNVector3(myEuler.x, myEuler.y+(.pi/12.0), myEuler.z) }
                    else if(sender.tag == 2){ viewController.getCurrentShape()!.eulerAngles = SCNVector3(myEuler.x, myEuler.y, myEuler.z+(.pi/12.0)) }
                }
                self.lastSectionXSlider = -5
            }
            else if(scrollSection == -6 && Int(scrollSection) != self.lastSectionXSlider){
                if(self.lastSectionXSlider == -5) {
                    if(sender.tag == 0){ viewController.getCurrentShape()!.eulerAngles = SCNVector3(myEuler.x-(.pi/12.0), myEuler.y, myEuler.z) }
                    else if(sender.tag == 1){ viewController.getCurrentShape()!.eulerAngles = SCNVector3(myEuler.x, myEuler.y-(.pi/12.0), myEuler.z) }
                    else if(sender.tag == 2){ viewController.getCurrentShape()!.eulerAngles = SCNVector3(myEuler.x, myEuler.y, myEuler.z-(.pi/12.0)) }
                }
                if(self.lastSectionXSlider == -7) {
                    if(sender.tag == 0){ viewController.getCurrentShape()!.eulerAngles = SCNVector3(myEuler.x+(.pi/12.0), myEuler.y, myEuler.z) }
                    else if(sender.tag == 1){ viewController.getCurrentShape()!.eulerAngles = SCNVector3(myEuler.x, myEuler.y+(.pi/12.0), myEuler.z) }
                    else if(sender.tag == 2){ viewController.getCurrentShape()!.eulerAngles = SCNVector3(myEuler.x, myEuler.y, myEuler.z+(.pi/12.0)) }
                }
                self.lastSectionXSlider = -6
            }
            else if(scrollSection == -7 && Int(scrollSection) != self.lastSectionXSlider){
                if(self.lastSectionXSlider == -6) {
                    if(sender.tag == 0){ viewController.getCurrentShape()!.eulerAngles = SCNVector3(myEuler.x-(.pi/12.0), myEuler.y, myEuler.z) }
                    else if(sender.tag == 1){ viewController.getCurrentShape()!.eulerAngles = SCNVector3(myEuler.x, myEuler.y-(.pi/12.0), myEuler.z) }
                    else if(sender.tag == 2){ viewController.getCurrentShape()!.eulerAngles = SCNVector3(myEuler.x, myEuler.y, myEuler.z-(.pi/12.0)) }
                }
                if(self.lastSectionXSlider == -8) {
                    if(sender.tag == 0){ viewController.getCurrentShape()!.eulerAngles = SCNVector3(myEuler.x+(.pi/6.0), myEuler.y, myEuler.z) }
                    else if(sender.tag == 1){ viewController.getCurrentShape()!.eulerAngles = SCNVector3(myEuler.x, myEuler.y+(.pi/6.0), myEuler.z) }
                    else if(sender.tag == 2){ viewController.getCurrentShape()!.eulerAngles = SCNVector3(myEuler.x, myEuler.y, myEuler.z+(.pi/6.0)) }
                }
                self.lastSectionXSlider = -7
            }
            else if(scrollSection == -8 && Int(scrollSection) != self.lastSectionXSlider){ //Bottom of Scroll Bar
                if(sender.tag == 0){ viewController.getCurrentShape()!.eulerAngles = SCNVector3(myEuler.x-(.pi/6.0), myEuler.y, myEuler.z) }
                else if(sender.tag == 1){ viewController.getCurrentShape()!.eulerAngles = SCNVector3(myEuler.x, myEuler.y-(.pi/6.0), myEuler.z) }
                else if(sender.tag == 2){ viewController.getCurrentShape()!.eulerAngles = SCNVector3(myEuler.x, myEuler.y, myEuler.z-(.pi/6.0)) }
                self.lastSectionXSlider = -8
            }
                //Default
            else{
                //We are in the same section
                //No Need for rotation!
            }
        }

    }
    
    ///////// MATH FUNCTIONS FOR QUATERNION/EULER VECTOR TRANSFORMATIONS /////////
    //(Left these here incase you want to play with Quaternions)
    
    //Converting orientation to Euler
    //var myQuat = viewController.getCurrentShape()!.orientation
    //let myEuler = quaternionToEuler(q: myQuat)
    
    func quaternionToEuler(q: SCNQuaternion) -> SCNVector3 {
        let roll = atan2(2*q.y*q.w - 2*q.x*q.z, 1 - 2*q.y*q.y - 2*q.z*q.z)
        let pitch = atan2(2*q.x*q.w - 2*q.y*q.z, 1 - 2*q.x*q.x - 2*q.z*q.z)
        let yaw = asin(2*q.x*q.y + 2*q.z*q.w)
        return SCNVector3(roll, pitch, yaw)
    }
    //Params: Roll, Pitch, Yaw
    func eulerToQuaternion(r: Double, p: Double, y: Double) -> SCNQuaternion {
        let qx = sin(r/2.0) * cos(p/2.0) * cos(y/2) - cos(r/2) * sin(p/2) * sin(y/2)
        let qy = cos(r/2.0) * sin(p/2) * cos(y/2) + sin(r/2) * cos(p/2) * sin(y/2)
        let qz = cos(r/2.0) * cos(p/2) * sin(y/2) - sin(r/2) * sin(p/2) * cos(y/2)
        let qw = cos(r/2.0) * cos(p/2) * cos(y/2) + sin(r/2) * sin(p/2) * sin(y/2)
        return SCNQuaternion(qx, qy, qz, qw)
    }
    
}
