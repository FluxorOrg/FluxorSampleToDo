/*
 * FluxorSampleToDo
 *  Copyright (c) Morten Bjerg Gregersen 2020
 *  MIT license, see LICENSE file for details
 */

import Fluxor

enum NavigationActions {
    static let showAddSheet = ActionTemplate(id: "[Navigation] Show add sheet")
    static let hideAddSheet = ActionTemplate(id: "[Navigation] Hide add sheet")
}
