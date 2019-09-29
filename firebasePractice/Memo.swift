//
//  Memo.swift
//  firebasePractice
//
//  Created by MC975-107 on 29/09/2019.
//  Copyright © 2019 comso. All rights reserved.
//

import Foundation
struct Memo {
    let title: String
}

extension Memo {
    func toDictionary() -> [String: Any] {
        return ["title": title]
    }
}
