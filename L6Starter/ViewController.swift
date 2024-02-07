//
//  ViewController.swift
//  L6Starter
//
//  Created by Sam Friedman on 10/24/22.
//

import UIKit

class ViewController: UIViewController {

    var songs: [Song] = []
    let songTableView = UITableView()
    let reuseIdentifier = "songReuseIdentifier"

    override func viewDidLoad() {
        super.viewDidLoad()

        var BkImageView: UIImageView!

        BkImageView = UIImageView(frame: view.bounds)
        BkImageView.contentMode = .scaleAspectFill
        BkImageView.clipsToBounds = true
        BkImageView.image = UIImage(named: "gradient")
        BkImageView.center = view.center
        view.addSubview(BkImageView)
        self.view.sendSubviewToBack(BkImageView)
        
        title = "Tempo Tunes"
        // view.backgroundColor = UIColor(patternImage: UIImage(named: "gradient.png")!)
        // view.backgroundColor = .white

        let s1 = Song(id: 1, title: "Lavender Haze", artist: "Taylor Swift", bpm: 100, link: "www.example.com")
        let s2 = Song(id: 1, title: "Maroon", artist: "Taylor Swift", bpm: 100, link: "www.example.com")

//        let s3 = Song(picName: "midnights", name: "Anti-Hero", artist: "Taylor Swift", BPM: 100, URL: "www.example.com")
//        let s4 = Song(picName: "midnights", name: "Snow on the Beach", artist: "Taylor Swift, Lana Del Rey", BPM: 100, URL: "www.example.com")
//        let s5 = Song(picName: "midnights", name: "You're on Your Own, Kid", artist: "Taylor Swift", BPM: 100, URL: "www.example.com")
//        let s6 = Song(picName: "midnights", name: "Midnight Rain", artist: "Taylor Swift", BPM: 100, URL: "www.example.com")
//        let s7 = Song(picName: "midnights", name: "Question...?", artist: "Taylor Swift", BPM: 100, URL: "www.example.com")
//        let s8 = Song(picName: "midnights", name: "Vigilante Shit", artist: "Taylor Swift", BPM: 100, URL: "www.example.com")
//        let s9 = Song(picName: "midnights", name: "Bejeweled", artist: "Taylor Swift", BPM: 100, URL: "www.example.com")
//        let s10 = Song(picName: "midnights", name: "Labyrinth", artist: "Taylor Swift", BPM: 100, URL: "www.example.com")
//        let s11 = Song(picName: "midnights", name: "Karma", artist: "Taylor Swift", BPM: 100, URL: "www.example.com")
//        let s12 = Song(picName: "midnights", name: "Sweet Nothing", artist: "Taylor Swift", BPM: 100, URL: "www.example.com")
//        let s13 = Song(picName: "midnights", name: "Mastermind", artist: "Taylor Swift", BPM: 100, URL: "www.example.com")
        //songs = [s1, s2]
                
        NetworkingMananger.getAllSongs { response in
            print("Songs decoded:", response)
            self.songs = response.songs
            self.songTableView.reloadData()
        }

        songTableView.translatesAutoresizingMaskIntoConstraints = false
        songTableView.dataSource = self
        songTableView.delegate = self
        songTableView.backgroundColor = .clear
        
        //songTableView.tableFooterView = UIView()
        //songTableView.backgroundColor = .systemGray2
        songTableView.register(SongTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        view.addSubview(songTableView)

        setupConstraints()
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            songTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            songTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            songTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            songTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
    }
}

extension ViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = songTableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? SongTableViewCell {
            cell.configure(song:songs[indexPath.row])
            return cell
        }
        else{
            return UITableViewCell()
        }
    }
}

extension ViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = songTableView.cellForRow(at: indexPath) as! SongTableViewCell
        present(DetailViewController(song:songs[indexPath.row], delegate:cell), animated: true)
    }
}
