//
//  ListCarouselCollectionViewCell.swift
//  ModernCollectionView
//
//  Copyright (c) 2023 z-wook. All right reserved.
//

import UIKit

final class ListCarouselCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ListCarouselCollectionViewCell"
    
    private let mainImage = UIImageView()
    private let titleLabel = UILabel()
    private let subTitleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setLayout()
    }
    
    func configure(imageUrl: String, title: String, subTitle: String?) {
        let url = URL(string: imageUrl)
        mainImage.kf.setImage(with: url)
        titleLabel.text = title
        subTitleLabel.text = subTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension ListCarouselCollectionViewCell {
    func setLayout() {
        [mainImage, titleLabel, subTitleLabel].forEach {
            self.addSubview($0)
        }
        
        mainImage.snp.makeConstraints {
            $0.leading.top.bottom.equalToSuperview()
            $0.width.equalTo(60)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.trailing.equalToSuperview()
            $0.leading.equalTo(mainImage.snp.trailing).offset(8)
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.equalTo(mainImage.snp.trailing).offset(8)
            $0.trailing.equalToSuperview()
        }
    }
}
