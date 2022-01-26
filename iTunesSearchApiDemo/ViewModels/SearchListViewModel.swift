//
//  SearchListViewModel.swift
//  iTunesSearchApiDemo
//
//  Created by Gokhan Mutlu on 9.12.2021.
//

import Foundation
import Combine

class SearchListViewModel<S:Session>:ObservableObject{

	@Published var searchedItems = [SearchedItemViewModel]()
	@Published var wrapperTypes = [String]()
	@Published var pageCount:Int = 0 //total page count
	
	
	private var service:iTunesService<S>!
	private let maxItemCountPerPage = 25
	//use it when paging
	var itemsCached = [SearchedItemViewModel]()
	
	
	
	init(session:S){
		self.service = iTunesService(session: session)
	}

	//MARK: - functions
	
	/**
	 Search is used for development purpose
	 !!! Search does not handles isNewSearch and pageIndex parameters
	 */
	func search(term:String, isNewSearch:Bool = true, pageIndex:Int = 0){
		
		if isNewSearch{
			service.searchContentFor(term) { result in
				switch result{
					case .success(let items):
						var tmpItems = items.map{ SearchedItemViewModel(searchItem: $0)}
						
						//clear and set cache
						self.itemsCached.removeAll()
						self.itemsCached = tmpItems
						
						
						//PAGING HERE
						let remainder = tmpItems.count % self.maxItemCountPerPage
						let tmpPageCount:Int = Int(tmpItems.count / self.maxItemCountPerPage) + (remainder == 0 ? 0 : 1)
						tmpItems = self.take25Items(ofIndex: pageIndex)
						
						//group by wrapperType
						var tmpWrapperTypes = Set<String>()
						for item in tmpItems{
							tmpWrapperTypes.insert(item.wrapperType)
						}
						
						//UI state is changing
						DispatchQueue.main.async {
							self.searchedItems = tmpItems
							self.wrapperTypes = Array(tmpWrapperTypes)
							self.pageCount = tmpPageCount
						}
						
					case .failure(let err):
						print(err)
				}
			}
		}else{
			//PAGING
			let tmpItems = self.take25Items(ofIndex: pageIndex)

			//group by wrapperType
			var tmpWrapperTypes = Set<String>()
			for item in tmpItems{
				tmpWrapperTypes.insert(item.wrapperType)
			}

			self.searchedItems = tmpItems
			self.wrapperTypes = Array(tmpWrapperTypes)
		}
	}

	
	private func take25Items(ofIndex pageIndex:Int) -> [SearchedItemViewModel]{
		let startIndex = pageIndex * 25
		var lastIndex = startIndex+25
		if lastIndex > itemsCached.count{
			lastIndex = itemsCached.count
		}
		
		var items = [SearchedItemViewModel]()
		for i in (startIndex..<lastIndex){
			items.append(itemsCached[i])
		}
		return items
	}
}
