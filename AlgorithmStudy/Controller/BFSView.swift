//
//  BFSView.swift
//  AlgorithmStudy
//
//  Created by Junwoo Seo on 11/30/18.
//  Copyright © 2018 Junwoo Seo. All rights reserved.
//

import UIKit

class BFSView: UIView {

    func instanceFromNib() -> UIView {
        return UINib(nibName: "BFS", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }

}
