//
//  DetailViewController.swift
//  L6Starter
//
//  Created by Sam Friedman on 10/24/22.
//

import UIKit

import youtube_ios_player_helper

import AVFoundation


class DetailViewController: UIViewController {

    let albumImageView = UIImageView()
    let songTitle = UITextField()
    let artistLabel = UITextField()
    let playButton = UIButton()
    let changeSongName = UILabel()
    let changeArtist = UILabel()
    
    let submitButton = UIButton()
    
    
    
    @IBOutlet var playerView: YTPlayerView!
    
    

    let song: Song
    weak var delegate: ChangeSongDelegate?
    init(song: Song, delegate:ChangeSongDelegate) {
        self.song = song
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Edit Song"

        albumImageView.image = UIImage(named:"logo")
        albumImageView.translatesAutoresizingMaskIntoConstraints = false
        
        albumImageView.layer.cornerRadius = 20
        albumImageView.clipsToBounds = true
        
        view.addSubview(albumImageView)

        songTitle.text = song.title
        songTitle.font = .systemFont(ofSize: 20)
        songTitle.backgroundColor = .systemGray5
        songTitle.layer.cornerRadius = 5
        songTitle.clipsToBounds = true
        songTitle.textAlignment = .center
        songTitle.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(songTitle)
        
        artistLabel.text = song.artist
        artistLabel.font = .systemFont(ofSize: 20)
        artistLabel.backgroundColor = .systemGray5
        artistLabel.layer.cornerRadius = 5
        artistLabel.clipsToBounds = true
        artistLabel.textAlignment = .center
        artistLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(artistLabel)
        
        changeSongName.text = "Song Title:"
        changeSongName.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(changeSongName)
        
        changeArtist.text = "Artist:"
        changeArtist.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(changeArtist)
                
        
        submitButton.setTitle("   Submit   ", for: .normal)
        submitButton.backgroundColor = .systemPink
        submitButton.setTitleColor(.white, for: .normal)
        submitButton.layer.cornerRadius = 10
        submitButton.addTarget(self, action: #selector(changeSongCell), for: .touchUpInside)
        
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(submitButton)

        playButton.setTitle("    Play    ", for: .normal)
        playButton.backgroundColor = .systemPink
        playButton.setTitleColor(.white, for: .normal)
        playButton.titleLabel?.font = .systemFont(ofSize: 30, weight: .bold)
        playButton.layer.cornerRadius = 8
        playButton.addTarget(self, action: #selector(playSong), for: .touchUpInside)
        playButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(playButton)

        
        
//        playerView.delegate = self
//        playerView.load(withVideoId: "YE7VzlLtp-4", playerVars: ["playsinline": "1"])
//
//        // If you want to change the video after you loaded the first one, use the following code
////        playerView.cueVideo(byId: "DQuhA5ZCV9M", startSeconds: 0)
//
//        playerView.webView?.backgroundColor = .black
//        playerView.webView?.isOpaque = false
        
        
        
        setupConstraints()
    }

    

    // based on https://stackoverflow.com/questions/32036146/how-to-play-a-sound-using-swift
    var player: AVAudioPlayer?
    
    @objc func playSong() {
        
        print("Trying to play the song")
        
        guard let url = Bundle.main.url(forResource: "taylorsbestsong", withExtension: "mp3") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)


            guard let player = player else {
                return
            }

            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }
        
    
    @objc func changeSongCell() {
        delegate?.changeSongName(name: songTitle.text!, artist: artistLabel.text!)
        song.title = songTitle.text!
        song.artist = artistLabel.text!
        dismiss(animated:true)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            albumImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            albumImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            albumImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            albumImageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9)
        ])

        NSLayoutConstraint.activate([
            changeSongName.topAnchor.constraint(equalTo: albumImageView.bottomAnchor, constant: 10),
            changeSongName.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            songTitle.topAnchor.constraint(equalTo: changeSongName.bottomAnchor, constant: 10),
            songTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            songTitle.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.67),
        ])
        
        NSLayoutConstraint.activate([
            changeArtist.topAnchor.constraint(equalTo: songTitle.bottomAnchor, constant: 20),
            changeArtist.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            artistLabel.topAnchor.constraint(equalTo: changeArtist.bottomAnchor, constant: 10),
            artistLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            artistLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.67),
        ])
        
        NSLayoutConstraint.activate([
            submitButton.topAnchor.constraint(equalTo: artistLabel.bottomAnchor, constant: 30),
            submitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])

        NSLayoutConstraint.activate([
            playButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            playButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

protocol ChangeSongDelegate: UITableViewCell{
    func changeSongName(name:String, artist:String)
}

extension DetailViewController: YTPlayerViewDelegate {
    func playerViewPreferredWebViewBackgroundColor(_ playerView: YTPlayerView) -> UIColor {
        return UIColor.black
    }
}
