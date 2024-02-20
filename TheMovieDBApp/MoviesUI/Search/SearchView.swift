//
//  SearchView.swift
//  TheMovieDbApp
//
//  Created by Aymen Bokri on 15/02/2024.
//

import Foundation
import SwiftUI
import SwiftData
import TmdbCore

struct SearchView: View {
    
    // MARK: - Properties
    
    @State private var presenter: SearchPresenter
    @Binding var isPresented: Bool
    
    // MARK: - Constructors
    
    init(moviesService: MoviesServiceProtocol, isPresented: Binding<Bool>) {
        let presenter = SearchPresenter(moviesService: moviesService)
        self._presenter = State(initialValue: presenter)
        self._isPresented = isPresented
    }
    
    // MARK: - SwiftUI
    
    var body: some View {
        NavigationStack {
            Group {
                searchList
            }
            .searchable(text: $presenter.searchText, isPresented: $presenter.searchIsActive)
            .navigationTitle(String(localized: "searchTabTitle"))
                .toolbar {
                    Button(String(localized: "btn.close")) {
                        isPresented = false
                    }
                }
        }
        .onSubmit(of: .search) {
            Task {
                await presenter.searchMovies()
            }
        }
    }
    
    var searchList: some View {
        List {
            ForEach(presenter.searchMovies) { item in
                NavigationLink {
                    MovieDetailView(movie: item, moviesService: presenter.moviesService)
                } label: {
                    MovieCell(movie: item)
                }
            }
        }
    }
}
