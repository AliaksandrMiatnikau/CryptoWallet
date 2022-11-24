

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
        detailLabel.text = "\(viewModelDetail.nameCrypto) /  \(viewModelDetail.symbolCrypto)\nPrice: \(viewModelDetail.costCrypto) USD\nPrice 24 hours ago:\n \(viewModelDetail.percentChangeUsdLast24Hours) USD"
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
