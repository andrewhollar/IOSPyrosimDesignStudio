//
//  MovementToolBar.swift
//  SceneKitTry1
//
//  Created by William Sutton on 3/29/19.
//  Copyright © 2019 ahollar. All rights reserved.
//
import UIKit
import SceneKit

class MovementToolBar : UIView{
    
    var viewController: StudioViewController
    
    var buttonSize = 75
    
    init(controller: StudioViewController){
        self.viewController = controller
        let toolbar = CGRect(x:0,y:625,width:800,height:buttonSize)
        super.init(frame: toolbar)
        backgroundColor = UIColor.init(red:0.7,green:0.7,blue:0.7, alpha: 1)
        populateWithButtons()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func populateWithButtons(){
        
        let addXButton = UIButton(frame: CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize)) //addX button
        addXButton.addTarget(self, action: #selector(plusX), for: .primaryActionTriggered)
        addXButton.setImage(UIImage(named: "plusX"), for: UIControl.State.normal)
        addSubview(addXButton)
        
        let subXButton = UIButton(frame: CGRect(x: 0, y: buttonSize, width: buttonSize, height: buttonSize)) //subX button
        subXButton.addTarget(self, action: #selector(minusX), for: .primaryActionTriggered)
        subXButton.setImage(UIImage(named: "minusX"), for: UIControl.State.normal)
        addSubview(subXButton)
        
        let addYButton = UIButton(frame: CGRect(x: buttonSize, y: 0, width: buttonSize, height: buttonSize)) //addY button
        addYButton.addTarget(self, action: #selector(plusY), for: .primaryActionTriggered)
        addYButton.setImage(UIImage(named: "plusY"), for: UIControl.State.normal)
        addSubview(addYButton)
        
        let subYButton = UIButton(frame: CGRect(x: buttonSize, y: buttonSize, width: buttonSize, height: buttonSize)) //subY button
        subYButton.addTarget(self, action: #selector(minusY), for: .primaryActionTriggered)
        subYButton.setImage(UIImage(named: "minusY"), for: UIControl.State.normal)
        addSubview(subYButton)
        
        let addZButton = UIButton(frame: CGRect(x: 2*buttonSize, y: 0, width: buttonSize, height: buttonSize)) //addZ button
        addZButton.addTarget(self, action: #selector(plusZ), for: .primaryActionTriggered)
        addZButton.setImage(UIImage(named: "plusZ"), for: UIControl.State.normal)
        addSubview(addZButton)
        
        let subZButton = UIButton(frame: CGRect(x: 2*buttonSize, y: buttonSize, width: buttonSize, height: buttonSize)) //subZ button
        subZButton.addTarget(self, action: #selector(minusZ), for: .primaryActionTriggered)
        subZButton.setImage(UIImage(named: "minusZ"), for: UIControl.State.normal)
        addSubview(subZButton)
        
    }
    
    @objc
    func plusX(){
        if(viewController.getCurrentShape() != nil){
            viewController.getCurrentShape()!.position.x += 1
        }
    }
    
    @objc
    func minusX(){
        if(viewController.getCurrentShape() != nil){
            viewController.getCurrentShape()!.position.x -= 1
        }
    }
    
    @objc
    func plusY(){
        if(viewController.getCurrentShape() != nil){
        viewController.getCurrentShape()!.position.y += 1
        }
    }
    
    @objc
    func minusY(){
        if(viewController.getCurrentShape() != nil){
            viewController.getCurrentShape()!.position.y -= 1
        }
    }
    
    @objc
    func plusZ(){
        if(viewController.getCurrentShape() != nil){
            viewController.getCurrentShape()!.position.z += 1
        }
    }
    
    @objc
    func minusZ(){
        if(viewController.getCurrentShape() != nil){
            viewController.getCurrentShape()!.position.z -= 1
        }
    }
    
    
}
