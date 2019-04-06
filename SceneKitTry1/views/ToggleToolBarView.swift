//
//  ToggleToolBarView.swift
//  SceneKitTry1
//
//  Created by William Sutton on 3/29/19.
//  Copyright © 2019 ahollar. All rights reserved.
//

import Foundation
import UIKit
import SceneKit

class ToggleToolBarView: UIView{
    
    var BORDER_WIDTH = 5
    var viewController: StudioViewController
    var toolBarManager: ToolBarManager
    var shapeButton: UIButton
    var moveButton: UIButton
    var rotationButton: UIButton
    var neuralNetworkButton: UIButton
    var sensorsButton: UIButton
    var buttons = [UIButton]()
    
    var buttonSize = 75

    
    init(controller: StudioViewController){
        self.viewController = controller
        self.toolBarManager = controller.getToolBarManager()
        self.shapeButton = UIButton(frame: CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize)) //sphere button
        self.moveButton = UIButton(frame: CGRect(x: buttonSize, y: 0, width: buttonSize, height: buttonSize)) //rectangle button
        self.rotationButton = UIButton(frame: CGRect(x: 2*buttonSize, y:0, width: buttonSize, height: buttonSize))
        self.neuralNetworkButton = UIButton(frame: CGRect(x: 3*buttonSize, y: 0, width: buttonSize, height: buttonSize)) //neural Network
        self.sensorsButton = UIButton(frame: CGRect(x: 4*buttonSize, y: 0, width: buttonSize, height: buttonSize)) //sensors
        
        let toolbar = CGRect(x:0,y:800,width:800,height:buttonSize)
        super.init(frame: toolbar)
        backgroundColor = UIColor.darkGray
        
        shapeButton.addTarget(self, action: #selector(toggleShape), for: .primaryActionTriggered)
        shapeButton.setImage(UIImage(named: "ShapesButton"), for: UIControl.State.normal)
        addSubview(shapeButton)
        buttons.append(shapeButton)
        
        moveButton.addTarget(self, action: #selector(toggleMovement), for: .primaryActionTriggered)
        moveButton.setImage(UIImage(named: "moveButton"), for: UIControl.State.normal)
        addSubview(moveButton)
        buttons.append(moveButton)
        
        neuralNetworkButton.addTarget(self, action: #selector(toggleNeuralNetwork), for: .primaryActionTriggered)
        neuralNetworkButton.setImage(UIImage(named: "neuralNetworkButton"), for: UIControl.State.normal)
        addSubview(neuralNetworkButton)
        buttons.append(neuralNetworkButton)
        
        rotationButton.addTarget(self, action: #selector(toggleRotation), for: .primaryActionTriggered)
        rotationButton.setImage(UIImage(named: "rotationButton"), for: UIControl.State.normal)
        addSubview(rotationButton)
        buttons.append(rotationButton)

        sensorsButton.addTarget(self, action: #selector(toggleSensors), for: .primaryActionTriggered)
        sensorsButton.setImage(UIImage(named: "sensorsButton"), for: UIControl.State.normal)
        addSubview(sensorsButton)
        buttons.append(sensorsButton)
      
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    func toggleShape(sender: UIButton) {
        toggleBorder(pressedButton: sender)
        toolBarManager.setCurrent(name: "shapeSelector")
    }
    
    @objc
    func toggleMovement(sender: UIButton) {
        toggleBorder(pressedButton: sender)
        toolBarManager.setCurrent(name: "movement")
    }
    
    @objc
    func toggleRotation(sender: UIButton) {
        toggleBorder(pressedButton: sender)  
        toolBarManager.setCurrent(name: "rotation")
    }
    
    @objc
    func toggleJoint(sender: UIButton) {
        toggleBorder(pressedButton: sender)
        toolBarManager.setCurrent(name: "joint")
    }
    
    @objc
    func toggleNeuralNetwork(sender: UIButton) {
        toggleBorder(pressedButton: sender)
        toolBarManager.setCurrent(name: "neuralNetwork")
    }

    @objc
    func toggleSensors(sender: UIButton) {
        toggleBorder(pressedButton: sender)
        toolBarManager.setCurrent(name: "sensors")
    }
    
    func toggleBorder(pressedButton: UIButton){
        //reset all other buttons
        for button in buttons{
            if(button != pressedButton){
                button.layer.borderWidth = 0
                button.layer.borderColor = UIColor.init(red:0,green:0,blue:0,alpha:0).cgColor
            }
        }
        //toggle pressed button
        if(Int(pressedButton.layer.borderWidth) == BORDER_WIDTH){
            pressedButton.layer.borderWidth = 0
            pressedButton.layer.borderColor = UIColor.init(red:0,green:0,blue:0,alpha:0).cgColor
        }else{
            pressedButton.layer.borderWidth = CGFloat(BORDER_WIDTH)
            pressedButton.layer.borderColor = UIColor.init(red:1,green:1,blue:1,alpha:1).cgColor
        }
    }
}
