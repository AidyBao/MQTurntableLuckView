//
//  MQLotteryViewController.swift
//  MQTurntableLuckView
//
//  Created by 120v on 2018/4/19.
//  Copyright © 2018年 MQ. All rights reserved.
//

import UIKit

class MQLotteryViewController: UIViewController {
    
    var drawprizeView: ZXDrawPrizeView!
    let gridCount = 8

    override func viewDidLoad() {
        super.viewDidLoad()

        let contentWidth = UIScreen.main.bounds.size.width - 30 * 2
        drawprizeView = ZXDrawPrizeView.init(CGPoint.init(x: 30, y: 100), width: contentWidth)
        drawprizeView.backgroundColor = UIColor.clear
        drawprizeView.dataSource = self
        drawprizeView.delegate = self
        self.view.addSubview(drawprizeView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

//MARK: - ZXDrawPrizeDataSource
extension MQLotteryViewController: ZXDrawPrizeDataSource {
    func numberOfPrize(for drawprizeView: ZXDrawPrizeView) -> NSInteger {
        return gridCount
    }
    
    func zxDrawPrize(prizeView: ZXDrawPrizeView, imageAt index: NSInteger) -> UIImage {
        return UIImage.init(named: "emgptyPrize")!
    }
    
    func zxDrawPrize(prizeView: ZXDrawPrizeView, drawOutAt index: NSInteger) -> Bool {
        if index == 3 {
            return true
        }
        return false
    }
    
    func zxDrawPrizeButtonImage(prizeView: ZXDrawPrizeView) -> UIImage {
        return #imageLiteral(resourceName: "Pointer")
    }
    
    func zxDrawPrizeBackgroundImage(prizeView: ZXDrawPrizeView) -> UIImage? {
        return #imageLiteral(resourceName: "turntableBg")
    }
    
    func zxDrawPrizeScrollBackgroundImage(prizeView: ZXDrawPrizeView) -> UIImage? {
        return #imageLiteral(resourceName: "lattice")
    }
}

//MARK: - ZXDrawPrizeDelegate
extension MQLotteryViewController: ZXDrawPrizeDelegate {
    
    func zxDrawPrizeStartAction(prizeView: ZXDrawPrizeView) {
        let prizeIndex = Int(arc4random() % (UInt32(gridCount)))
        print("random index:\(prizeIndex)")
        prizeView.drawPrize(at: NSInteger(prizeIndex))
    }
    
    func zxDrawPrizeEndAction(prizeView: ZXDrawPrizeView, prize index: NSInteger) {
        var value = ""
        if index == 3 {
            value = "已抽完"
        } else if index == 7{
            value = "谢谢参与"
        } else {
            value = "\(index + 1)"
        }
        print("index:\(index), 奖品:\(value)")
//        let checkPrizeVC = ZXCheckPrizeViewController()
//        self.present(checkPrizeVC, animated: true, completion: nil)
    }
}
