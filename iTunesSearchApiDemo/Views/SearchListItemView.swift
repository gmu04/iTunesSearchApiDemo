//
//  SearchListItemView.swift
//  iTunesSearchApiDemo
//
//  Created by Gokhan Mutlu on 9.12.2021.
//

import SwiftUI

struct SearchListItemView: View {
	
	var item:SearchedItemViewModel
	
	var body: some View {
		HStack(spacing: 10) {
			
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
							.frame(maxWidth: 60, maxHeight: 60)
						case .failure:
							Image(systemName: "photo")
						@unknown default:
							EmptyView()
					}
				}
			}else{
				Image(uiImage:UIImage(systemName: "photo")!)
			}
				
			
			VStack(alignment: .leading, spacing: 10) {
				Text(item.trackName ?? "track name")
					.font(Font.caption)
					.bold()
				Text("\(item.kind ?? "-") by \(item.artistName)")
					.font(Font.caption2)
					.italic()
			}
		}
	}
	
}

struct SearchListItemView_Previews: PreviewProvider {
    static var previews: some View {
		SearchListItemView(item:SearchedItemViewModel.placeholder)
    }
}
