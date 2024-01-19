//
//  ViewController.swift
//  CardLightGradation
//
//  Created by 강조은 on 2024/01/19.
//

import UIKit

class ViewController: UIViewController {
    var status: Bool = true
    
    @IBOutlet weak var cardView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardView.transform = .init(rotationAngle: -0.1)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        cardView.layer.addSublayer(radialGradient)
        radialGradient.frame = self.cardView.bounds
    }
    
    @IBAction func click(_ sender: Any) {
        CATransaction.begin()
        CATransaction.setAnimationDuration(1.0)
        
        UIView.animate(withDuration: 1) {
            if self.status {
                self.changeTransform()
                self.radialGradient.startPoint = CGPoint(x: 1, y: 1)
                self.radialGradient.endPoint = CGPoint(x: 2, y: 2)
            } else {
                self.resetTransform()
                self.radialGradient.startPoint = CGPoint(x: -0.5, y: 0)
                self.radialGradient.endPoint = CGPoint(x: 1, y: 1)
            }
            self.view.layoutIfNeeded()
        }
        
        CATransaction.commit()
        
        status.toggle()
    }
    
    
    func resetTransform() {
        let transform = CATransform3DIdentity
        cardView.layer.cornerRadius = 8
        cardView.layer.transform = transform
    }
    
    func changeTransform() {
        var transform = CATransform3DIdentity
        transform.m34 = -1.0 / 500.0
        transform = CATransform3DRotate(transform, 15 * .pi / 180, 1, 0, 0)
        
        cardView.layer.transform = transform
    }
    
    private lazy var radialGradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.cornerRadius = 20
        gradient.type = .radial
        gradient.colors = [UIColor.white.cgColor, UIColor.blue.cgColor]
        gradient.locations = [-0.5 ,1]
        
        // (0,0)이 원의 중심, (1,1)이 원의 테두리
        gradient.startPoint = CGPoint(x: -0.5, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        return gradient
    }()
}

