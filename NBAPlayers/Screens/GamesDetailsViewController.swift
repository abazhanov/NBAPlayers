 //
//  GamesDetailsViewController.swift
//  NBAPlayers
//
//  Created by Artem Bazhanov on 10.11.2020.
//

import UIKit

class GamesDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var reloadButton: UIButton!
    
    var games: [Game] = []
    let apiClient: ApiClient = ApiClientImpl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        reloadButton.isHidden = true
        reloadData()
    
    }
    
    func showLoading() {
        activityIndicatorView.startAnimating()
        errorLabel.isHidden = true
        //reloadButton.isHidden = true
        reloadButton.isHidden = true
    }

    func showData() {
        activityIndicatorView.stopAnimating()
        errorLabel.isHidden = true
        reloadButton.isHidden = true
    }

    func showError() {
        activityIndicatorView.stopAnimating()
        errorLabel.isHidden = false
        reloadButton.isHidden = false
    }
    
    func reloadData() {
        showLoading()
        apiClient.getGames(onResult: { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let games):
                    self.games = games
                    self.tableView.reloadData()
                    self.showData()
                    print("success")
                case .failure:
                    self.games = []
                    self.tableView.reloadData()
                    self.showError()
                    print("failure")
                }
            }
        })
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print("games.count: \(games.count)")
        return games.count
    }

    func tableView(_ tableViews: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViews.dequeueReusableCell(withIdentifier: "GameCell", for: indexPath)

        let game = games[indexPath.row]

        cell.textLabel?.text = String(game.vScore)
        //cell.detailTextLabel?.text = player.team.fullName

        return cell
    }

//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let storyboard = UIStoryboard(name: "Main", bundle: .main)
//        let playersDetailViewController = storyboard.instantiateViewController(identifier: "PlayerDetailsViewController") as! PlayerDetailsViewController
//
//        let player = players[indexPath.row]
//
//        playersDetailViewController.player = player
//        navigationController?.pushViewController(playersDetailViewController, animated: true)
//    }




}
