/**
 * FluxorSampleToDo
 *  Copyright (c) Morten Bjerg Gregersen 2020
 *  MIT license, see LICENSE file for details
 */

import Foundation

struct Todo: Codable, Identifiable, Equatable, Hashable {
    let id: UUID
    let title: String
    var done = false

    init(title: String) {
        id = UUID()
        self.title = title
    }
}
