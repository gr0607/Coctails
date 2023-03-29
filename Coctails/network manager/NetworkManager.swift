//
//  NetworkManager.swift
//  Coctails
//
//  Created by admin on 29.03.2023.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()

    private init() { }

    func loadData(_ url: URL, withCompletion completion: @escaping (Drink?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data, let value = self?.decodeData(data) else {

                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }

            DispatchQueue.main.async {
                completion(value)
            }
        }
        task.resume()
    }


    func decodeData(_ data: Data) -> Drink? {
        let decoder = JSONDecoder()
        let wrappedData = try? decoder.decode(Drinks.self, from: data)
        return wrappedData?.drinks.first
    }
}
