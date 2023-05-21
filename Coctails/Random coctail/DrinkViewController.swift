//
//  RandomCoctailViewController.swift
//  Coctails
//
//  Created by admin on 28.03.2023.
//

import UIKit

//
//  RandomCoctailViewController.swift
//  Coctails
//
//  Created by admin on 28.03.2023.
//

import UIKit
import SnapKit

class DrinkViewController: UIViewController {

    //MARK: - Properties

    public var coctailViewModel: DrinkViewModel?

    private lazy var titleLable: UILabel = {
        let label = UILabel()
        label.text = coctailViewModel?.coctailName
        label.font = UIFont(name: "Palatino", size: 35)
        label.textColor = .textColor
        return label
    }()

    private lazy var imageCoctail: UIImageView = {
        let imageView = UIImageView()
        imageView.image = coctailViewModel?.coctailImage
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 16
        imageView.contentMode = .scaleAspectFill
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
        tv.text = coctailViewModel?.coctailInstructions
        tv.font = UIFont(name: "Palatino", size: 20)
        tv.backgroundColor = .lightBrownBackgroundColor
        tv.textColor = .textColor
        return tv
    }()

    private lazy var tableView: UITableView = {
        var tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = .lightBrownBackgroundColor
        tableView.tableHeaderView?.backgroundColor = .lightBrownBackgroundColor
        return tableView
    }()

    private lazy var likeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "like")!, for: .normal)
        return button
    }()

    private lazy var refreshButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "refresh")!, for: .normal)
        button.addTarget(self, action: #selector(refreshCoctail), for: .touchUpInside)
        return button
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [likeButton, refreshButton])
        stackView.backgroundColor = .lightBrownBackgroundColor
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        return stackView
    }()

    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        setupUI()
    }

    //MARK: - Helpers UI

    func setupUI() {
        view.backgroundColor = .lightBrownBackgroundColor

        view.addSubview(titleLable)
        view.addSubview(imageCoctail)
        view.addSubview(instructionNameLabel)
        view.addSubview(instructionTextView)
        view.addSubview(tableView)
        view.addSubview(stackView)

        makeConstraints()
    }

    func makeConstraints() {
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
            make.left.equalTo(view.snp.left).offset(4)
            make.right.equalTo(view.snp.centerX).offset(-16)
            make.height.equalTo(180)
        }

        tableView.snp.makeConstraints { make in
            make.top.equalTo(titleLable.snp.bottom).offset(16)
            make.left.equalTo(view.snp.centerX).offset(0)
            make.right.equalTo(view.snp.right).offset(-8)
            make.bottom.equalTo(instructionTextView.snp.bottom)
        }


        stackView.snp.makeConstraints { make in
            make.top.equalTo(imageCoctail.snp.bottom).offset(16)
            make.left.equalTo(view.snp.left).offset(16)
            make.right.equalTo(view.snp.centerX).offset(-16)
            make.height.equalTo(60)
        }
    }

    //MARK: - Logic
    @objc func refreshCoctail() {
        coctailViewModel?.refreshCoctail()
        coctailViewModel?.updateScreen = { [weak self] in
            self?.updateUI()
        }
    }

    func updateUI() {
        titleLable.text = coctailViewModel?.coctailName
        imageCoctail.image = coctailViewModel?.coctailImage
        instructionTextView.text = coctailViewModel?.coctailInstructions
        tableView.reloadData()
    }
}

//MARK: - TableViewDataSource

extension DrinkViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return coctailViewModel?.dataSourceFromViewModel.count ?? 0
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return coctailViewModel!.dataSourceFromViewModel[section].0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let text = coctailViewModel?.dataSourceFromViewModel[indexPath.section].1[indexPath.row] ?? "Oops"
        cell.backgroundColor = .lightBrownBackgroundColor
        cell.textLabel?.text = text
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        coctailViewModel?.dataSourceFromViewModel[section].1.count ?? 0
    }
}

//MARK: - TableViewDelegeta

extension DrinkViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        32
    }

    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        (view as! UITableViewHeaderFooterView).contentView.backgroundColor = .lightBrownBackgroundColor
    }
}
