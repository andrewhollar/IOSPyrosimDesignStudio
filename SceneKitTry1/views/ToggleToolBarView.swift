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
        
        let maxY = Int(viewController.view.bounds.maxY)
        
        
        let toolbar = CGRect(x:0,y: maxY - buttonSize,width:800,height:buttonSize)
        super.init(frame: toolbar)
        viewController.view.addSubview(self)
        //self.translatesAutoresizingMaskIntoConstraints = false
        addMargins()

        //backgroundColor = UIColor.darkGray
        /*
        controller.view.addSubview(shapeScroll)
        shapeScroll.leftAnchor.constraint(equalTo: controller.view.leftAnchor, constant: 0).isActive = true
        shapeScroll.topAnchor.constraint(equalTo: controller.view.topAnchor, constant: 0).isActive = true
        shapeScroll.widthAnchor.constraint(equalTo: controller.view.widthAnchor, multiplier: 0.1).isActive = true
        shapeScroll.heightAnchor.constraint(equalTo: controller.view.heightAnchor, multiplier: 0.05).isActive = true
        */
        
        shapeButton.addTarget(self, action: #selector(toggleShape), for: .primaryActionTriggered)
        shapeButton.setImage(UIImage(named: "ShapesButton"), for: UIControl.State.normal)
        addSubview(shapeButton)

        //Added for layout
        shapeButton.translatesAutoresizingMaskIntoConstraints = false
//        controller.view.addSubview(shapeButton)
        shapeButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
//        shapeButton.centerXAnchor.constraint(equalTo: controller.view.centerXAnchor, constant: -150).isActive = true
        shapeButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant:  100).isActive = true
        shapeButton.heightAnchor.constraint(equalToConstant: CGFloat(buttonSize)).isActive = true
        shapeButton.widthAnchor.constraint(equalToConstant: CGFloat(buttonSize)).isActive = true
        
        buttons.append(shapeButton)
        
        moveButton.addTarget(self, action: #selector(toggleShape) /*#selector(toggleMovement)*/, for: .primaryActionTriggered)
        moveButton.setImage(UIImage(named: "moveButton"), for: UIControl.State.normal)
        addSubview(moveButton)
        
        moveButton.translatesAutoresizingMaskIntoConstraints = false
//        controller.view.addSubview(moveButton)
        moveButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
//        moveButton.centerXAnchor.constraint(equalTo: controller.view.centerXAnchor, constant: -75).isActive = true
        moveButton.leftAnchor.constraint(equalTo: shapeButton.rightAnchor, constant: 15).isActive = true
        moveButton.heightAnchor.constraint(equalToConstant: CGFloat(buttonSize)).isActive = true
        moveButton.widthAnchor.constraint(equalToConstant: CGFloat(buttonSize)).isActive = true
        
        buttons.append(moveButton)
        
        neuralNetworkButton.addTarget(self, action: #selector(toggleNeuralNetwork), for: .primaryActionTriggered)
        neuralNetworkButton.setImage(UIImage(named: "neuralNetworkButton"), for: UIControl.State.normal)
        addSubview(neuralNetworkButton)

        neuralNetworkButton.translatesAutoresizingMaskIntoConstraints = false
//        controller.view.addSubview(neuralNetworkButton)
        neuralNetworkButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
//        neuralNetworkButton.centerXAnchor.constraint(equalTo: controller.view.centerXAnchor, constant: 75).isActive = true
        neuralNetworkButton.leftAnchor.constraint(equalTo: moveButton.rightAnchor, constant: 15).isActive = true
        neuralNetworkButton.heightAnchor.constraint(equalToConstant: CGFloat(buttonSize)).isActive = true
        neuralNetworkButton.widthAnchor.constraint(equalToConstant: CGFloat(buttonSize)).isActive = true
        
        buttons.append(neuralNetworkButton)
        
        rotationButton.addTarget(self, action: #selector(toggleRotation), for: .primaryActionTriggered)
        rotationButton.setImage(UIImage(named: "rotationButton"), for: UIControl.State.normal)
        addSubview(rotationButton)

        rotationButton.translatesAutoresizingMaskIntoConstraints = false
//        controller.view.addSubview(rotationButton)
        rotationButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
//        rotationButton.centerXAnchor.constraint(equalTo: controller.view.centerXAnchor, constant: 0).isActive = true
        rotationButton.leftAnchor.constraint(equalTo: neuralNetworkButton.rightAnchor, constant: 15).isActive = true
        rotationButton.heightAnchor.constraint(equalToConstant: CGFloat(buttonSize)).isActive = true
        rotationButton.widthAnchor.constraint(equalToConstant: CGFloat(buttonSize)).isActive = true
        
        buttons.append(rotationButton)

        sensorsButton.addTarget(self, action: #selector(toggleSensors), for: .primaryActionTriggered)
        sensorsButton.setImage(UIImage(named: "sensorsButton"), for: UIControl.State.normal)
        addSubview(sensorsButton)

        sensorsButton.translatesAutoresizingMaskIntoConstraints = false
//        controller.view.addSubview(sensorsButton)
        sensorsButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
//        sensorsButton.centerXAnchor.constraint(equalTo: controller.view.centerXAnchor, constant:150).isActive = true
        sensorsButton.leftAnchor.constraint(equalTo: rotationButton.rightAnchor, constant: 15).isActive = true
        sensorsButton.heightAnchor.constraint(equalToConstant: CGFloat(buttonSize)).isActive = true
        sensorsButton.widthAnchor.constraint(equalToConstant: CGFloat(buttonSize)).isActive = true
        
        buttons.append(sensorsButton)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addMargins()  {
        //self.BORDER_WIDTH = 10
        self.backgroundColor = UIColor.yellow

        self.bottomAnchor.constraint(equalTo: viewController.view.bottomAnchor, constant: 0).isActive = true
        self.centerXAnchor.constraint(equalTo: viewController.view.centerXAnchor, constant: -150).isActive = true
        self.heightAnchor.constraint(equalToConstant: CGFloat(buttonSize)).isActive = true

        //        //rotationButton.leftAnchor.constraint(equalTo: neuralNetworkButton.rightAnchor, constant: 15).isActive = true
        //        rotationButton.heightAnchor.constraint(equalToConstant: CGFloat(buttonSize)).isActive = true
        //        rotationButton.widthAnchor.constraint(equalToConstant: CGFloat(buttonSize)).isActive = true
    }
    
    @objc
    func toggleShape(sender: UIButton) {
        print("toggle Shape")
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
