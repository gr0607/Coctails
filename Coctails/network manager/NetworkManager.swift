//
//  NetworkManager.swift
//  Coctails
//
//  Created by admin on 29.03.2023.
//

import Foundation
import UIKit

protocol NetworkManager: AnyObject {
    associatedtype ModelType
    func decode(_ data: Data) -> ModelType?
    func execute(_ url: URL, withCompletion completion: @escaping (ModelType?) -> Void)
}

extension NetworkManager {
    fileprivate func loadData(_ url: URL, withCompletion completion: @escaping (ModelType?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response , error in
            guard let data = data, let value = self?.decode(data) else {
                DispatchQueue.main.async { completion(nil) }
                return
            }
            DispatchQueue.main.async { completion(value) }
        }
        task.resume()
    }
}

class CoctailManager: NetworkManager {
    typealias ModelType = Drink

    static let shared = CoctailManager()

    private init() { }

    func decode(_ data: Data) -> Drink? {
        let decoder = JSONDecoder()
        let wrappedData = try? decoder.decode(Drinks.self, from: data)
        return wrappedData?.drinks.first
    }

    func execute(_ url: URL, withCompletion completion: @escaping (Drink?) -> Void) {
        loadData(url, withCompletion: completion)
    }
}


class ImageManager: NetworkManager {
    static let shared = ImageManager()

    private init() { }

    func decode(_ data: Data) -> UIImage? {
        return UIImage(data: data)
    }

    func execute(_ url: URL, withCompletion completion: @escaping (UIImage?) -> Void) {
        loadData(url, withCompletion: completion)
    }
}
