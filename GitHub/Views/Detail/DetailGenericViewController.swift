//
//  DetailViewController.swift
//  GitHub
//
//  Created by Jorge Lapeña Antón on 12/06/2020.
//  Copyright © 2020 Jorge Lapeña Antón. All rights reserved.
//

import UIKit

protocol DetailGenericViewControllerDelegate: AnyObject {
    func reloadTableView()
    func errorFetchData(error: String)
}

class DetailGenericViewController: ParentViewController {
    
    @IBOutlet weak var tableView: UITableView!{
        didSet {
            tableView.register(UINib(nibName: String(describing: DetailRepositoriHeaderView.self), bundle: nil), forHeaderFooterViewReuseIdentifier: String(describing: DetailRepositoriHeaderView.self))
            tableView.register(UINib(nibName: String(describing: DetailBaseCell.self), bundle: nil), forCellReuseIdentifier: String(describing: DetailBaseCell.self))
            tableView.separatorStyle = .none
        }
    }

    // MARK: - View Model
    fileprivate var viewModel: DetailGenericViewModel!
    
    private let NUMBER_OF_SECTIONS = 1
    private let HEIGHT_FOR_HEADER_IN_SECTION: CGFloat = 110
}

//MARK: - public methods -
extension DetailGenericViewController {
    func initVM(manager: DetailGenericViewModelDelegate) {
        showHUD()
        viewModel = DetailGenericViewModel(manager: manager, delegate: self)
        title = viewModel.getTitleScreen()
        viewModel.fetchData()
    }
}

//MARK: - private methods -
extension DetailGenericViewController {
    private func getDetailRepositoriHeaderView() -> UIView {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: DetailRepositoriHeaderView.self)) as! DetailRepositoriHeaderView
        view.titleLabel.text = viewModel.getTitleHeader()
        view.subtitleLabel.text = viewModel.getSubtitleHeader()
        view.avatarHeaderImage.downloaded(from: viewModel.getImageHeader())
        view.avatarHeaderImage.layer.masksToBounds = true
        view.loginImage.image = viewModel.getTypeHeader()
        return view
    }
    
    private func getDetailBaseCell(_ indexPath: IndexPath) -> DetailBaseCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DetailBaseCell.self), for: indexPath) as! DetailBaseCell
        cell.titleLabel.text = viewModel.getTitleCell(indexPath.row)
        cell.subtitleLable.text = viewModel.getSubtitleCell(indexPath.row)
        cell.selectionStyle = .none
        if indexPath.row == viewModel.numberOfRows() - 1 {
            cell.separatorView.isHidden = true
        }
        return cell
    }
}

// MARK: - UITableViewDataSource and UITableViewDelegate
extension DetailGenericViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        switch viewModel.getTypeDetail() {
            case .repositorie:
                return NUMBER_OF_SECTIONS
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch viewModel.getTypeDetail() {
            case .repositorie:
                return getDetailRepositoriHeaderView()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch viewModel.getTypeDetail() {
            case .repositorie:
                return HEIGHT_FOR_HEADER_IN_SECTION
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch viewModel.getTypeDetail() {
            case .repositorie:
                return getDetailBaseCell(indexPath)
        }
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch viewModel.getTypeDetail() {
            case .repositorie:
                switch viewModel.getTypeCell(indexPath.row) {
                case .baseCell:
                    break
                case .webCell:
                    openURL(url: viewModel.getSubtitleCell(indexPath.row))
                    break
            }
        }
    }
}

// MARK: - DetailGenericViewControllerDelegate
extension DetailGenericViewController: DetailGenericViewControllerDelegate {
    func reloadTableView() {
        tableView.reloadData()
        hideHUD()
    }
    
    func errorFetchData(error: String) {
        hideHUD()
        alertError(error: error, tag: 1)
    }
}
