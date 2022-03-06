//
//  AddOrEditNewWanteViewModel.swift
//  MadPolice
//
//  Created by Денис Большачков on 04.03.2022.
//

import Foundation
import UIKit

class AddOrEditnewWantedViewModel: ObservableObject {
    @Published var image: UIImage?
    @Published var showPicker: Bool = false
    @Published var source: Picker.Source = .library
}
