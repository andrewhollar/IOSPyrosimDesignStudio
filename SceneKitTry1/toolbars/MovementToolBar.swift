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
    
    init(controller: StudioViewController){
        self.viewController = controller
        let toolbar = CGRect(x:0,y:700,width:800,height:100)
        super.init(frame: toolbar)
        backgroundColor = UIColor.init(red:0.7,green:0.7,blue:0.7, alpha: 1)
        populateWithButtons()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func populateWithButtons(){
        
        let addXButton = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 50)) //addX button
        addXButton.addTarget(self, action: #selector(plusX), for: .primaryActionTriggered)
        addXButton.setImage(UIImage(named: "plusX"), for: UIControl.State.normal)
        addSubview(addXButton)
        
        let subXButton = UIButton(frame: CGRect(x: 0, y: 50, width: 100, height: 50)) //subX button
        subXButton.addTarget(self, action: #selector(minusX), for: .primaryActionTriggered)
        subXButton.setImage(UIImage(named: "minusX"), for: UIControl.State.normal)
        addSubview(subXButton)
        
        let addYButton = UIButton(frame: CGRect(x: 100, y: 0, width: 100, height: 50)) //addY button
        addYButton.addTarget(self, action: #selector(plusY), for: .primaryActionTriggered)
        addYButton.setImage(UIImage(named: "plusY"), for: UIControl.State.normal)
        addSubview(addYButton)
        
        let subYButton = UIButton(frame: CGRect(x: 100, y: 50, width: 100, height: 50)) //subY button
        subYButton.addTarget(self, action: #selector(minusY), for: .primaryActionTriggered)
        subYButton.setImage(UIImage(named: "minusY"), for: UIControl.State.normal)
        addSubview(subYButton)
        
        let addZButton = UIButton(frame: CGRect(x: 200, y: 0, width: 100, height: 50)) //addZ button
        addZButton.addTarget(self, action: #selector(plusZ), for: .primaryActionTriggered)
        addZButton.setImage(UIImage(named: "plusZ"), for: UIControl.State.normal)
        addSubview(addZButton)
        
        let subZButton = UIButton(frame: CGRect(x: 200, y: 50, width: 100, height: 50)) //subZ button
        subZButton.addTarget(self, action: #selector(minusZ), for: .primaryActionTriggered)
        subZButton.setImage(UIImage(named: "minusZ"), for: UIControl.State.normal)
        addSubview(subZButton)
        
    }
    
    @objc
    func plusX(){ viewController.getCurrentShape()!.position.x += 1 }
    
    @objc
    func minusX(){ viewController.getCurrentShape()!.position.x -= 1 }
    
    @objc
    func plusY(){ viewController.getCurrentShape()!.position.y += 1 }
    
    @objc
    func minusY(){ viewController.getCurrentShape()!.position.y -= 1 }
    
    @objc
    func plusZ(){ viewController.getCurrentShape()!.position.z += 1 }
    
    @objc
    func minusZ(){ viewController.getCurrentShape()!.position.z -= 1 }
    
    
}
