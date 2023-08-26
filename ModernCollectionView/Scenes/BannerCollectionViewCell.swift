//
//  BannerCollectionViewCell.swift
//  ModernCollectionView
//
//  Copyright (c) 2023 z-wook. All right reserved.
//

import UIKit
import Kingfisher

final class BannerCollectionViewCell: UICollectionViewCell {
    static let identifier = "BannerCollectionViewCell"
    
    let titleLabel = UILabel()
    let backgroundImage = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setLayout()
    }
    
    func configure(title: String, imageUrl: String) {
        titleLabel.text = title
        let url = URL(string: imageUrl)
        backgroundImage.kf.setImage(with: url)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension BannerCollectionViewCell {
    func setLayout() {
        [backgroundImage, titleLabel].forEach {
            self.addSubview($0)
        }
        
        titleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        backgroundImage.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
