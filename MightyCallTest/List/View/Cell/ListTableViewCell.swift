//
//  ListTableViewCell.swift
//  MightyCallTest
//
//  Created by Анна Сычева on 13.10.2020.
//  Copyright © 2020 Анна Сычева. All rights reserved.
//

import UIKit

final class ListTableViewCell: UITableViewCell {
    
    // MARK: - Private properties
    
    private let callImage = UIImageView()
    private let durationLabel = UILabel()
    
    private let timeLabel = UILabel()
    
    private let numberStackView = UIStackView()
    private let nameLabel = UILabel()
    private let numberLabel = UILabel()
    
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupVies()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    
    func set() {
        callImage.image = UIImage(named: "call missed")
        durationLabel.text = "00:13"
        timeLabel.text = "10:21 AM"
        nameLabel.text = "Eberhard K. Shouenuenburg"
        numberLabel.text = "+1 800 123-4567"
    }
}

// MARK: - Setup

private extension ListTableViewCell {
    
    func setupVies() {
        addVies()
        settingContentView()
        setupDurationLabel()
        setupCallImageView()
        setupTimeLabel()
        setupNumberStackView()
        
        layout()
    }
}

//MARK: - Setup Elements

private extension ListTableViewCell {
    
    func addVies() {
        contentView.addSubview(callImage)
        contentView.addSubview(durationLabel)
        contentView.addSubview(timeLabel)
        contentView.addSubview(numberStackView)
    }
    
    func settingContentView() {
        backgroundColor = .clear
        contentView.layer.masksToBounds = false
        contentView.layer.shadowOpacity = 1
        contentView.layer.shadowRadius = 8
        contentView.layer.shadowOffset = CGSize(width: 0, height: 0)
        contentView.layer.shadowColor = CGColor(srgbRed: 0, green: 0, blue: 0, alpha: 0.1)
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 8
    }
    
    func setupDurationLabel() {
        durationLabel.font = UIFont.italicSystemFont(ofSize: 13)
        durationLabel.textColor = UIColor(red: 96/255.0, green: 96/255.0, blue: 96/255.0, alpha: 1)
        durationLabel.textAlignment = .center
    }
    
    func setupCallImageView() {
        callImage.contentMode = .scaleAspectFill
    }
    
    func setupTimeLabel() {
        createLabel(namelabel: timeLabel,
                    ofSize: 13,
                    weight: .regular,
                    textAlignment: .center,
                    textcolor: Colors.grayNine)
    }
    
    func setupNumberStackView() {
        numberStackView.axis = .vertical
        numberStackView.distribution = .fillProportionally
        numberStackView.alignment = .fill
        numberStackView.spacing = 5
        addLabelOnStackView()
    }
    
    func addLabelOnStackView() {
        
        createLabel(namelabel: nameLabel,
                    ofSize: 17,
                    weight: .bold,
                    textAlignment: .left,
                    textcolor: Colors.grayFive)
        createLabel(namelabel: numberLabel,
                    ofSize: 17,
                    weight: .regular,
                    textAlignment: .left,
                    textcolor: Colors.grayFive)
        
        numberStackView.addArrangedSubview(nameLabel)
        numberStackView.addArrangedSubview(numberLabel)
    }
    
    func createLabel(namelabel: UILabel,
                     ofSize: CGFloat,
                     weight: UIFont.Weight,
                     textAlignment: NSTextAlignment,
                     textcolor: UIColor) {
        namelabel.font = UIFont.systemFont(ofSize: ofSize, weight: weight)
        namelabel.textAlignment = textAlignment
        namelabel.textColor = textcolor
    }
}

//MARK: - Layout

private extension ListTableViewCell {
    
    func layout() {
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(
                equalTo: topAnchor,
                constant: Constants.fifteenAnchor),
            contentView.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: Constants.sixteenAnchor),
            contentView.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -Constants.sixteenAnchor),
            contentView.bottomAnchor.constraint(
                equalTo: bottomAnchor,
                constant: -Constants.fifteenAnchor)])
        
        callImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            callImage.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: Constants.sixteenAnchor),
            callImage.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: Constants.callImageLeadingAnchor),
            callImage.widthAnchor.constraint(
                equalToConstant: Constants.fortyAnchor),
            callImage.heightAnchor.constraint(
                equalToConstant: Constants.fortyAnchor)])
        
        durationLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            durationLabel.topAnchor.constraint(
                equalTo: callImage.bottomAnchor,
                constant: Constants.fortyAnchor),
            durationLabel.leadingAnchor.constraint(
                equalTo: callImage.leadingAnchor),
            durationLabel.heightAnchor.constraint(
                equalToConstant: Constants.sixteenAnchor),
            durationLabel.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -Constants.sixteenAnchor)])
        
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            timeLabel.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -Constants.sixteenAnchor),
            timeLabel.heightAnchor.constraint(
                equalToConstant: Constants.sixteenAnchor),
            timeLabel.widthAnchor.constraint(
                equalToConstant: Constants.timeLabelWidthAnchor),
            timeLabel.bottomAnchor.constraint(
                equalTo: durationLabel.bottomAnchor)])
        
        numberStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            numberStackView.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: Constants.sixteenAnchor),
            numberStackView.leadingAnchor.constraint(
                equalTo: callImage.trailingAnchor,
                constant: Constants.numberStackViewLeadingAnchor),
            numberStackView.trailingAnchor.constraint(
                equalTo: timeLabel.leadingAnchor,
                constant: Constants.numberStackViewTrailingAnchor),
            numberStackView.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: Constants.numberStackViewBottomAnchor)])
    }
}

// MARK: - Constants

private extension ListTableViewCell {
    
    enum Constants {
        static let numberStackViewBottomAnchor: CGFloat = -32
        static let sixteenAnchor: CGFloat = 16
        static let fifteenAnchor: CGFloat = 15
        static let callImageLeadingAnchor: CGFloat = 17
        static let fortyAnchor: CGFloat = 40
        static let timeLabelWidthAnchor: CGFloat = 60
        static let numberStackViewLeadingAnchor: CGFloat = 20
        static let numberStackViewTrailingAnchor: CGFloat = -6
    }
    
}
