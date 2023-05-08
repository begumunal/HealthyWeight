//
//  TripleImageView.swift
//  HealthyWeight
//
//  Created by Begum Unal on 2.05.2023.
//

import Foundation
import UIKit

class TripleImageView: UIView {
    private let scrollView = UIScrollView()
    private let imageView1 = UIImageView()
    private let imageView2 = UIImageView()
    private let imageView3 = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        addSubview(scrollView)
        
        imageView1.contentMode = .scaleAspectFit
        imageView2.contentMode = .scaleAspectFit
        imageView3.contentMode = .scaleAspectFit
        
        imageView1.backgroundColor = AppColors.barGreen
        imageView2.backgroundColor = AppColors.barGreen
        imageView3.backgroundColor = AppColors.barGreen
        
        imageView1.image = AppImages.tripleImageView1
        imageView2.image = AppImages.tripleImageView2
        imageView3.image = AppImages.tripleImageView3
        
        scrollView.addSubview(imageView1)
        scrollView.addSubview(imageView2)
        scrollView.addSubview(imageView3)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        scrollView.frame = bounds
        scrollView.contentSize = CGSize(width: bounds.width * 3, height: bounds.height)
        imageView1.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height)
        imageView2.frame = CGRect(x: bounds.width, y: 0, width: bounds.width, height: bounds.height)
        imageView3.frame = CGRect(x: bounds.width * 2, y: 0, width: bounds.width, height: bounds.height)
    }
    
    
}

extension TripleImageView : UIScrollViewDelegate{
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let contentOffset = scrollView.contentOffset
    
        if contentOffset.x == 0 {
            self.updatePointIconImage(image: AppImages.firstPointIcon!)
        } else if contentOffset.x == scrollView.bounds.width {
            self.updatePointIconImage(image: AppImages.secondPointIcon!)
        } else if contentOffset.x == scrollView.bounds.width * 2 {
            self.updatePointIconImage(image: AppImages.thirdPointIcon!)
        }
    }
    // MARK: - OBSERVER DESİGN PATTERN
    func updatePointIconImage(image : UIImage) {
        // pointIcon'un image özelliğini değiştirdiğimizde, bir Notification gönderiyoruz
        NotificationCenter.default.post(name: Notification.Name(Constants.pointIconcUpdateNotificationName), object: image)
    }
}
