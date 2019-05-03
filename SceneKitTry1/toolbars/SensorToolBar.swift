//
//  SensorToolBar.swift
//  SceneKitTry1
//
//  Created by William Sutton on 5/2/19.
//  Copyright © 2019 ahollar. All rights reserved.
//

import Foundation
import UIKit
import SceneKit

class SensorToolBar: UIView{
    
    var viewController: StudioViewController
    
    var buttonSize = 75
    
    init(controller: StudioViewController){
        self.viewController = controller
        
        let toolbar = CGRect(x:0,y:700,width:800,height:buttonSize)
        super.init(frame: toolbar)
        backgroundColor = UIColor.init(red:0.7,green:0.7,blue:0.7, alpha: 1)
        populateWithButtons()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func populateWithButtons(){
        let sphereButton = UIButton(frame: CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize)) //sphere button
        sphereButton.addTarget(self, action: #selector(toggleSensorToggleActive), for: .primaryActionTriggered)
        sphereButton.setImage(UIImage(named: "sphereButton"), for: UIControl.State.normal)
        addSubview(sphereButton)
    }
    
    @objc
    func toggleSensorToggleActive() {
        viewController.toggleSensorToggleActive()
    }
    
}
