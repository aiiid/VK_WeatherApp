//
//  WeatherCell.swift
//  VK_WeatherApp
//
//  Created by Ai Hawok on 22/07/2024.
//

import UIKit

class WeatherCell: UICollectionViewCell {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let selectionIndicator: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 2
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alpha = 0
        return view
    }()
    
    private var selectionIndicatorWidthConstraint: NSLayoutConstraint!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        contentView.addSubview(selectionIndicator)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            selectionIndicator.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            selectionIndicator.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            selectionIndicator.heightAnchor.constraint(equalToConstant: 2) // Slightly smaller height
        ])
        
        selectionIndicatorWidthConstraint = selectionIndicator.widthAnchor.constraint(equalToConstant: 0)
        selectionIndicatorWidthConstraint.isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isSelected: Bool {
        didSet {
            animateSelectionIndicator(isSelected)
        }
    }
    
    private func animateSelectionIndicator(_ isSelected: Bool) {
        selectionIndicatorWidthConstraint.isActive = false
        
        if isSelected {
            selectionIndicatorWidthConstraint = selectionIndicator.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.6)
        } else {
            selectionIndicatorWidthConstraint = selectionIndicator.widthAnchor.constraint(equalToConstant: 0)
        }
        
        selectionIndicatorWidthConstraint.isActive = true
        
        UIView.animate(withDuration: 0.3, animations: {
            self.selectionIndicator.alpha = isSelected ? 1.0 : 0.0
            self.layoutIfNeeded()
        })
    }
    
    func configure(with image: UIImage?) {
        imageView.image = image
    }
}
