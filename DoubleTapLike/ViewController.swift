//
//  ViewController.swift
//  DoubleTapLike
//
//  Created by Saadet Şimşek on 08/09/2024.
//

import UIKit

class ViewController: UIViewController {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        imageView.image = UIImage(named: "image")
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(imageView)
        imageView.frame = CGRect(x: 0,
                                 y: 0,
                                 width: view.frame.size.width,
                                 height: 500)
        imageView.center = view.center
        
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(didDoubleTap(_:)))
        tapGesture.numberOfTapsRequired = 2
        imageView.addGestureRecognizer(tapGesture)
        
    }
    
    @objc private func didDoubleTap(_ gesture: UITapGestureRecognizer) {
        guard let gestureView = gesture.view else{
            return
        }
        
        let size = gestureView.frame.size.width/4
        //create a heart, add it, show with fade, hide wih fade, remove
        let heart = UIImageView(image: UIImage(systemName: "suit.heart.fill"))
        heart.frame = CGRect(x: (gestureView.frame.size.width-size)/2,
                             y: (gestureView.frame.size.height-size)/2,
                             width: size,
                             height: size)
        heart.tintColor = .systemRed
        heart.alpha = 0
        gestureView.addSubview(heart)
        
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute: {
            UIView.animate(withDuration: 0.5, animations: {
                heart.alpha = 1
            }, completion: { done in
                if done {
                    UIView.animate(withDuration: 1, animations: {
                        heart.alpha = 0
                    }, completion: { done in
                        if done {
                            heart.removeFromSuperview()
                        }
                    })
                }
            })
        })
    }
}

