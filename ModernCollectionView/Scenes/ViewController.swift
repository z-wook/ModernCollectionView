//
//  ViewController.swift
//  ModernCollectionView
//
//  Copyright (c) 2023 z-wook. All right reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    let imageUrl = "https://www.shinailbo.co.kr/news/photo/202303/1678683_841883_1519.png"
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(BannerCollectionViewCell.self, forCellWithReuseIdentifier: BannerCollectionViewCell.identifier)
        collectionView.register(NomalCaroselCollectionViewCell.self, forCellWithReuseIdentifier: NomalCaroselCollectionViewCell.identifier)
        collectionView.register(ListCarouselCollectionViewCell.self, forCellWithReuseIdentifier: ListCarouselCollectionViewCell.identifier)
        collectionView.setCollectionViewLayout(collectionViewLayout(), animated: true)
        setLayout()
        setDataSource()
        setSnapShot()
    }
}

private extension ViewController {
    func setLayout() {
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func setDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            switch itemIdentifier {
            case .banner(let item):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCollectionViewCell.identifier,
                                                                    for: indexPath) as? BannerCollectionViewCell else { return UICollectionViewCell() }
                cell.configure(title: item.title, imageUrl: item.imageUrl)
                return cell
                
            case .nomalCarousel(let item):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NomalCaroselCollectionViewCell.identifier,
                                                                    for: indexPath) as? NomalCaroselCollectionViewCell else { return UICollectionViewCell() }
                cell.configure(imageUrl: item.imageUrl, title: item.title, subTitle: item.subTitle)
                return cell
                
            case .listCarousel(let item):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListCarouselCollectionViewCell.identifier,
                                                                    for: indexPath) as? ListCarouselCollectionViewCell else { return UICollectionViewCell() }
                cell.configure(imageUrl: item.imageUrl, title: item.title, subTitle: item.subTitle)
                return cell
            }
        })
    }
    
    func setSnapShot() {
        var snapShot = NSDiffableDataSourceSnapshot<Section, Item>()
        let bannerSection = Section(id: "Banner")
        let nomalSection = Section(id: "NomalCarosel")
        let listSection = Section(id: "listCarosel")
        
        snapShot.appendSections([bannerSection])
        snapShot.appendSections([nomalSection])
        snapShot.appendSections([listSection])
        
        let bannerItems = [
            Item.banner(HomeItem(title: "교촌 치킨",
                                 imageUrl: imageUrl)),
            Item.banner(HomeItem(title: "굽네 치킨",
                                 imageUrl: imageUrl)),
            Item.banner(HomeItem(title: "푸라닭 치킨",
                                 imageUrl: imageUrl))
        ]
        
        let nomalItems = [
            Item.nomalCarousel(HomeItem(title: "BBQ", subTitle: "황금 올리브 후라이드 치킨", imageUrl: imageUrl)),
            Item.nomalCarousel(HomeItem(title: "순살만 공격", subTitle: "순살 치킨", imageUrl: imageUrl)),
            Item.nomalCarousel(HomeItem(title: "오꾸닭", subTitle: "오븐 치킨", imageUrl: imageUrl)),
            Item.nomalCarousel(HomeItem(title: "BHC", subTitle: "뿌링클 치킨", imageUrl: imageUrl))
        ]
        
        let listItems = [
            Item.listCarousel(HomeItem(title: "네네치킨", subTitle: "네네 마늘치킨", imageUrl: imageUrl)),
            Item.listCarousel(HomeItem(title: "후라이드 참 잘하는 집", subTitle: "양념 치킨", imageUrl: imageUrl)),
            Item.listCarousel(HomeItem(title: "오꾸닭", subTitle: "오븐 치킨", imageUrl: imageUrl)),
            Item.listCarousel(HomeItem(title: "지코바", subTitle: "순살 소금구이", imageUrl: imageUrl)),
            Item.listCarousel(HomeItem(title: "칠칠 켄터키", subTitle: "마라 치킨", imageUrl: imageUrl)),
            Item.listCarousel(HomeItem(title: "처갓집", subTitle: "양념 치킨", imageUrl: imageUrl)),
            Item.listCarousel(HomeItem(title: "당치땡", subTitle: "청담동 트러플 치킨", imageUrl: imageUrl))
        ]
        
        snapShot.appendItems(bannerItems, toSection: bannerSection)
        snapShot.appendItems(nomalItems, toSection: nomalSection)
        snapShot.appendItems(listItems, toSection: listSection)
        
        dataSource?.apply(snapShot)
    }
    
    func collectionViewLayout() -> UICollectionViewCompositionalLayout {
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 30
        
        return UICollectionViewCompositionalLayout(sectionProvider: { [weak self] sectionNum, env in
            switch sectionNum {
            case 0:
                return self?.createBannerSection()
            case 1:
                return self?.createNomalCarouselSection()
            case 2:
                return self?.createListCarouselSection()
            default:
                return self?.createBannerSection()
            }
        }, configuration: config)
    }
    
    func createBannerSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        return section
    }
    
    func createNomalCarouselSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.7), heightDimension: .absolute(120))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = .init(top: 0, leading: 20, bottom: 0, trailing: 20)
        section.interGroupSpacing = 16
        return section
    }
    
    func createListCarouselSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1/3))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 15, leading: 0, bottom: 0, trailing: 0)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(250))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = .init(top: 0, leading: 20, bottom: 0, trailing: 20)
        return section
    }
}
