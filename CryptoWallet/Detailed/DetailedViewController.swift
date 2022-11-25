

import UIKit

class DetailedViewController: UIViewController {
    
    var VM: DetailedViewModelProtocol?
    
    
    let detailLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 6
        label.textAlignment = .center
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupContraints()
        setupViewModel()
        //        VM = DetailedViewModel()
    }
    
    func setupViewModel() {
        guard let viewModelDetail = VM else { return }
       
        detailLabel.text = "\(viewModelDetail.nameCrypto) / \(viewModelDetail.symbolCrypto)\nPrice: \(NSString(format:"%.5f", viewModelDetail.costCrypto)) USD\nPrice 24 hours ago:\n \(NSString(format:"%.5f", viewModelDetail.priceYesterday)) USD\nChanging 24 hours:\n\(NSString(format:"%.3f", viewModelDetail.changingPersent))%"
    }
}

extension DetailedViewController {
    private func setupContraints() {
        
        view.addSubview(detailLabel)
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            detailLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            detailLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
