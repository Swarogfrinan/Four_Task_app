import UIKit

// MARK: - Settings View Controller

struct Section {
    let title: String
    let options: [SettingsOptionType]
}

enum SettingsOptionType {
    case staticCell(model: SettingsOption)
    case switchCell(model: SettingsSwitchOption)
}

struct SettingsSwitchOption {
    let title: String
    let icon: UIImage?
    let iconBackgroundColor: UIColor
    let handler: (() -> Void)
    var isOn:  Bool
}

struct SettingsOption {
    let title: String
    let icon: UIImage?
    let iconBackgroundColor: UIColor
    let handler: (() -> Void)
}

class SettingsViewController: UIViewController {
    
    // MARK: - Constant
    
    var models = [Section]()
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCells()
        setupDelegate()
        setupTableView()
        setupTitle()
    }
    
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(SettingsTableViewCell.self, forCellReuseIdentifier: SettingsTableViewCell.identifier)
        table.register(SwitchTableViewCell.self, forCellReuseIdentifier: SwitchTableViewCell.identifier)
        return table
    }()
    func setupTitle() {
        title = "Настройки"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
    }
    func setupTableView() {
        tableView.frame = view.bounds
        tableView.backgroundColor = .systemGray6
        view.addSubview(tableView)
    }
    
    func setupDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // MARK: - Methods
    func configureCells() {
        
        
        
        models.append(Section(title: "Таймеры", options: [
            .switchCell(model: SettingsSwitchOption(
                title: "Томат",
                icon: UIImage(named: "tomatoTimer"),
                iconBackgroundColor: .systemIndigo,
                handler: {
                },
                isOn: false)),
            
                .switchCell(model: SettingsSwitchOption(
                    title: "4 задачи",
                    icon: UIImage(systemName:"square.grid.2x2.fill"),
                    iconBackgroundColor: .systemIndigo,
                    handler: {
                    },
                    isOn: false))
        ]))
        
        
        models.append(Section(title: "Ticking sound", options: [
            
            .switchCell(model: SettingsSwitchOption(
                title: "Silent mode", icon: UIImage(systemName:"square.grid.2x2.fill"),
                iconBackgroundColor: .systemIndigo,
                handler: {
                },
                isOn: false)),
            
                .staticCell(model: SettingsOption(
                    title: "Focus ticking",
                    icon: UIImage(systemName: "speaker.wave.3.fill"),
                    iconBackgroundColor: .systemPink) {
                        print("Ticking sound tapped")
                    }),
            
                .staticCell(model: SettingsOption(
                    title: "Focus Alarm",
                    icon: UIImage(systemName: "bell.and.waves.left.and.right.fill"),
                    iconBackgroundColor: .systemPink) {
                    }),
        ]))
        
        models.append(Section(title: "Help & feedback", options: [
            
            .staticCell(model: SettingsOption(
                title: "Email us",
                icon: UIImage(systemName: "mail"),
                iconBackgroundColor: .systemPink) {
                    print("Help & feedback tapped")
                }),
            
                .staticCell(model: SettingsOption(
                    title: "How timer works",
                    icon: UIImage(systemName: "timer"),
                    iconBackgroundColor: .systemPink) {
                    }),
            
                .staticCell(model: SettingsOption(
                    title: "Airplane mood",
                    icon: UIImage(systemName: "airplane"),
                    iconBackgroundColor: .systemGreen) {
                    }),
            
                .staticCell(model: SettingsOption(
                    title: "Icloud",
                    icon: UIImage(systemName: "cloud"),
                    iconBackgroundColor: .systemOrange) {
                    }),
            
        ]))
    }
}

// MARK: - UITableViewDataSource
extension SettingsViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = models[section]
        return section.title
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
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
    
}
// MARK: - UITableViewDelegate

extension SettingsViewController : UITableViewDelegate {
    
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
}



