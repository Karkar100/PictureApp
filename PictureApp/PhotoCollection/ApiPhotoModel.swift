//
//  APIPhoto.swift
//  PictureApp
//
//  Created by Diana Princess on 03.03.2022.
//

struct ApiPhotoModel: Codable{
    var albumId: Int
    var id: Int
    var title: String
    var url: String
    var thumbnailUrl: String
}
