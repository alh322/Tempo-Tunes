//
//  ContactTableViewCell.swift
//  L6Starter
//
//  Created by Sam Friedman on 10/24/22.
//

import UIKit

class SongTableViewCell: UITableViewCell{
    
    let songImageView = UIImageView()
    let songLabel = UILabel()
    let artistLabel = UILabel()
    let BPMLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier:String?){
        super.init(style:style, reuseIdentifier:reuseIdentifier)
        
        self.backgroundColor = UIColor.clear
        self.isOpaque = false
        
        songImageView.translatesAutoresizingMaskIntoConstraints = false
        songImageView.layer.cornerRadius = 10
        songImageView.clipsToBounds = true
        contentView.addSubview(songImageView)
        
        songLabel.font = .systemFont(ofSize: 20, weight: .bold)
        songLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(songLabel)
        
        artistLabel.font = .systemFont(ofSize: 18)
        artistLabel.textColor = .darkGray
        artistLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(artistLabel)
        
        BPMLabel.font = .systemFont(ofSize: 18)
        BPMLabel.textColor = .darkGray
        BPMLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(BPMLabel)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(song: Song){
        songImageView.image = UIImage(named:"logo")
        songLabel.text = song.title
        artistLabel.text = song.artist
        BPMLabel.text = String(song.bpm) + " BPM"
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            songImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            songImageView.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.33),
            songImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.33),
            songImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            songImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
            ])
        
        NSLayoutConstraint.activate([
            songLabel.leadingAnchor.constraint(equalTo: songImageView.trailingAnchor,constant:10),
            songLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -30)
        ])
        
        NSLayoutConstraint.activate([
            artistLabel.leadingAnchor.constraint(equalTo: songImageView.trailingAnchor,constant:10),
            artistLabel.topAnchor.constraint(equalTo: songLabel.bottomAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            BPMLabel.leadingAnchor.constraint(equalTo: songImageView.trailingAnchor,constant:10),
            BPMLabel.topAnchor.constraint(equalTo: artistLabel.bottomAnchor, constant: 10)
        ])
        
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

extension SongTableViewCell: ChangeSongDelegate{
    func changeSongName(name: String, artist: String) {
        songLabel.text = name
        artistLabel.text = artist
    }
    
}
