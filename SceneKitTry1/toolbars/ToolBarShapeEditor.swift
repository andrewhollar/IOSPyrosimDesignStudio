//
//  ToolBarShapeEditor.swift
//  SceneKitTry1
//
//  Created by William Sutton on 3/7/19.
//  Copyright © 2019 ahollar. All rights reserved.
//

import UIKit
import SceneKit

class ToolBarShapeEditor {
    
    var viewController: StudioViewController
    var toolBarRobotParts: ToolBarRobotParts
    
    init(controller: StudioViewController){
        self.viewController = controller
        self.toolBarRobotParts = controller.getToolBarRobotParts()
        draw()
    }
    
    func draw(){
        let toolbar = CGRect(x:0,y:700,width:800,height:100)
        let toolView = UIView(frame:toolbar)
        toolView.backgroundColor = UIColor.init(red:0.7,green:0.7,blue:0.7, alpha: 1)
        
        //addX button
        let addXButton = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        addXButton.backgroundColor = UIColor.init(red:0.3,green:0.4,blue:0.7, alpha: 1)
        addXButton.setTitle("addX", for: .normal)
        addXButton.addTarget(self, action: #selector(handleButtonPress), for: .primaryActionTriggered)
        toolView.addSubview(addXButton)
        
        //subX button
        let subXButton = UIButton(frame: CGRect(x: 0, y: 50, width: 100, height: 50))
        subXButton.backgroundColor = UIColor.init(red:0.3,green:0.4,blue:0.7, alpha: 1)
        subXButton.setTitle("subX", for: .normal)
        subXButton.addTarget(self, action: #selector(handleButtonPress), for: .primaryActionTriggered)
        toolView.addSubview(subXButton)
        viewController.view.addSubview(toolView)
        
        //addY button
        let addYButton = UIButton(frame: CGRect(x: 100, y: 0, width: 100, height: 50))
        addYButton.backgroundColor = UIColor.init(red:0.3,green:0.4,blue:0.7, alpha: 1)
        addYButton.setTitle("addY", for: .normal)
        addYButton.addTarget(self, action: #selector(handleButtonPress), for: .primaryActionTriggered)
        toolView.addSubview(addYButton)
        
        //subY button
        let subYButton = UIButton(frame: CGRect(x: 100, y: 50, width: 100, height: 50))
        subYButton.backgroundColor = UIColor.init(red:0.3,green:0.4,blue:0.7, alpha: 1)
        subYButton.setTitle("subY", for: .normal)
        subYButton.addTarget(self, action: #selector(handleButtonPress), for: .primaryActionTriggered)
        toolView.addSubview(subYButton)
        viewController.view.addSubview(toolView)
        
        //addZ button
        let addZButton = UIButton(frame: CGRect(x: 200, y: 0, width: 100, height: 50))
        addZButton.backgroundColor = UIColor.init(red:0.3,green:0.4,blue:0.7, alpha: 1)
        addZButton.setTitle("addZ", for: .normal)
        addZButton.addTarget(self, action: #selector(handleButtonPress), for: .primaryActionTriggered)
        toolView.addSubview(addZButton)
        
        //subZ button
        let subZButton = UIButton(frame: CGRect(x: 200, y: 50, width: 100, height: 50))
        subZButton.backgroundColor = UIColor.init(red:0.3,green:0.4,blue:0.7, alpha: 1)
        subZButton.setTitle("subZ", for: .normal)
        subZButton.addTarget(self, action: #selector(handleButtonPress), for: .primaryActionTriggered)
        //subZButton.setImage(UIImage(named: ""), for: UIControl.State.normal)
        toolView.addSubview(subZButton)
        viewController.view.addSubview(toolView)
        
        
    }
    
    @objc
    func handleButtonPress(sender: UIButton!) {
        switch(sender.currentTitle) {
        case "addX":
            print("adding x")
            if(viewController.getCurrentShape() != nil){
                viewController.getCurrentShape()!.position.x += 1
            }
        case "subX":
            print("subtracting x")
            if(viewController.getCurrentShape() != nil){
                viewController.getCurrentShape()!.position.x -= 1
            }
        case "addY":
            print("adding y")
            if(viewController.getCurrentShape() != nil){
                viewController.getCurrentShape()!.position.y += 1
            }
        case "subY":
            print("subtracting y")
            if(viewController.getCurrentShape() != nil){
                viewController.getCurrentShape()!.position.y -= 1
            }
        case "addZ":
            print("adding z")
            if(viewController.getCurrentShape() != nil){
                viewController.getCurrentShape()!.position.z += 1
            }
        case "subZ":
            print("subtracting z")
            //if z < ground height, do not lower futher
            if(viewController.getCurrentShape() != nil){
                viewController.getCurrentShape()!.position.z -= 1
            }
            
        default:
            print("Button press could not be handled, unrecognized name.")
        }
    }
    
    
    
    
    
}
