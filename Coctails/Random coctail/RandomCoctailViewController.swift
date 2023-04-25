//
//  RandomCoctailViewController.swift
//  Coctails
//
//  Created by admin on 28.03.2023.
//

import UIKit
import SnapKit

class RandomCoctailViewController: UIViewController {

    public var coctailViewModel: CoctailViewModel?

    private lazy var titleLable: UILabel = {
        let label = UILabel()
        label.text = coctailViewModel?.coctail?.name ?? "Coctail"
        label.font = UIFont(name: "Palatino", size: 35)
        label.textColor = .textColor
        return label
    }()

    private lazy var imageCoctail: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "coctail")
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 16
        imageView.contentMode = .scaleToFill
        return imageView
    }()

    private var instructionNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Instructions:"
        label.font = UIFont(name: "Palatino", size: 25)
        label.textColor = .textColor
        return label
    }()

    private lazy var instructionTextView: UITextView = {
        let tv = UITextView()
        tv.text = coctailViewModel?.coctail?.instructions ?? "??"
        tv.font = UIFont(name: "Palatino", size: 20)
        tv.backgroundColor = .lightBrownBackgroundColor
        tv.textColor = .textColor
        return tv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    func setupUI() {
        view.backgroundColor = .lightBrownBackgroundColor

        view.addSubview(titleLable)
        view.addSubview(imageCoctail)
        view.addSubview(instructionNameLabel)
        view.addSubview(instructionTextView)

        titleLable.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(view.snp.top).offset(100)
        }

        imageCoctail.snp.makeConstraints { make in
            make.top.equalTo(titleLable.snp.bottom).offset(16)
            make.left.equalTo(view.snp.left).offset(16)
            make.right.equalTo(view.snp.centerX).offset(-16)
            make.height.equalTo(imageCoctail.snp.width)
        }

        instructionNameLabel.snp.makeConstraints { make in
            make.top.equalTo(view.snp.centerY)
            make.left.equalTo(view.snp.left).offset(16)
            make.right.equalTo(view.snp.centerX).offset(-8)
        }

        instructionTextView.snp.makeConstraints { make in
            make.top.equalTo(instructionNameLabel.snp.bottom).offset(8)
            make.left.equalTo(view.snp.left).offset(16)
            make.right.equalTo(view.snp.centerX).offset(-8)
            make.height.equalTo(180)
        }

    }

}
