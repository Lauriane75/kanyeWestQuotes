//
//  FirstViewController.swift
//  mvvmSample
//
//  Created by Lauriane Haydari on 13/03/2020.
//  Copyright © 2020 Lauriane Haydari. All rights reserved.
//

import UIKit

class SelectViewController: UIViewController {

    // MARK: - Outlet

    @IBOutlet weak var titlelabel: UILabel!

    @IBOutlet weak var quoteLabel: UILabel!

    @IBOutlet weak var heartButton: UIButton!

    @IBOutlet weak var quoteButton: UIButton!

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var heartLabel: UILabel!

    @IBOutlet weak var quoteView: UIView!
    // MARK: - Properties

    var viewModel: SelectViewModel!

    // MARK: - View life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBarCustom()
        elementsCustom()

        bind(to: viewModel)

        viewModel.viewDidLoad()

        activityIndicator.isHidden = true
    }

    private func bind(to viewModel: SelectViewModel) {
        viewModel.titleText = { [weak self] text in
            self?.titlelabel.text = text
        }
        viewModel.quoteLabel = { [weak self] text in
            self?.quoteLabel.text = text.first
        }
        viewModel.quoteButtonText = { [weak self] text in
            self?.quoteButton.setTitle(text, for: .normal)
        }
        viewModel.isLoading = { [weak self] loadingState in
            DispatchQueue.main.async {
                switch loadingState {
                case true:
                    self?.activityIndicator.isHidden = false
                    self?.activityIndicator.startAnimating()
                case false:
                    self?.activityIndicator.stopAnimating()
                    self?.activityIndicator.isHidden = true
                }
            }
        }
    }

    // MARK: - View actions

    @IBAction func didPressHeartButton(_ sender: Any) {

    }
    
    @IBAction func didPressQuoteButton(_ sender: Any) {
        viewModel.didPressGetQuote()
    }
    // MARK: - Private Files

    fileprivate func navigationBarCustom() {
        guard let bar = navigationController?.navigationBar else { return }
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.red,
                              NSAttributedString.Key.font: UIFont(name: "kailasa", size: 20)]
        bar.titleTextAttributes = textAttributes as [NSAttributedString.Key: Any]
        viewModel.navBarTitle = { text in
            self.navigationItem.title = text
        }
    }

    fileprivate func elementsCustom() {
        // quoteButton
        quoteButton.layer.cornerRadius = 15
        quoteButton.layer.borderWidth = 1
        quoteButton.layer.borderColor = UIColor.white.cgColor
        // quoteView
        quoteView.layer.cornerRadius = 15
    }
}
