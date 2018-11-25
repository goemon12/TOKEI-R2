//
//  ViewController.swift
//  TOKEI-R2
//
//  Created by goemon12 on 2018/11/17.
//  Copyright © 2018 goemon12. All rights reserved.
//

import UIKit
import SpriteKit

class ViewController: UIViewController {
    var scene: SKScene!
    var nodeH: SKNode!
    var nodeM: SKNode!
    var nodeS: SKNode!
    var fmtH: DateFormatter!
    var fmtM: DateFormatter!
    var fmtS: DateFormatter!

    func makeRing(radius: CGFloat, num: Int, step: Int) -> SKNode {
        let node = SKNode()
        
        let tmp1 = SKShapeNode(circleOfRadius: radius)
        tmp1.position = CGPoint(x: 0, y: 0)
        tmp1.strokeColor = UIColor.darkGray
        tmp1.fillColor = UIColor.lightGray
        node.addChild(tmp1)
        
        for i in stride(from: 0, to: num, by: step) {
            let tmp2 = SKLabelNode(fontNamed: "Courier")
            tmp2.text = "\(i)"
            tmp2.horizontalAlignmentMode = .center
            tmp2.verticalAlignmentMode = .center
            tmp2.fontColor = UIColor.black
            tmp2.fontSize = 20
            
//          let angle = CGFloat.pi * 2 / CGFloat(num) * CGFloat(i)
            let angle = CGFloat.pi * 2 / CGFloat(num) * CGFloat(i) - CGFloat.pi / 2 //90度引く
            let x = sin(angle) * (radius - 20)
            let y = cos(angle) * (radius - 20)
            tmp2.position = CGPoint(x: x, y: y)
//          tmp2.zRotation = -angle
            tmp2.zRotation = -angle - CGFloat.pi / 2 //90度引く

            node.addChild(tmp2)
        }
        
        return node
    }
    
    func Time() {
        let date = Date()
        let strH = fmtH.string(from: date)
        let strM = fmtM.string(from: date)
        let strS = fmtS.string(from: date)
        let intH = Int(strH)!
        let intM = Int(strM)!
        let intS = Int(strS)!
        
        nodeH.zRotation = CGFloat.pi * 2 / 24 * CGFloat(intH)
        nodeM.zRotation = CGFloat.pi * 2 / 60 * CGFloat(intM)
        nodeS.zRotation = CGFloat.pi * 2 / 60 * CGFloat(intS)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fmtH = DateFormatter()
        fmtM = DateFormatter()
        fmtS = DateFormatter()
        fmtH.dateFormat = "HH"
        fmtM.dateFormat = "mm"
        fmtS.dateFormat = "ss"

        scene = SKScene(size: CGSize(width: 320, height: 480))
        scene.scaleMode = .aspectFit
        let skView = self.view as! SKView
        skView.presentScene(scene)
        
        nodeH = makeRing(radius: 160, num: 24, step: 1)
        nodeH.position = CGPoint(x: 160, y: 240)
        scene.addChild(nodeH)

        nodeM = makeRing(radius: 120, num: 60, step: 5)
        nodeM.position = CGPoint(x: 160, y: 240)
        scene.addChild(nodeM)

        nodeS = makeRing(radius:  80, num: 60, step: 5)
        nodeS.position = CGPoint(x: 160, y: 240)
        scene.addChild(nodeS)
        
        Time()
        
        let winH = SKShapeNode(circleOfRadius: 20)
        winH.strokeColor = UIColor.red
        winH.fillColor = UIColor.clear
//      winH.position = CGPoint(x: 160, y: 240 + 160 - 20)
        winH.position = CGPoint(x: 160 - 160 + 20, y: 240) //赤丸の位置修正
        scene.addChild(winH)
        
        let winM = SKShapeNode(circleOfRadius: 20)
        winM.strokeColor = UIColor.red
        winM.fillColor = UIColor.clear
//      winM.position = CGPoint(x: 160, y: 240 + 120 - 20)
        winM.position = CGPoint(x: 160 - 120 + 20, y: 240) //赤丸の位置修正
        scene.addChild(winM)

        let winS = SKShapeNode(circleOfRadius: 20)
        winS.strokeColor = UIColor.red
        winS.fillColor = UIColor.clear
//      winS.position = CGPoint(x: 160, y: 240 + 80 - 20)
        winS.position = CGPoint(x: 160 - 80 + 20, y: 240) //赤丸の位置修正
        scene.addChild(winS)

        nodeH.run(SKAction.repeatForever(SKAction.rotate(
            byAngle: CGFloat.pi * 2, duration: 3600 * 24)))
        nodeM.run(SKAction.repeatForever(SKAction.rotate(
            byAngle: CGFloat.pi * 2, duration: 3600)))
        nodeS.run(SKAction.repeatForever(SKAction.rotate(
            byAngle: CGFloat.pi * 2, duration: 60)))
    }
}

