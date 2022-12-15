//
//  TableViewCell.swift
//  CryptoWallet
//
//  Created by Aliaksandr Miatnikau on 14.12.22.
//

import UIKit

class TableViewCell: UITableViewCell {

static let identifier = "TableViewCell"
    var VM: TableViewModelProtocol?

    let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath)
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
}
