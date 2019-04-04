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
    
    var viewController: StudioViewController
    var toolBarManager: ToolBarManager
    var shapeButton: UIButton
    var moveButton: UIButton
    var rotationButton: UIButton
    
    init(controller: StudioViewController){
        self.viewController = controller
        self.toolBarManager = controller.getToolBarManager()
        self.shapeButton = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 50)) //sphere button
        self.moveButton = UIButton(frame: CGRect(x: 100, y: 0, width: 100, height: 50)) //rectangle button
        self.rotationButton = UIButton(frame: CGRect(x: 300, y:0, width: 100, height: 50))
        
        let toolbar = CGRect(x:0,y:800,width:800,height:100)
        super.init(frame: toolbar)
         backgroundColor = UIColor.darkGray
        
        shapeButton.addTarget(self, action: #selector(toggleShape), for: .primaryActionTriggered)
        shapeButton.setImage(UIImage(named: "ShapesButton"), for: UIControl.State.normal)
        addSubview(shapeButton)
        
        moveButton.addTarget(self, action: #selector(toggleMovement), for: .primaryActionTriggered)
        moveButton.setImage(UIImage(named: "moveButton"), for: UIControl.State.normal)
        addSubview(moveButton)
        
        rotationButton.addTarget(self, action: #selector(toggleRotation), for: .primaryActionTriggered)
        rotationButton.setImage(UIImage(named: "rotationButton"), for: UIControl.State.normal)
        addSubview(rotationButton)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    func toggleShape() {
        toolBarManager.setCurrent(name: "shapeSelector")
    }
    
    @objc
    func toggleMovement() {
        toolBarManager.setCurrent(name: "movement")
    }
    
    @objc
    func toggleRotation() {
        toolBarManager.setCurrent(name: "rotation")
    }
}
