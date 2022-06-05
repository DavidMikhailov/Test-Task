//
//  UsersApi.swift
//  Test Balink
//
//  Created by Давид Михайлов on 05.06.2022.
//

import Foundation

class UsersApi: UsersApiProtocol {
    func get(onComplete: @escaping ([User]?) -> Void) {

        guard let url = URL(string: "https://reqres.in/api/users") else { return }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let data = data else {
                onComplete(nil)
                return
            }

            do {
                let jsonData = try JSONDecoder().decode(Initial.self, from: data)
                let users = jsonData.data
                DispatchQueue.main.async {
                    onComplete(users)
                }
            } catch {
                onComplete(nil)
                print(String(describing: error))
            }
        }.resume()
    }
}
