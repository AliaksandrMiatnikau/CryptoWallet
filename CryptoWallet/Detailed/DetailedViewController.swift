

import UIKit

class DetailedViewController: UIViewController {
    
    //MARK: - Class properties
    
    var VM: DetailedViewModelProtocol?
    
    //MARK: - Setup UI elements
    
    private lazy var detailLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 12
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var percentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textAlignment = .center
        
        return label
    }()
    
    //MARK: - UIViewControllers events
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupContraints()
        setupViewModel()
    }
    //MARK: - Class methods
    
    private func setupViewModel() {
        guard let viewModelDetail = VM else { return }
        
        detailLabel.text = "\(viewModelDetail.nameCrypto)\n\(viewModelDetail.symbolCrypto)\n\nPrice:\n\(NSString(format:"%.5f", viewModelDetail.costCrypto)) USD\n\nPrice 24 hours ago:\n \(NSString(format:"%.5f", viewModelDetail.priceYesterday)) USD\n\nChanging 24 hours:"
        percentLabel.textColor = setColour(forItem: viewModelDetail.changingPersent)
        percentLabel.text = "\(NSString(format:"%.3f", viewModelDetail.changingPersent))%"
    }
    
    private func setColour(forItem: Double?) -> UIColor {
        if  forItem ?? 0 > 0 {
            return .systemGreen
        } else if
            forItem ?? 0 < 0 {
            return .systemRed
        } else {
            return .systemGray
        }
    }
}

//MARK: - Setup constraints

extension DetailedViewController {
    private func setupContraints() {
        
        view.addSubview(detailLabel)
        view.addSubview(percentLabel)
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        percentLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            detailLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            detailLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            percentLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            percentLabel.topAnchor.constraint(equalTo: detailLabel.bottomAnchor, constant: 10)
        ])
    }
}
