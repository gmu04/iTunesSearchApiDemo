//
//  SearchListView.swift
//  iTunesSearchApiDemo
//
//  Created by Gokhan Mutlu on 9.12.2021.
//

import SwiftUI

struct SearchListView: View {
	
	@Binding var searchedItemVM:[SearchedItemViewModel]
	@Binding var wrapperTypes:[String]
		
    var body: some View {
			VStack {
				/*
				List($searchedItemVM, id: \.id) { item in
					NavigationLink {
						Text("Detail view")
					} label: {
						SearchListItemView(item:item)
					}
				}*/
				
				List{
					ForEach(wrapperTypes, id:\.self){ key in
						
						Section(content: {
							
							let tmpItems = searchedItemVM.filter{ $0.wrapperType == key }
							
							ForEach(tmpItems, id:\.id){ item in
								NavigationLink {
									//Text("Detail view")
									SearchListItemDetailView(item:item)
									
								} label: {
									SearchListItemView(item:item)
								}
							}
						 	
							
						}, header: {
							Text(key).font(.title)
						})
						
					}
				}
				//.listStyle(.grouped)
			}
    }
	
	
}

struct SearchListView_Previews: PreviewProvider {
	static var previews: some View {
		SearchListView(searchedItemVM: .constant([
				SearchedItemViewModel.placeholder,
				SearchedItemViewModel.placeholder
		]), wrapperTypes:.constant(["track"])
		)
    }
}


