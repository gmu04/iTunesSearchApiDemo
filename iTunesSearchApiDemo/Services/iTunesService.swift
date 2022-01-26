//
//  iTunesService.swift
//  iTunesSearchApiDemo
//
//  Created by Gokhan Mutlu on 16.01.2022.
//

import Foundation


final class iTunesService<S:Session>{
	
	//injecting session
	init(session:S){
		self.client = HttpClient(session: session)
	}
	
	
	internal func searchContentFor(_ term:String, completion:@escaping (Result<[SearchItem], iTunesSearchApiError>)->()){
		//prepare search url
		guard let validUrl = prepareUrl(term: term) else { fatalError("Url is not valid!") }
		
		//call API client to search
		client.searchContentFor(url: validUrl){ result in
			
			switch result{
				case .failure(let iTunesSearchApiError):
					completion(.failure(iTunesSearchApiError))
					
				case .success(let data):
					if let errorString = self.getSearchItems(from: data){
						completion(.failure(iTunesSearchApiError.jsonParsing(errorString)))
					}else{
						completion(.success(self.searchItems!))
					}
			}
		}
		
	}
	
	
	private func getSearchItems(from data:Data) -> String?{
		let decoder = JSONDecoder()
		do{
			let searchApiResponse = try decoder.decode(SearchApiResponse.self, from: data)
			self.searchItems = searchApiResponse.results
		}catch{
			print(error)
			searchItems = nil
			return error.localizedDescription  //completion(.failure(.jsonParsing(error.localizedDescription)))
		}
		return nil
	}
	
	/**
	 Prepare search url
	 - Parameter term: The URL-encoded text string you want to search for. (iTunes Search API)
	 */
	private func prepareUrl(term:String) -> URL?{
		var c = URLComponents()
		c.scheme = "https"
		c.host = "itunes.apple.com"
		c.path = "/search"
		
		//"jack+johnson"
		let termCleaned = term
			.components(separatedBy: .whitespacesAndNewlines)
			.joined(separator: " ")
			.trimmingCharacters(in: .whitespaces)
		
		c.queryItems = [
			URLQueryItem(name: "term", value: termCleaned),
			URLQueryItem(name: "limit", value: maxLimitOfSearch)
		]
		
		print("⇢\(c.url?.absoluteString ?? "url?")")
		return c.url
	}
	
	
	
	//MARK: - Properties
	
	private var searchItems:[SearchItem]?
	private let client:HttpClient<S>
	
	
	// max 200 items per single search - cache it, and show it in 40 items page(s)
	private let maxLimitOfSearch = "200"
	
}
