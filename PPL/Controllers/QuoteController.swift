//
//  QuoteController.swift
//  PPL
//
//  Created by Chris Boshoff on 2022/09/02.
//

import UIKit

class QuoteController: UIViewController, QuoteProtocol {

    // MARK: - IBOutlets
    @IBOutlet weak var quoteImage: UIImageView!
    @IBOutlet weak var quoteLabel: UILabel!
    
    
    // MARK: - Initializers
    var quoteManager = QuoteManager()
    var quoteModel   : QuoteModel?
    
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        quoteManager.delegate = self
    }
    
    
    // MARK: - Protocol Methods
    func getQuote(_ quote: QuoteModel) {
        DispatchQueue.main.async {
            self.quoteLabel.text = quote.quote
        }
    }
    
    
    // MARK: - IBActions
    @IBAction func getQuoteButton(_ sender: Any) {
        quoteImage.alpha = 0
        quoteManager.QuoteAPI()
    }
}
