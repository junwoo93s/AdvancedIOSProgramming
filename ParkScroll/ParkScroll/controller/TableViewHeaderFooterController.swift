//
//  TableViewHeaderFooterController.swift
//  ParkScroll
//
//  Created by Junwoo Seo on 10/1/18.
//  Copyright © 2018 Junwoo Seo. All rights reserved.
//

import UIKit

protocol UITableViewHeaderFooterViewDelegate {
    func collapseSection(header: TableViewHeaderFooterController, section: Int)
}

class TableViewHeaderFooterController: UITableViewHeaderFooterView {

    var delegate: UITableViewHeaderFooterViewDelegate?
    var section: Int!

    func Initialization(name: String, section: Int, delegate: UITableViewHeaderFooterViewDelegate){
        self.textLabel?.text = name
        self.section = section
        self.delegate = delegate
    }

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectSection)))
    }

    @objc func selectSection(gestureRecognizer: UITapGestureRecognizer){
        let cell = gestureRecognizer.view as! TableViewHeaderFooterController
        let section: Int = cell.section
        delegate?.collapseSection(header: self, section: section)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    

}
