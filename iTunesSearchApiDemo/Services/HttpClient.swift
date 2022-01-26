//
//  iTunesSearchApi.swift
//  iTunesSearchApiDemo
//
//  Created by Gokhan Mutlu on 9.12.2021.
//

import Foundation

final class HttpClient<S:Session>{
	
	//injecting session
	init(session:S){
		self.session = session
	}
	
	func searchContentFor(url:URL, completion:@escaping (Result<Data, iTunesSearchApiError>)->()){
		
		let task = session.dataTask(with: url) { data, response, error in
			guard let dataValid = data, error == nil else {
				return completion(.failure(.anyError(error!)))
			}
			
			if let urlResponse = response as? HTTPURLResponse, urlResponse.statusCode != 200{
//				print(urlResponse)
//				print(String(data: dataValid, encoding: .utf8))
				return completion(.failure(.statusCodeNot200))
			}
			
			completion(.success(dataValid))
			
		}
		
		task.resume()
	}
	
	
	//MARK: - Properties
	
	private let session: S

}
