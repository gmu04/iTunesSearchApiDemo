//
//  iTunesSearchApiError.swift
//  iTunesSearchApiDemo
//
//  Created by Gokhan Mutlu on 9.12.2021.
//

import Foundation

enum iTunesSearchApiError:Error{
	case anyError(Error)
	case jsonParsing(String)
	case statusCodeNot200
}
