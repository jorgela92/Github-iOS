//
//  ViewController.swift
//  GitHub
//
//  Created by Jorge Lapeña Antón on 10/06/2020.
//  Copyright © 2020 Jorge Lapeña Antón. All rights reserved.
//

import UIKit

protocol ListViewControllerDelegate: AnyObject {
    func reloadTableView(isSearchClose: Bool)
    func errorFetchData(error: String)
}

class ListViewController: ParentViewController {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(UINib(nibName: String(describing: RepositorieHeaderView.self), bundle: nil), forHeaderFooterViewReuseIdentifier: String(describing: RepositorieHeaderView.self))
            tableView.register(UINib(nibName: String(describing: RepositorieCell.self), bundle: nil), forCellReuseIdentifier: String(describing: RepositorieCell.self))
            tableView.register(UINib(nibName: String(describing: LoadingCell.self), bundle: nil), forCellReuseIdentifier: String(describing: LoadingCell.self))
            tableView.separatorStyle = .none
        }
    }
    @IBOutlet weak var imageError: UIImageView!
    @IBOutlet weak var labelError: UILabel!

    // MARK: - View Model
    fileprivate var viewModel: ListGenericViewModel!
    private let NUMBER_OF_SECTIONS = 1
    private let HEIGHT_FOR_HEADER_IN_SECTION: CGFloat = 85
    private let ERROR_STRING = "not_elements_search"
}

//MARK: - public methods -
extension ListViewController {
    func initVM(manager: ListGenericViewModelDelegate) {
        showHUD()
        viewModel = ListGenericViewModel(manager: manager, delegate: self)
        title = viewModel.getTitleScreen()
        viewModel.fetchData()
    }
}

//MARK: - private methods -
extension ListViewController {
    private func isHiddenElementsView(_ isHidden: Bool) {
        tableView.isHidden = isHidden
        imageError.isHidden = !isHidden
        labelError.isHidden = !isHidden
    }
    
    private func getLoadingCell(indexPath: IndexPath) -> LoadingCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: LoadingCell.self), for: indexPath) as! LoadingCell
        cell.loading.startAnimating()
        cell.selectionStyle = .none
        viewModel.fetchData(since: viewModel.getLastId())
        return cell
    }
    
    private func getRepositorieSectionView() -> UIView {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: RepositorieHeaderView.self)) as! RepositorieHeaderView
        view.delegate = self
        return view
    }
    
    private func getRepositorieCell(indexPath: IndexPath) -> RepositorieCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RepositorieCell.self), for: indexPath) as! RepositorieCell
        cell.labelName.text = viewModel.getName(index: indexPath.row)
        cell.labelDescription.text = viewModel.getRepositorieDescription(index: indexPath.row)
        cell.labelLogin.text = viewModel.getLogin(index: indexPath.row)
        cell.imageType.image = viewModel.getType(index: indexPath.row)
        cell.selectionStyle = .none
        return cell
    }
}

// MARK: - UITableViewDataSource and UITableViewDelegate
extension ListViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return NUMBER_OF_SECTIONS
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch viewModel.getTypeCellsList() {
            case .repositories:
                return getRepositorieSectionView()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch viewModel.getTypeCellsList() {
            case .repositories:
                return HEIGHT_FOR_HEADER_IN_SECTION
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch viewModel.getTypeCellsList() {
            case .repositories:
                if indexPath.row == (viewModel.numberOfRows() - 1) && viewModel.isPagination() {
                    return getLoadingCell(indexPath: indexPath)
                } else {
                    return getRepositorieCell(indexPath: indexPath)
                }
        }
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch viewModel.getTypeCellsList() {
            case .repositories:
                viewModel.detailElement(viewController: self, index: indexPath.row)
        }
    }
}

// MARK: - ListViewControllerDelegate
extension ListViewController: ListViewControllerDelegate {
    func reloadTableView(isSearchClose: Bool) {
        if isSearchClose {
            tableView.reloadSections(IndexSet(integersIn: 0...0), with: UITableView.RowAnimation.top)
        }
        tableView.reloadData()
        hideHUD()
        isHiddenElementsView(false)
    }
    
    func errorFetchData(error: String) {
        hideHUD()
        viewModel.setPagination(false)
        if viewModel.numberOfRows() == 0 {
            isHiddenElementsView(true)
            labelError.text = error
        } else {
            tableView.reloadData()
            isHiddenElementsView(false)
            alertError(error: error)
        }
    }
}

// MARK: - RepositorieHeaderViewDelegate
extension ListViewController: RepositorieHeaderViewDelegate {
    func closeSearch() {
        viewModel.closeSearch()
    }
    
    func search(text: String?) {
        showHUD()
        if let text = text, "" != text {
            viewModel.searchData(text)
        } else {
            alertError(error: ERROR_STRING.localized)
        }
    }
}
