//
//  Service.swift
//  iTunesSearchApiDemo
//
//  Created by Gokhan Mutlu on 9.12.2021.
//

import Foundation

/*
	Session and DataTask protocols are created for speration of concerns.
 	A session might be URLSession as expected, or an offline session for development or presenting to client, or a TestSession for unit testing.
 
*/

protocol Session{
	associatedtype Task:DataTask
	
	func dataTask(with url: URL,
				  completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> Task
}


protocol DataTask {
	func resume()
}


//URLSession conforms to Session
extension URLSession: Session{ }
extension URLSessionDataTask: DataTask {}

