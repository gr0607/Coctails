//
//  CoctailViewModel.swift
//  Coctails
//
//  Created by admin on 29.03.2023.
//

import Foundation
import UIKit

class DrinkViewModel {

    var firstDownload: (()->(Void))?
    var firstDownloaded = true
    var updateScreen : (()-> (Void))?

    public var coctail: Drink? 

    public var coctailImage: UIImage? {
        didSet {
        if firstDownloaded {
                firstDownload?()
                    firstDownloaded = false
        } else {
                updateScreen?()
            }
        }
    }

    public var coctailName: String {
        coctail?.name ?? "Coctail"
    }

    public var coctailInstructions: String {
        coctail?.instructions ?? ""
    }

    public var coctailImageUrl: String {
        coctail?.imageURL ?? ""
    }

    func fetchCoctail() {
        let url = URL(string: "https://www.thecocktaildb.com/api/json/v1/1/random.php")!

        CoctailRequest.shared.execute(url) { coctail in
            self.coctail = coctail
            let imageURL = URL(string: coctail!.imageURL)!


            ImageRequest.shared.execute(imageURL) { image in
                self.coctailImage = image
            }
        }
    }

    func refreshCoctail() {
        print("from view model")
        fetchCoctail()
    }

}

//MARK: - Ingridients and Measures

extension DrinkViewModel {
    fileprivate var ingridientsWithoutNil: [String] {
        [coctail?.igridientOne, coctail?.igridientTwo, coctail?.igridientThree, coctail?.igridientFour,
         coctail?.igridientFive, coctail?.igridientSix,coctail?.igridientSeven, coctail?.igridientEight].compactMap {$0}

    }

    var ingridients: [String] {
        var result = [String]()

        for i in 1...ingridientsWithoutNil.count {
            result.append("\(i). \(ingridientsWithoutNil[i - 1])")
        }
        return result
    }

    fileprivate var measuresWithoutNil: [String] {
        [coctail?.measureOne, coctail?.measureTwo, coctail?.measureThree, coctail?.measureFour,
         coctail?.measureFive, coctail?.measureSix, coctail?.measureSeven, coctail?.measureEight].compactMap {$0}
    }

    var mesasures: [String] {
        var result = [String]()

        if measuresWithoutNil.count == 0 { return [String]()}

        for i in 1...measuresWithoutNil.count {
            result.append("\(i). \(measuresWithoutNil[i - 1])")
        }
        return result
    }

    var dataSourceFromViewModel: [(String, [String])] {
        [("Ingridients:", ingridients), ("Measure:", mesasures)]
    }
}
