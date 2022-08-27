//
//  MovieManager.swift
//  WatchListPro
//
//  Created by Alexander Khazzam on 7/15/22.
//

import Foundation

protocol MovieManagerDelegate {
    func handleMovieData(movieManager: MovieManager, _ movieData: MovieDataModel)
    func handleError()
}

struct MovieAttributes {
    
    let key: String
    let value: String
    
}

struct MovieDataModel {
    
    let movieData: [String]
    let movieDataTitles: [String]
    let movieTitle: String
    
}

struct MovieModel: Decodable {
    
    let Title: String
    let Year: String
    let Rated: String
    let Released: String
    let Runtime: String
    let Genre: String
    let Director: String
    let Writer: String
    let Actors: String
    let Plot: String
    let Language: String
    let Country: String
    let Awards: String
    let imdbRating: String
    let BoxOffice: String
    
    var posterURL: String {
        return ""
    }

}

struct MovieManager {
    
    var delegate: MovieManagerDelegate?
    
    func fetchMovie(_ movieTitle: String) {
        let url = URL(string: "https://www.omdbapi.com/?&t=\(movieTitle.replacingOccurrences(of: " ", with: "%20"))&apiKey=\(K.apiKey)")
        
        if let safeUrl = url {
            URLSession(configuration: .default).dataTask(with: safeUrl) { data, response, error in
                if let safeData = data {
                    if let movieData = self.parseJSON(safeData) {
                        delegate?.handleMovieData(movieManager: self, movieData)
                        return
                    }
                }
                delegate?.handleError()
            }.resume()
        }
    }
    
    func parseJSON(_ movieData: Data) -> MovieDataModel? {
        if let safeMovieData = try? JSONDecoder().decode(MovieModel.self, from: movieData) {
            
            return MovieDataModel(
              movieData: [
                safeMovieData.Year,
                safeMovieData.Released,
                safeMovieData.Runtime,
                safeMovieData.Genre,
                safeMovieData.Director,
                safeMovieData.Writer,
                safeMovieData.Actors,
                safeMovieData.Plot,
                safeMovieData.Language,
                safeMovieData.Awards,
                safeMovieData.imdbRating,
                safeMovieData.BoxOffice
              ],
              
              movieDataTitles: [
                "Year",
                "Released",
                "Runtime",
                "Genre",
                "Director",
                "Writer",
                "Actors",
                "Plot",
                "Language",
                "Awards",
                "imdbRating",
                "BoxOffice"
              ],
              
              movieTitle: safeMovieData.Title
            )
        }

        return nil
    }
    
}
