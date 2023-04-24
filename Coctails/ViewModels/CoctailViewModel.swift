//
//  CoctailViewModel.swift
//  Coctails
//
//  Created by admin on 29.03.2023.
//

import Foundation

class CoctailViewModel {

    var firstDownload: (()->(Void))?

    public var coctail: Drink? {
        didSet {
            firstDownload?()
        }
    }

    func fetchCoctail() {
        let url = URL(string: "https://www.thecocktaildb.com/api/json/v1/1/random.php")!
        NetworkManager.shared.loadData(url) { coctail in
            self.coctail = coctail
        }
    }
}
