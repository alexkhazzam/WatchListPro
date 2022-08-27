//
//  SearchViewController.swift
//  WatchListPro
//
//  Created by Alexander Khazzam on 7/14/22.
//

import UIKit

import Firebase

class SearchViewController: UIViewController {
    
    @IBOutlet weak var movieTableView: UITableView!
    @IBOutlet weak var movieNameTextField: UITextField!
    
    var movieManager = MovieManager()
    var movieData: [String] = []
    var movieDataModel: MovieDataModel?
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieTableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        
        movieTableView.dataSource = self
        movieManager.delegate = self
        movieNameTextField.delegate = self
    }
    
}

//MARK: - Delegate methods

extension SearchViewController: MovieManagerDelegate {
    
    func handleError() {
        DispatchQueue.main.async {
            let alert = UIAlert(title: "Error", message: "Oops! Movie not found.", actionTitle: "Try Again").createAlert()
            self.present(alert, animated: true, completion: nil)
            
            self.movieDataModel = nil
            self.movieTableView.reloadData()
        }
    }
    
    func handleMovieData(movieManager: MovieManager, _ movieDataModel: MovieDataModel) {
        DispatchQueue.main.async {
            self.movieDataModel = movieDataModel // does not affect UI; no need to put inside DispatchQueue block
            self.movieTableView.reloadData()
        }
    }

}

//MARK: - @IBActions

extension SearchViewController {
    
    @IBAction func backArrowPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func searchBtnPressed(_ sender: UIButton) {
        if movieNameTextField.text != "" {
            movieManager.fetchMovie(movieNameTextField.text!)
        }
    }
    
    @IBAction func addToWatchlistBtnPressed(_ sender: UIButton) {
        if let safeEmail = Auth.auth().currentUser?.email, let safeMovieData = movieDataModel {
            db.collection(safeEmail).addDocument(data: [K.Firestore.movieField: safeMovieData.movieTitle])
            { err in
                if let safeErr = err {
                    return print(safeErr.localizedDescription)
                }
                
                self.movieNameTextField.text = ""
                self.movieDataModel = nil
            }
        }
    }
}

//MARK: - UITextFieldDelegate

extension SearchViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return textField.text != ""
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        movieManager.fetchMovie(movieNameTextField.text!)
    }
    
}

extension SearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieDataModel?.movieData.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let safeMovieDataModel = movieDataModel!
        
        let currentMovieCell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MovieDetailCell
        
        currentMovieCell.detailLabel.text = safeMovieDataModel.movieData[indexPath.row]
        currentMovieCell.detailTitleLabel.text = safeMovieDataModel.movieDataTitles[indexPath.row]
        
        return currentMovieCell
    }
    
}
