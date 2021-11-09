/*
 * FluxorSampleToDo
 *  Copyright (c) Morten Bjerg Gregersen 2020
 *  MIT license, see LICENSE file for details
 */

struct AppState: Encodable {
    var todo = TodoState()
    var navigation = NavigationState()
}
