//
//  ToolBarRobotParts.swift
//  SceneKitTry1
//
//  Created by William Sutton on 2/28/19.
//  Copyright © 2019 ahollar. All rights reserved.
//

import Foundation
import UIKit
import SceneKit

class ToolBarRobotParts{
    var viewController: StudioViewController
    var shapeNodes = [SCNNode]()
    var neuronNodes = [SCNNode]()
    let toolView: UIView
    
    init(controller: StudioViewController){
        self.viewController = controller
        let toolbar = CGRect(x:0,y:33,width:77,height:300)
        toolView = UIView(frame:toolbar)
        toolView.backgroundColor = UIColor.darkGray
        viewController.view.addSubview(toolView)
    }
    
    func update(){
        for view in toolView.subviews{
            view.removeFromSuperview()
        }
        var i = 0;
        for node in shapeNodes{
            let SelectPartButton = UIButton(frame: CGRect(x: 15, y: (i*30)+15, width: 25, height: 25))
            SelectPartButton.backgroundColor = node.geometry?.firstMaterial?.diffuse.contents as! UIColor
            SelectPartButton.setTitle("O\(i)", for: .normal)
            SelectPartButton.addTarget(self, action: #selector(setCurrentShape), for: .primaryActionTriggered)
            toolView.addSubview(SelectPartButton)
            i+=1
        }
        
    }
    
    @objc
    func setCurrentShape(sender: UIButton!) {
        var title = sender.currentTitle!
        let objectType = title.first!
        let index = Int(title.dropFirst())!
        print("\(objectType) - \(index)")
        if(objectType == "O"){
            viewController.setCurrentShape(node: shapeNodes[index])
        }
        update()
    }
    
    func addShapeNode(node: SCNNode){
        shapeNodes.append(node)
        viewController.setCurrentShape(node: node)
        update()
    }
    
    func removeShapeNode(node: SCNNode){
        if let index = shapeNodes.index(of:node) {
            shapeNodes.remove(at: index)
            update()
        }
    }
    
}
