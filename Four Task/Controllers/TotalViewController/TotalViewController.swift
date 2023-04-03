//
//  TotalViewController.swift
//  Four Task
//
//  Created by Ilya Vasilev on 23.07.2022.
//

import UIKit

struct TotalSection {
    let title: String
    let options: [TotalOptionType]
}

enum TotalOptionType {
    case progressCell(model: TotalOption)
}

struct TotalOption {
    let title: String
    let progressView: UIProgressView
    let handler: (() -> Void)
}

class TotalViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    // MARK: - Let-var
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(TotalTableViewCell.self, forCellReuseIdentifier: TotalTableViewCell.identifier)
        return table
    }()
    var models = [Section]()
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        title = "Итоги дня"
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.frame = view.bounds
        tableView.backgroundColor = .systemGray6
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        // Do any additional setup after loading the view.
    }
    // MARK: - Methods
    func configure() {
    }
    //    func numberOfSections(in progressView: MultiProgressView) -> Int {
    //        return 4
    //    }
    //
    //    func progressView(_ progressView: MultiProgressView, viewForSection section: Int) -> ProgressViewSection {
    //        return ProgressViewSection.Type?
    //    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = models[section]
        return section.title
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.section].options[indexPath.row]
        
        switch model.self {
            
        case .staticCell(let model):
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: SettingsTableViewCell.identifier,
                for: indexPath
            ) as? SettingsTableViewCell else {
                return UITableViewCell()
            }
            
            cell.configure(with: model)
            return cell
            
            
        case .switchCell(let model):
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: SwitchTableViewCell.identifier,
                for: indexPath
            ) as? SwitchTableViewCell else {
                return UITableViewCell()
            }
            
            cell.configure(with: model)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let type = models[indexPath.section].options[indexPath.row]
        switch type.self {
        case .switchCell(let model):
            model.handler()
        case .staticCell(let model):
            model.handler()
        }
    }
    //    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    //        return 0
    //    }
}
