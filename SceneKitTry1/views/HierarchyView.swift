//
//  HierarchyView.swift
//  SceneKitTry1
//
//  Created by William Sutton on 3/29/19.
//  Copyright © 2019 ahollar. All rights reserved.
//

import Foundation
import UIKit
import SceneKit

class HierarchyView: UIScrollView{
    var viewController: StudioViewController
    var robot: Robot
    
    init(controller: StudioViewController){
        self.viewController = controller
        self.robot = controller.getRobot()
        let toolbar = CGRect(x:0,y:33,width:77,height:300)
        super.init(frame: toolbar)
        backgroundColor = UIColor.darkGray
        
        let contentWidth = bounds.width
        let contentHeight = bounds.height * 5
        contentSize = CGSize(width: contentWidth, height: contentHeight)
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(){
        for view in subviews{
            view.removeFromSuperview()
        }
        var i = 0;
        for node in robot.getShapeNodes(){
            let selectPartButton = UIButton(frame: CGRect(x: 15, y: (i*30)+15, width: 25, height: 25))
            selectPartButton.backgroundColor = node.geometry?.firstMaterial?.diffuse.contents as! UIColor
            selectPartButton.setTitle("O\(i)", for: .normal)
            selectPartButton.addTarget(self, action: #selector(setCurrentShape), for: .primaryActionTriggered)
            addSubview(selectPartButton)
            i+=1
        }
        
    }
    
    @objc
    func setCurrentShape(sender: UIButton!) {
        let title = sender.currentTitle!
        let objectType = title.first!
        let index = Int(title.dropFirst())!
        if(objectType == "O"){
            viewController.setCurrentShape(node: robot.getShapeNodes()[index])
        }
        update()
    }
    
}
