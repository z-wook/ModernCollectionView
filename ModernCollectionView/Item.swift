//
//  Item.swift
//  ModernCollectionView
//
//  Copyright (c) 2023 z-wook. All right reserved.
//

import Foundation

struct Section: Hashable {
    let id: String
}

enum Item: Hashable {
    case banner(HomeItem)
    case nomalCarousel(HomeItem)
    case listCarousel(HomeItem)
}

struct HomeItem: Hashable {
    let title: String
    let subTitle: String
    let imageUrl: String
}
