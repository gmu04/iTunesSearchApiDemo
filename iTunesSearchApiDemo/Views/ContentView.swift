//
//  ContentView.swift
//  iTunesSearchApiDemo
//
//  Created by Gokhan Mutlu on 8.12.2021.
//

import SwiftUI


struct ContentView: View {
	
	@State private var term: String = ""	//"jumanji"	//jack johnson"
	@State private var previousTerm:String = ""
	@State private var currentPageIndex = -1
	
	@ObservedObject var searchListVM = SearchListViewModel(session: URLSession.shared)
	
	//#warning("DEV")
	//@ObservedObject var searchListVM = SearchListViewModel(session: iTunesSearchApiOfflineSession())

	
	init(){
		
	}
	
	
    var body: some View {
		NavigationView{
			VStack {
				HStack {
					TextField(text: $term) {
						Text("Search")
							.padding(10)
					}
					.disableAutocorrection(true)
					.padding()
					.border(.secondary)
					
					
					Button {
						/*
						 iTunesSearchApi(session: URLSession.shared)
							 .searchContentFor(term) { result in
								 switch result{
									 case .success(let items): print(items)
									 case .failure(let err): print(err)
								 }
						 }
						 */
						
						//new search
						let tmpTerm = term.trimmingCharacters(in: .whitespaces)
						let isTermNotEmptyNotEqualToPreviousTerm = (tmpTerm != "" && tmpTerm != previousTerm)

						if isTermNotEmptyNotEqualToPreviousTerm{
							currentPageIndex = 0
							previousTerm = tmpTerm
							searchListVM.search(term: tmpTerm)
						}
					} label: {
						Text("Search")
							.padding()
							.foregroundColor(.white)
					}
					.background(Color.blue)
				}
				.padding()
				
				SearchListView(
					searchedItemVM: $searchListVM.searchedItems,
					wrapperTypes: $searchListVM.wrapperTypes
				)
				
				
				
				
				//MARK: - Paging buttons
				
				
				HStack {
					Button {
						if currentPageIndex > 0{
							currentPageIndex -= 1
							searchListVM.search(term: term,
												isNewSearch: false,
												pageIndex:currentPageIndex
							)
						}
						
					} label: {
						Image(systemName: "chevron.left")
						//Text("Previous")
							.padding(5)
							.foregroundColor(.white)
					}
					.frame(width: 70, height: 40)
					.background(Color.gray)
					
					HStack {
						Text("Page:")
						Text("\(currentPageIndex < 0 ? 0 : currentPageIndex+1) of \(searchListVM.pageCount)")
							.font(.title)
					}
					.padding(.horizontal, 20)
					
					
					Button {
						if currentPageIndex < searchListVM.pageCount-1{
							currentPageIndex += 1
							searchListVM.search(term: term,
												isNewSearch: false,
												pageIndex:currentPageIndex
							)
						}
					} label: {
						Image(systemName: "chevron.right")
						//Text("Next")
							.padding(5)
							.foregroundColor(.white)
					}
					.frame(width: 70, height: 40)
					.background(Color.gray)
				}
				.padding(5)
			}
			.navigationTitle("iTunes Search Demo")
			.navigationBarTitleDisplayMode(.inline)
		}
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
