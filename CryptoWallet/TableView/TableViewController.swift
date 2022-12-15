
import Foundation
import UIKit

class TableViewController: UIViewController {
    
    //MARK: - Class properties
    
    var VM: TableViewModelProtocol?
    
    //MARK: - Setup UI elements
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .singleLine
        tableView.rowHeight = 60
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    private lazy var loader: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView()
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.hidesWhenStopped = true
        loader.style = .medium
        loader.startAnimating()
        return loader
    }()
    
    private lazy var logoutButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "rectangle.portrait.and.arrow.forward"), style: .plain, target: self, action: #selector(didTapLogout))
        button.tintColor = .black
        return button
    }()
    
    private lazy var sortButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "arrow.up.and.down.text.horizontal"), style: .plain, target: self, action: #selector(didTapSort))
        button.tintColor = .black
        return button
    }()
    
    //MARK: - UIViewControllers events
    
    override func viewDidLoad() {
        super.viewDidLoad()
        VM = TableViewModel()
        setupView()
        setupTableView()
        setupLoadingIndicator()
        self.VM?.getCrypto { [weak self] crypto in
            DispatchQueue.main.async {
            self?.loader.stopAnimating()
            self?.tableView.reloadData()
        }
    }
}
    
    //MARK: - Class methods
    
    private func setupView() {
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Coins"
        navigationItem.leftBarButtonItem = sortButton
        navigationItem.rightBarButtonItem = logoutButton
    }
    
    private func setupTableView() {
        self.view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupLoadingIndicator() {
        self.view.addSubview(loader)
        loader.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loader.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            loader.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
    }
    
    private func showAlert(with title: String, and message: String, completion: @escaping () -> Void = { }) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { _ in
            completion()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
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
    
    private func setNumberPercentFormat(forItem: Double?) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        let string = "\(formatter.string(from: forItem! as NSNumber) ?? "0.0")%"
        return string
    }
    
    private func setNumberPriceFormat(forItem: Double?) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        let string = "\(formatter.string(from: forItem! as NSNumber) ?? "0.0")"
        return string
    }
    
    //MARK: - Class objc methods
    
    @objc private func didTapLogout() {
        self.showAlert(with: "Exit?", and: "") {
            let vc = LoginViewController()
            UIApplication.shared.windows.first?.rootViewController = vc
            UIApplication.shared.windows.first?.makeKeyAndVisible()
            Defaults.shared.clear()
        }
    }
    
    @objc private func didTapSort() {
        VM?.sortData()
        self.tableView.reloadData()
    }
}

//MARK: - UI Table View

extension TableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return VM?.numberOfRows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        let name = VM?.cryptoArrayData(at: indexPath.row).data.name
        let percent = VM?.cryptoArrayData(at: indexPath.row).data.marketData.dayPercentageChange
        let price = VM?.cryptoArrayData(at: indexPath.row).data.marketData.priceUSD ?? 0.0
        content.text = name
        content.textProperties.font = .systemFont(ofSize: 18)
        content.secondaryText = "\(setNumberPriceFormat(forItem: price))" + " (\(setNumberPercentFormat(forItem: percent)))"
        content.secondaryTextProperties.color = setColour(forItem: percent)
        content.secondaryTextProperties.font = .systemFont(ofSize: 16)
        content.prefersSideBySideTextAndSecondaryText = true
        content.image = UIImage(systemName: "c.circle")
        cell.contentConfiguration = content
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailedViewController()
        detailVC.VM = VM?.viewModelForSelectedRow(for: indexPath)
        navigationController?.pushViewController(detailVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

