/**
 * FluxorSampleToDo
 *  Copyright (c) Morten Bjerg Gregersen 2020
 *  MIT license, see LICENSE file for details
 */

import Fluxor
import FluxorExplorerInterceptor
import UIKit

struct AppEnvironment {
    var todoService: TodoServiceProtocol = TodoService()
}
