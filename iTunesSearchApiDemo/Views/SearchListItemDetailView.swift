//
//  SearchListItemDetailView.swift
//  iTunesSearchApiDemo
//
//  Created by Gokhan Mutlu on 10.12.2021.
//

import SwiftUI

struct SearchListItemDetailView: View {
	var item:SearchedItemViewModel
	
    var body: some View {
		
		VStack(spacing: 10) {
			
			if
				let urlString = item.artworkUrl60,
				let url = URL(string: urlString){
				
				AsyncImage(url: url) { phase in
					switch phase {
						case .empty:
							ProgressView()
						case .success(let image):
							image.resizable()
								.aspectRatio(contentMode: .fit)
								.frame(maxWidth: 160, maxHeight: 160)
						case .failure:
							Image(systemName: "photo")
						@unknown default:
							EmptyView()
					}
				}
			}else{
				Image(uiImage:UIImage(systemName: "photo")!)
			}
			
			
			if item.trackName != nil {
				Text(item.trackName!)
					.font(Font.title2)
					.bold()
			}
			
			if item.kind != nil {
				Text("\(item.kind!) by")
					.font(Font.title3)
					.padding(10)
			}

			Text(item.artistName)
				.font(Font.title2)
				.italic()
				.padding(.bottom, 40)
			
			Text("Collection Price:")
			Text("\(getPrice(item.collectionPrice)) \(item.currency)")
				.font(.body)
				.italic()
				.padding(.bottom, 20)
			
			Text("Track Price:")
			Text("\(getPrice(item.trackPrice)) \(item.currency)")
				.font(.body)
				.italic()
				.padding(.bottom, 20)


	 		Spacer()
		}
	}
	
	
	func getPrice(_ price:Double?) -> String{
		guard let price = price else { return "-" }
		return String(format: "%0.2f", price)
	}
	
}


struct SearchListItemDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SearchListItemDetailView(item:SearchedItemViewModel.placeholder)
    }
}
