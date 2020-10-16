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
//              self.nameLabel.text = viewModel.client.name
                self.businessCardLabel.text = viewModel.businessNumber.label
                self.businessCardNumber.text = viewModel.businessNumber.number
            }
        }
    }
    
    private lazy var shadowView = UIView()
    private lazy var cardView = UIView()
    
    private lazy var businessCardView = UIView()
    private lazy var handlerAreaView = UIView()
    var handle: CGFloat = 25
    
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
            self.setupBusinessCardView()
            self.setupCardView()
            self.setupShadowView()
            self.setupCallImage()
            self.setupDurationLabel()
            self.setupNumberStackView()
            self.setupHandlerArea()
            self.setupBusinessCardStackView()
        }
        addSwipe()
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
        
        view.addSubview(businessCardView)
        businessCardView.addSubview(handlerAreaView)
        businessCardView.addSubview(businessCardStackView)
        
        view.addSubview(cardView)
        cardView.addSubview(shadowCallImage)
        shadowCallImage.addSubview(callImageView)
        cardView.addSubview(durationLabel)
        cardView.addSubview(numberStackView)
    }
    
    func setupBackgroundView() {
        shadowView.layer.masksToBounds = false
        shadowView.layer.shadowOpacity = 1
        shadowView.layer.shadowRadius = 8
        shadowView.layer.shadowOffset = CGSize(width: 0, height: 0)
        shadowView.layer.shadowColor = CGColor(srgbRed: 0, green: 0, blue: 0, alpha: 0.2)
        shadowView.backgroundColor = .white
        shadowView.layer.cornerRadius = 8
    }
    
    func setupCardView() {
        cardView.backgroundColor = .white
    }
    
    func setupBusinessCardView() {
        businessCardView.backgroundColor = .white
        let path = UIBezierPath(roundedRect: businessCardView.bounds,
                                byRoundingCorners:[.bottomRight, .bottomLeft],
                                cornerRadii: CGSize(width: 8,
                                                    height: 8))
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        businessCardView.layer.mask = maskLayer
    }
    
    func setupHandlerArea() {
        handlerAreaView.backgroundColor = .systemGray3
        handlerAreaView.layer.cornerRadius = handlerAreaView.frame.height / 2
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
        numberStackView.distribution = .equalCentering
        numberStackView.spacing = 7
        addLabelOnStackView()
    }
    
    func addLabelOnStackView() {
        /* так как я использую StackView придумала только такое решение, что бы не ехала верстка
         если будет три строки можно например поменять у StackView distribution = .fillProportionally
         и сделать nameLabel.adjustsFontSizeToFitWidth = true, в этом случае уменьшится текст
         еще нашла решение с greatestFiniteMagnitude для высоты лейбла, но из-за ограничения размера стек вью его не получится использовать
         */
        
        nameLabel.text = "Константин Константинович Константинопольский"
        nameLabel.numberOfLines = 0
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
    
    func addSwipe() {
        let swipeUp = UISwipeGestureRecognizer(target: self,
                                               action: #selector(self.swipeUp))
        swipeUp.direction = .up
        
        let swipeDown = UISwipeGestureRecognizer(target: self,
                                                 action: #selector(self.swipeDown))
        swipeDown.direction = .down
        
        
        businessCardView.gestureRecognizers = [swipeUp, swipeDown]
        shadowView.gestureRecognizers = [swipeUp, swipeDown]
    }
    
    @objc
    func swipeUp() {
        animationSwipe(xx: 0, yy: -(self.cardView.frame.height - self.handle))
    }
    
    @objc
    func swipeDown() {
        animationSwipe(xx: 0, yy: 0)
    }
    
    func animationSwipe(xx: CGFloat, yy: CGFloat) {
        UIView.animate(withDuration: 1,
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 5,
                       options: .allowAnimatedContent,
                       animations: {
                        self.shadowView.transform = CGAffineTransform(translationX: xx, y: yy)
                        self.businessCardView.transform = CGAffineTransform(translationX: xx, y: yy)
        })
    }
}

// MARK: - Layout

private extension DetailViewController {
    
    func layout() {
        
        businessCardView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            businessCardView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor),
            businessCardView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor),
            businessCardView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor),
            businessCardView.heightAnchor.constraint(
                equalToConstant:  220)])
        
        handlerAreaView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            handlerAreaView.bottomAnchor.constraint(
                equalTo: businessCardView.bottomAnchor,
                constant: -13),
            handlerAreaView.heightAnchor.constraint(
                equalToConstant: 4),
            handlerAreaView.widthAnchor.constraint(
                equalToConstant: 16),
            handlerAreaView.centerXAnchor.constraint(
                equalTo: businessCardView.centerXAnchor)])
        
        shadowView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            shadowView.topAnchor.constraint(
                equalTo: view.topAnchor),
            shadowView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor),
            shadowView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor),
            shadowView.bottomAnchor.constraint(
                equalTo: businessCardView.bottomAnchor)])
        
        cardView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor),
            cardView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor),
            cardView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor),
            cardView.heightAnchor.constraint(
                equalToConstant: 110)])
        
        shadowCallImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            shadowCallImage.topAnchor.constraint(
                equalTo: cardView.topAnchor,
                constant: 16),
            shadowCallImage.leadingAnchor.constraint(
                equalTo: cardView.leadingAnchor,
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
            numberStackView.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
            numberStackView.leadingAnchor.constraint(
                equalTo: shadowCallImage.trailingAnchor,
                constant: 16),
            numberStackView.trailingAnchor.constraint(
                equalTo: cardView.trailingAnchor,
                constant: -16),
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
            businessCardStackView.bottomAnchor.constraint(
                equalTo: businessCardView.bottomAnchor,
                constant: -29)])
    }
    
}
