//
//  RandomCoctailViewController.swift
//  Coctails
//
//  Created by admin on 28.03.2023.
//

import UIKit

class RandomCoctailViewController: UIViewController {

    public var coctailViewModel: CoctailViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green

        print(self.coctailViewModel?.coctail)
    }
}
