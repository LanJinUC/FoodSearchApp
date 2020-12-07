//
//  DataStore.swift
//  Recipe Garage
//
//  Created by 印思佳 on 2020-12-02.
//

import Foundation
import SwiftUI
import Combine

struct Task : Identifiable {
    var id = String()
    var toDoItem = String()
}

class TaskStore : ObservableObject {
    @Published var tasks = [Task]()
}
