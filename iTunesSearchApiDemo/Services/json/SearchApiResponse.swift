//
//  iTunesSearchApiResponse.swift
//  iTunesSearchApiDemo
//
//  Created by Gokhan Mutlu on 9.12.2021.
//

import Foundation


struct SearchApiResponse: Decodable{
	let resultCount:Int
	var results:[SearchItem]
}

