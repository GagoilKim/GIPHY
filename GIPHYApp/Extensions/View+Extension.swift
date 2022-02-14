//
//  View+Extension.swift
//  GIPHYApp
//
//  Created by KyleKim on 2022/02/14.
//

import Foundation
import SwiftUI

extension View {
    @ViewBuilder func isHidden(_ bool: Bool) -> some View {
        if bool {
            self.hidden()
        }else {
            self
        }
    }
}
