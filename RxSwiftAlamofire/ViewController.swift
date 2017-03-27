//
//  ViewController.swift
//  RxSwiftAlamofire
//
//  Created by Arash on 3/27/17.
//  Copyright © 2017 Arash Z. Jahangiri. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import ObjectMapper

class ViewController: UIViewController {
    
    @IBOutlet weak var refreshButton:                   UIButton!
    @IBOutlet weak var dateLabel:                       UILabel!
    var animationImageView:                             UIImageView!
    let disposeBag =                                    DisposeBag()
    let model =                                         Network()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.refreshButton.rx.tap
            .debounce(0.03, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [unowned self] in
                self.model.fetchDate()
                    .subscribe(onNext: {  [weak self] (dateString) in
                        self?.dateLabel.text = dateString
                        self?.stopAnimating()
                    })
                    .addDisposableTo(self.disposeBag)
                self.dateLabel.text = "fetching date ..."
                self.animating()
            }).addDisposableTo(disposeBag)
        
        
        
        model.fetchDate()
            .subscribe(onNext: {  [weak self] (element) in
                self?.dateLabel.text = element
            })
            .addDisposableTo(disposeBag)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func animating()
    {
        self.refreshButton.setImage(UIImage(named: ""), for: .normal)
        
        let imageNames = ["refresh.jpg","refresh2.jpg"]
        var images = [UIImage]()
        
        for i in 0..<imageNames.count
        {
            images.append(UIImage(named: imageNames[i])!)
        }
        
        animationImageView = UIImageView(frame: self.refreshButton.frame)
        animationImageView.animationImages = images
        animationImageView.animationDuration = 0.45
        self.view.addSubview(animationImageView)
        animationImageView.startAnimating()
    }
    
    func stopAnimating() {
        self.refreshButton.setImage(UIImage(named: "refresh.png"), for: .normal)
        animationImageView.stopAnimating()
    }
}

