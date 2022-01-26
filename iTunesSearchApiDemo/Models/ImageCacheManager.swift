//
//  ImageCacheManager.swift
//  iTunesSearchApiDemo
//
//  Created by Gokhan Mutlu on 9.12.2021.
//

import Foundation
import Combine

/**
 Cach manager for images
*/
class ImageCacheManager:ObservableObject{
	
	//images
	var artworkUrl60Images = NSCache<NSString, AnyObject>()
	
	/*
	//Keys - no need now
	enum CacheKey:NSString{
		case artworkUrl60
	}
	*/
}

