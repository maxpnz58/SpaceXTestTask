//
//  ParametersTableView.swift
//  SpaceXProj
//
//  Created by Max on 18.11.2024.
//

import UIKit

class ParametersTableView: UITableView, UITableViewDelegate, UITableViewDataSource {

    var page = 0
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.delegate = self
        self.dataSource = self
        self.register(ParametersTableViewCell.self, forCellReuseIdentifier: ParametersTableViewCell.identifier)
        self.register(ParametersTableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: ParametersTableViewHeaderFooterView.identifier)
        self.setupTableViewAppearance()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func setupTableViewAppearance() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.separatorStyle = .none
        self.backgroundColor = .clear
        self.selectionFollowsFocus = false
        self.sectionHeaderTopPadding = 0
        self.isScrollEnabled = false
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return rocketBaseParametersNames.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rocketBaseParametersNames[section].parameters.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: ParametersTableViewHeaderFooterView.identifier) as? ParametersTableViewHeaderFooterView
        
        let sectionTitle = rocketBaseParametersNames[section].title
        header?.configure(with: sectionTitle)
        return header
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ParametersTableViewCell.identifier) as? ParametersTableViewCell else {
            return UITableViewCell()
        }
        
        let leftText = dataForUse.rocketBaseParameters[page][indexPath.section].parameters[indexPath.row]
        let rightText = dataForUse.rocketBaseParameters[page][indexPath.section].meanings[indexPath.row]

        cell.setupData(leftText, rightText)
        cell.selectionStyle = .none
        return cell
    }
}
