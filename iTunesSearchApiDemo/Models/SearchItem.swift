//
//  SearchItem.swift
//  iTunesSearchApiDemo
//
//  Created by Gokhan Mutlu on 9.12.2021.
//

import Foundation

struct SearchItem:Decodable{
	let wrapperType:String
	let kind:String?
	
	let artistId:Int?
	let collectionId:Int?
	let trackId:Int?
	
	let artistName:String
	let collectionName:String?
	let trackName:String?
	let artworkUrl60:String?
	
	let collectionPrice:Double?
	let trackPrice:Double?
	let currency:String
	let country:String
}
