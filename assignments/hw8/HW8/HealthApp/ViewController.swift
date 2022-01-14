//
//  ViewController.swift
//  HealthApp
//
//  Created by Connor Easton on 3/16/21.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var successLabel: UILabel!
    @IBAction func clearBtnPressed(_ sender: Any) {
        successLabel.isHidden = true
        clearBoxes()

    }
    
    var boxViews: [UIView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        drawCircle(center: self.view.center, radius: 50)
        drawCircle(center: self.view.center, radius: 150)
        successLabel.isHidden = true
        
        let circleGestureRecognizer = CircleGestureRecognizer(target: self, action: #selector(handleCircle))
        circleGestureRecognizer.center = self.view.center
        circleGestureRecognizer.delegate = self
        self.view.addGestureRecognizer(circleGestureRecognizer)
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view is UIButton {
            return false
        }
        return true
    }
    
    @objc func handleCircle(_ sender: CircleGestureRecognizer){
        switch sender.state {
        case .began:
            drawBox(point: sender.location(in: self.view), color: UIColor.red)
        case .changed:
            drawBox(point: sender.location(in: self.view), color: UIColor.red)
        case .ended:
            successLabel.isHidden = false
            successLabel.text = "Success!"
            successLabel.textColor = UIColor.green
        case .cancelled:
            successLabel.isHidden = false
            successLabel.text = "Fail!"
            successLabel.textColor = UIColor.red
        default:
            print("unhandeled switch")
        }
    }
    
    func drawBox(point: CGPoint, color:UIColor){
        let boxRect = CGRect(x: point.x, y:point.y, width: 5.0, height: 5.0)
        let boxView = UIView(frame: boxRect)
        boxView.backgroundColor = color
        self.view?.addSubview(boxView)
        boxViews.append(boxView)
    }
    
    func clearBoxes(){
        for boxView in boxViews{
            boxView.removeFromSuperview()
        }
        boxViews.removeAll()
    }
    
    
    func drawCircle(center: CGPoint, radius: Float) {
        let shapeLayer = CAShapeLayer()
        let circlePath = UIBezierPath(arcCenter: center,radius: CGFloat(radius), startAngle: 0, endAngle: (2 * CGFloat.pi), clockwise: true)
        shapeLayer.path = circlePath.cgPath
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.blue.cgColor
        self.view.layer.addSublayer(shapeLayer)
    }



}

