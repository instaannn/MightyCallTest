//
//  DetailViewController.swift
//  MightyCallTest
//
//  Created by Анна Сычева on 13.10.2020.
//  Copyright © 2020 Анна Сычева. All rights reserved.
//

import UIKit

// MARK: - DetailViewController

final class DetailViewController: UIViewController {
    
    // MARK: - Private properties
    
    private var viewModel: IDetailViewModel? {
        didSet {
            self.viewModel?.detailDidChange = { [weak self] viewModel in
                
                guard let self = self else { return }
                
                self.numberLabel.text = viewModel.client.address
                self.durationLabel.text = viewModel.duration
                self.nameLabel.text = viewModel.client.name
                self.businessCardLabel.text = viewModel.businessNumber.label
                self.businessCardNumber.text = viewModel.businessNumber.number
            }
        }
    }
    
    private lazy var shadowView = UIView()
    private lazy var mainView = UIView()
    
    private lazy var shadowCallImage = UIView()
    private lazy var callImageView = UIImageView()
    
    private lazy var durationLabel = UILabel()
    
    private lazy var numberStackView = UIStackView()
    private lazy var nameLabel = UILabel()
    private lazy var numberLabel = UILabel()
    
    private lazy var businessCardStackView = UIStackView()
    private lazy var businessCardName = UILabel()
    private lazy var businessCardLabel = UILabel()
    private lazy var businessCardNumber = UILabel()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        viewModel = DetailViewModel()
        super.viewDidLoad()
        
        setupVies()
        setupBinding()
        navigationItem.title = "Page"
    }
}

// MARK: - Setup

private extension DetailViewController {
    
    func setupVies() {
        addVies()
        
        DispatchQueue.main.async {
            self.setupView()
            self.setupShadowView()
            self.setupCallImage()
            self.setupDurationLabel()
            self.setupNumberStackView()
            self.setupBusinessCardStackView()
        }
        
        setupBackgroundView()
        layout()
    }
    
    func setupBinding() {
        viewModel?.fetchMainData()
    }
}

// MARK: - Setup Elements

private extension DetailViewController {
    
    func addVies() {
        view.addSubview(shadowView)
        view.addSubview(mainView)
        mainView.addSubview(shadowCallImage)
        shadowCallImage.addSubview(callImageView)
        mainView.addSubview(durationLabel)
        mainView.addSubview(numberStackView)
        mainView.addSubview(businessCardStackView)
    }
    
    func setupBackgroundView() {
        shadowView.layer.masksToBounds = false
        shadowView.layer.shadowOpacity = 1
        shadowView.layer.shadowRadius = 8
        shadowView.layer.shadowOffset = CGSize(width: 0, height: 0)
        shadowView.layer.shadowColor = CGColor(srgbRed: 0, green: 0, blue: 0, alpha: 0.1)
        shadowView.backgroundColor = .white
        shadowView.layer.cornerRadius = 8
    }
    
    func setupView() {
        mainView.backgroundColor = .white
        let path = UIBezierPath(roundedRect: mainView.bounds,
                                byRoundingCorners:[.bottomRight, .bottomLeft],
                                cornerRadii: CGSize(width: 8,
                                                    height: 8))
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        mainView.layer.mask = maskLayer
    }
    
    func setupShadowView() {
        shadowCallImage.layer.cornerRadius = shadowCallImage.frame.width / 2
        shadowCallImage.layer.shadowColor = CGColor(srgbRed: 0, green: 0, blue: 0, alpha: 0.1)
        shadowCallImage.layer.shadowOpacity = 1
        shadowCallImage.layer.shadowOffset = CGSize(width: 0,
                                                    height: 0)
        shadowCallImage.layer.shadowRadius = 8
    }
    
    func setupCallImage() {
        callImageView.image = UIImage(named: "call missed")
        callImageView.backgroundColor = .white
        callImageView.layer.cornerRadius = callImageView.frame.width / 2
        callImageView.contentMode = .center
        callImageView.layer.masksToBounds = true
    }
    
