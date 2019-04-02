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
    var buttons = [UIButton]()
    
    init(controller: StudioViewController){
        self.viewController = controller
        self.toolBarManager = controller.getToolBarManager()
        self.shapeButton = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 50)) //sphere button
        self.moveButton = UIButton(frame: CGRect(x: 100, y: 0, width: 100, height: 50)) //rectangle button
        
        let toolbar = CGRect(x:0,y:800,width:800,height:100)
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
