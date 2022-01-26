//
//  SearchedItemViewModel.swift
//  iTunesSearchApiDemo
//
//  Created by Gokhan Mutlu on 9.12.2021.
//

import Foundation

struct SearchedItemViewModel{
	
	init(searchItem:SearchItem){
		self.searchItem = searchItem
	}
	
	
	private let searchItem:SearchItem
	
	let id = UUID()
	
	var wrapperType:String{ return searchItem.wrapperType }
	var kind:String?{ return searchItem.kind }

//	var artistId:Int?
//	var collectionId:Int?
//	var trackId:Int?
	var artistName:String{ return searchItem.artistName }
	
	var collectionName:String?{ return searchItem.artistName }
	var trackName:String?{ return searchItem.trackName }
	var artworkUrl60:String?{ return searchItem.artworkUrl60 }
	
	var collectionPrice:Double?{ return searchItem.collectionPrice }
	var trackPrice:Double?{ return searchItem.trackPrice }
	var currency:String{ return searchItem.currency }
	var country:String{ return searchItem.country }
}


extension SearchedItemViewModel{
	static var placeholder:SearchedItemViewModel{
		return
			SearchedItemViewModel(searchItem: SearchItem(
				wrapperType: "track",
				kind: "song",
				artistId: 16668076,
				collectionId: 296748581,
				trackId: 296748592,
				artistName: "Jim Jones & Skull Gang",
				collectionName: "Bad Santa (Jim Jones & Skull Gang Present) [Starring Mike Epps]",
				trackName: "Jingle Bellz (feat. Starr & Juelz Santana)",
				artworkUrl60: "https://is5-ssl.mzstatic.com/image/thumb/Music/v4/a4/36/2e/a4362e1d-702c-fcc3-3cc2-43ec27f20079/source/60x60bb.jpg",
				collectionPrice: 5.99,
				trackPrice: 0.99,
				currency: "CAD",
				country: "CAN"
			))
	}
}
