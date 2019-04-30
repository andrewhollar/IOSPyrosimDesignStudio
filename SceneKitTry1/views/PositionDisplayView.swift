//
//  PositionDisplay.swift
//  SceneKitTry1
//
//  Created by andrew hollar on 4/12/19.
//  Copyright © 2019 ahollar. All rights reserved.
//
import UIKit
import SceneKit

//View that displays the coordinates of the current object while the user is adjusting the position.
class PositionDisplayView : UIView{
    //var posDisplayBackground: UIView
    
    var viewController: StudioViewController
    let xLabel = UILabel(frame: CGRect(x:-20,y: 0,width: 100,height: 20))
    let yLabel = UILabel(frame: CGRect(x:-20,y: 25,width: 100,height: 20))
    let zLabel = UILabel(frame: CGRect(x:-20,y: 50,width: 100,height: 20))
    
    init(controller: StudioViewController){
        self.viewController = controller
        
        //let tview = UIView()
        let tview = CGRect(x: 295, y: 90, width: 100, height: 75)
        //posDisplayBackground = UIView(frame: tview)
        
        
        //let toolbar = CGRect(x:200,y:50,width:100,height:100)
        //self.addSubview(tview)
        //self.addSubview(tview)
        super.init(frame: tview)
        //self.topAnchor.constraint(equalTo: controller.view.topAnchor, constant: 0)
        
        controller.view.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        //controller.view.addSubview(sensorsButton)
        //sensorsButton.bottomAnchor.constraint(equalTo: controller.view.bottomAnchor, constant: -15).isActive = true
        //sensorsButton.centerXAnchor.constraint(equalTo: controller.view.centerXAnchor, constant:150).isActive = true
        //sensorsButton.leftAnchor.constraint(equalTo: rotationButton.rightAnchor, constant: 15).isActive = true
        //sensorsButton.heightAnchor.constraint(equalToConstant: CGFloat(buttonSize)).isActive = true
        //sensorsButton.widthAnchor.constraint(equalToConstant: CGFloat(buttonSize)).isActive = true
        
        
        self.addSubview(xLabel)
        self.addSubview(yLabel)
        self.addSubview(zLabel)
        
        self.backgroundColor = UIColor.init(red:0.7,green:0.7,blue:0.7, alpha: 1)
        
        
        self.topAnchor.constraint(equalTo: controller.getSegmentedControl().bottomAnchor, constant: 15).isActive = true
        self.rightAnchor.constraint(equalTo: controller.view.rightAnchor, constant: -100).isActive = true
        self.widthAnchor.constraint(equalTo: controller.view.widthAnchor, multiplier: 0.2)
        
        //let margins = self.layoutMarginsGuide
        //let leadingConstraint = self.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 50)
        //let trailingConstraint = self.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        //topConstraint.isActive = true
        //leadingConstraint.isActive = true
        //trailingConstraint.isActive = true
        //backgroundColor = UIColor.init(red:0.7,green:0.7,blue:0.7, alpha: 1)
        
        xLabel.textAlignment = .center
        xLabel.textColor = .white
        xLabel.font = UIFont(name: "Avenir-Light", size: 15.0)
        xLabel.text = "X: \(controller.getCurrentShape()?.position.x)"
        
        yLabel.textAlignment = .center
        yLabel.textColor = .white
        yLabel.font = UIFont(name: "Avenir-Light", size: 15.0)
        yLabel.text = "Y: \(controller.getCurrentShape()?.position.y)"
        
        zLabel.textAlignment = .center
        zLabel.textColor = .white
        zLabel.font = UIFont(name: "Avenir-Light", size: 15.0)
        zLabel.text = "Z: \(controller.getCurrentShape()?.position.z)"
        
        
    }
    
    func updatePositionLabels(controller: StudioViewController) {
        
        /*print(controller.getCurrentShape()!.position.x)
         print(controller.getCurrentShape()!.position.y)
         print(controller.getCurrentShape()!.position.z)
         */
        
        DispatchQueue.main.async {
            if (controller.getCurrentShape() != nil) {
                //self.posDisplayBackground.subviews.index(after: 0)
                self.xLabel.text = "X: \(controller.getCurrentShape()!.position.x)"
                self.yLabel.text = "Y: \(controller.getCurrentShape()!.position.y)"
                self.zLabel.text = "Z: \(controller.getCurrentShape()!.position.z)"
            }
        }
        
        //dispatch_async(dispatch_get_main_queue(), ^{
        
        //Do any updates to your label here
        //    xLabel.text = "X: \(controller.getCurrentShape()!.position.x)"
        
        //   });
        
        
        
        // yLabel.text = "Y: \(controller.getCurrentShape()!.position.y)"
        //zLabel.text = "Z: \(controller.getCurrentShape()!.position.z)"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
