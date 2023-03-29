//
//  RandomCoctailViewController.swift
//  Coctails
//
//  Created by admin on 28.03.2023.
//

import UIKit

class RandomCoctailViewController: UIViewController {

    private let coctailViewModel = CoctailViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        coctailViewModel.fetchCoctail()
        print(coctailViewModel.coctail)
    }
}
