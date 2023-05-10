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

        CoctailManager.shared.execute(url) { coctail in
            self.coctail = coctail
            let imageURL = URL(string: coctail!.imageURL)!


            ImageManager.shared.execute(imageURL) { image in
                print(image)
            }

        }
    }

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

        for i in 1...measuresWithoutNil.count {
            result.append("\(i). \(measuresWithoutNil[i - 1])")
        }
        return result
    }

    var dataSourceFromViewModel: [(String, [String])] {
        [("Ingridients:", ingridients), ("Measure:", mesasures)]
    }
}
