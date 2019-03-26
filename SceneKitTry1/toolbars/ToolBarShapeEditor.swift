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
        addXButton.setTitle("plusX", for: .normal)
        addXButton.addTarget(self, action: #selector(handleButtonPress), for: .primaryActionTriggered)
        addXButton.setImage(UIImage(named: "plusX"), for: UIControl.State.normal)
        toolView.addSubview(addXButton)
        
        //subX button
        let subXButton = UIButton(frame: CGRect(x: 0, y: 50, width: 100, height: 50))
        subXButton.backgroundColor = UIColor.init(red:0.3,green:0.4,blue:0.7, alpha: 1)
        subXButton.setTitle("minusX", for: .normal)
        subXButton.addTarget(self, action: #selector(handleButtonPress), for: .primaryActionTriggered)
        subXButton.setImage(UIImage(named: "minusX"), for: UIControl.State.normal)
        toolView.addSubview(subXButton)
        viewController.view.addSubview(toolView)
        
        //addY button
        let addYButton = UIButton(frame: CGRect(x: 100, y: 0, width: 100, height: 50))
        addYButton.backgroundColor = UIColor.init(red:0.3,green:0.4,blue:0.7, alpha: 1)
        addYButton.setTitle("plusY", for: .normal)
        addYButton.addTarget(self, action: #selector(handleButtonPress), for: .primaryActionTriggered)
        addYButton.setImage(UIImage(named: "plusY"), for: UIControl.State.normal)
        toolView.addSubview(addYButton)
        
        //subY button
        let subYButton = UIButton(frame: CGRect(x: 100, y: 50, width: 100, height: 50))
        subYButton.backgroundColor = UIColor.init(red:0.3,green:0.4,blue:0.7, alpha: 1)
        subYButton.setTitle("minusY", for: .normal)
        subYButton.addTarget(self, action: #selector(handleButtonPress), for: .primaryActionTriggered)
        subYButton.setImage(UIImage(named: "minusY"), for: UIControl.State.normal)
        toolView.addSubview(subYButton)
        viewController.view.addSubview(toolView)
        
        //addZ button
        let addZButton = UIButton(frame: CGRect(x: 200, y: 0, width: 100, height: 50))
        addZButton.backgroundColor = UIColor.init(red:0.3,green:0.4,blue:0.7, alpha: 1)
        addZButton.setTitle("plusZ", for: .normal)
        addZButton.addTarget(self, action: #selector(handleButtonPress), for: .primaryActionTriggered)
        addZButton.setImage(UIImage(named: "plusZ"), for: UIControl.State.normal)
        toolView.addSubview(addZButton)
        
        //subZ button
        let subZButton = UIButton(frame: CGRect(x: 200, y: 50, width: 100, height: 50))
        subZButton.backgroundColor = UIColor.init(red:0.3,green:0.4,blue:0.7, alpha: 1)
        subZButton.setTitle("minusZ", for: .normal)
        subZButton.addTarget(self, action: #selector(handleButtonPress), for: .primaryActionTriggered)
        subZButton.setImage(UIImage(named: "minusZ"), for: UIControl.State.normal)
        toolView.addSubview(subZButton)
        viewController.view.addSubview(toolView)
        
        
    }
    
    @objc
    func handleButtonPress(sender: UIButton!) {
        switch(sender.currentTitle) {
        case "plusX":
            print("adding x")
            if(viewController.getCurrentShape() != nil){
                viewController.getCurrentShape()!.position.x += 1
            }
        case "minusX":
            print("subtracting x")
            if(viewController.getCurrentShape() != nil){
                viewController.getCurrentShape()!.position.x -= 1
            }
        case "plusY":
            print("adding y")
            if(viewController.getCurrentShape() != nil){
                viewController.getCurrentShape()!.position.y += 1
            }
        case "minusY":
            print("subtracting y")
            if(viewController.getCurrentShape() != nil){
                viewController.getCurrentShape()!.position.y -= 1
            }
        case "plusZ":
            print("adding z")
            if(viewController.getCurrentShape() != nil){
                viewController.getCurrentShape()!.position.z += 1
            }
        case "minusZ":
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