    func setupDurationLabel() {
        createLabel(namelabel: durationLabel,
                    ofSize: 13,
                    weight: .regular,
                    textAlignment: .center,
                    textcolor: Colors.grayNine)
    }
    
    func setupNumberStackView() {
        numberStackView.axis = .vertical
        numberStackView.distribution = .fillProportionally
        numberStackView.spacing = 7
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
    
    func setupBusinessCardStackView() {
        businessCardStackView.axis = .vertical
        businessCardStackView.distribution = .fillProportionally
        businessCardStackView.spacing = 7
        addLabelOnBusinessStackView()
    }
    
    func addLabelOnBusinessStackView() {
        createLabel(namelabel: businessCardName,
                    ofSize: 13,
                    weight: .regular,
                    textAlignment: .left,
                    textcolor: Colors.grayLight)
        businessCardName.text = "Business number"
        
        createLabel(namelabel: businessCardLabel,
                    ofSize: 17,
                    weight: .bold,
                    textAlignment: .left,
                    textcolor: Colors.grayFive)
        
        createLabel(namelabel: businessCardNumber,
                    ofSize: 14,
                    weight: .regular,
                    textAlignment: .left,
                    textcolor: Colors.grayNine)

        businessCardStackView.addArrangedSubview(businessCardName)
        businessCardStackView.addArrangedSubview(businessCardLabel)
        businessCardStackView.addArrangedSubview(businessCardNumber)
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

// MARK: - Layout

private extension DetailViewController {
    
    func layout() {
        
        shadowView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            shadowView.topAnchor.constraint(
                equalTo: view.topAnchor),
            shadowView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor),
            shadowView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor),
            shadowView.bottomAnchor.constraint(
                equalTo: mainView.bottomAnchor)])
        
        mainView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor),
            mainView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor),
            mainView.heightAnchor.constraint(
                equalToConstant: 202)])
        
        shadowCallImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            shadowCallImage.topAnchor.constraint(
                equalTo: mainView.topAnchor,
                constant: 16),
            shadowCallImage.leadingAnchor.constraint(
                equalTo: mainView.leadingAnchor,
                constant: 16),
            shadowCallImage.heightAnchor.constraint(
                equalToConstant: 56),
            shadowCallImage.widthAnchor.constraint(
                equalToConstant: 56)])
        
        callImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            callImageView.topAnchor.constraint(
                equalTo: shadowCallImage.topAnchor),
            callImageView.leadingAnchor.constraint(
                equalTo: shadowCallImage.leadingAnchor),
            callImageView.trailingAnchor.constraint(
                equalTo: shadowCallImage.trailingAnchor),
            callImageView.bottomAnchor.constraint(
                equalTo: shadowCallImage.bottomAnchor)])
        
        durationLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            durationLabel.topAnchor.constraint(
                equalTo: shadowCallImage.bottomAnchor,
                constant: 8),
            durationLabel.leadingAnchor.constraint(
                equalTo: shadowCallImage.leadingAnchor),
            durationLabel.heightAnchor.constraint(
                equalToConstant: 16)])
        
        numberStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            numberStackView.topAnchor.constraint(
                equalTo: mainView.topAnchor,
                constant: 16),
            numberStackView.leadingAnchor.constraint(
                equalTo: shadowCallImage.trailingAnchor,
                constant: 16),
            numberStackView.trailingAnchor.constraint(
                equalTo: mainView.trailingAnchor,
                constant: 16),
            numberStackView.heightAnchor.constraint(
                equalToConstant: 66)])
        
        businessCardStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            businessCardStackView.leadingAnchor.constraint(
                equalTo: numberStackView.leadingAnchor),
            businessCardStackView.trailingAnchor.constraint(
                equalTo: numberStackView.trailingAnchor),
            businessCardStackView.heightAnchor.constraint(
                equalToConstant: 66),
            businessCardStackView.topAnchor.constraint(
                equalTo: numberStackView.bottomAnchor,
                constant: 16)])
    }
    
}
