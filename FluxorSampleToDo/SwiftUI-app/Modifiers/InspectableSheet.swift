/**
 * FluxorSampleToDoSwiftUI
 *  Copyright (c) Morten Bjerg Gregersen 2021
 *  MIT license, see LICENSE file for details
 */

import SwiftUI

// To inspect sheets in tests, we need to wrap them.
// Reference: https://github.com/nalexn/ViewInspector/blob/master/guide_popups.md#sheet

extension View {
    func inspectableSheet<Sheet>(isPresented: Binding<Bool>, onDismiss: (() -> Void)? = nil, @ViewBuilder content: @escaping () -> Sheet) -> some View where Sheet: View {
        return modifier(InspectableSheet(isPresented: isPresented, onDismiss: onDismiss, popupBuilder: content))
    }
}

struct InspectableSheet<Sheet>: ViewModifier where Sheet: View {
    let isPresented: Binding<Bool>
    let onDismiss: (() -> Void)?
    let popupBuilder: () -> Sheet

    func body(content: Self.Content) -> some View {
        content.sheet(isPresented: isPresented, onDismiss: onDismiss, content: popupBuilder)
    }
}
