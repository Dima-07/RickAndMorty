//
//  CharacterCell.swift
//  RickAndMorty
//
//  Created by Дима Кондратенко on 06.01.2026.
//

import UIKit

final class CharacterCell: UITableViewCell {

    static let identifier = "CharacterCell"
    private var currentImageUrl: String?
    
    // MARK: - UI Elements
    
    private let characterImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 30
        image.clipsToBounds = true
        image.backgroundColor = .systemGray5
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupHierarchy()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func setupHierarchy() {
        contentView.addSubview(characterImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(statusLabel)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            characterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            characterImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            characterImageView.heightAnchor.constraint(equalToConstant: 60),
            characterImageView.widthAnchor.constraint(equalToConstant: 60),
            
            nameLabel.leadingAnchor.constraint(equalTo: characterImageView.trailingAnchor, constant: 16),
            nameLabel.topAnchor.constraint(equalTo: characterImageView.topAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            statusLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            statusLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            statusLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: 80)
        ])
    }
    
    // MARK: - Reuse
    
    override func prepareForReuse() {
        super.prepareForReuse()
        characterImageView.image = nil
        nameLabel.text = nil
        statusLabel.text = nil
        currentImageUrl = nil
    }
    
    // MARK: - Configuration
    
    func configure(with character: Character) {
        nameLabel.text = character.name
        statusLabel.text = character.status
        
        switch character.status {
        case "Alive": statusLabel.textColor = .systemGreen
        case "Dead": statusLabel.textColor = .systemRed
        default: statusLabel.textColor = .secondaryLabel
        }
        
        currentImageUrl = character.image
        
        Task {
            let image = await NetworkManager.shared.fetchImage(from: character.image)
                    
            if self.currentImageUrl == character.image {
                await MainActor.run {
                    self.characterImageView.image = image
                }
            }
        }
    }
}
