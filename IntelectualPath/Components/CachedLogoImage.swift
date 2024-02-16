//
//  CachedLogoImage.swift
//  IntelectualPath
//
//  Created by Альпеша on 06.02.2024.
//

import Foundation
import SwiftUI

struct CachedLogoImage: View {
    var body: some View {
        Image("Logo")
            .resizable()
            .scaledToFit()
    }
}
