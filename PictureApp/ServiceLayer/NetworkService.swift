//
//  NetworkService.swift
//  PictureApp
//
//  Created by Diana Princess on 03.03.2022.
//

import Foundation

protocol NetworkServiceProtocol {
    func getPhotos(completion: @escaping(Result<[ApiPhotoModel]?, Error>) -> Void)
    func getOnePhoto(from text: String, completion: @escaping (Data?, URLResponse?, Error?) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    
    func getPhotos(completion: @escaping (Result<[ApiPhotoModel]?, Error>) -> Void) {
        let urlString = "https://jsonplaceholder.typicode.com/photos"
        guard let url = URL(string: urlString) else {return}
        URLSession.shared.dataTask(with: url){ data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            do {
                let response: [ApiPhotoModel] = try! JSONDecoder().decode([ApiPhotoModel].self, from: data!)
                completion(.success(response))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func getOnePhoto(from text: String, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        guard let photoUrl = URL(string: text) else { return }
        URLSession.shared.dataTask(with: photoUrl, completionHandler: completion).resume()
    }
}

