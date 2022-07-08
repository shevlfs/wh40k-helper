import Foundation
import Introspect
import SwiftUI

struct NavigationLinkImplement<Destination: View, Label: View>: View {
  let destination: () -> Destination
  @ViewBuilder let label: () -> Label
  @State private var isActive = false
  @State private var nav: UINavigationController?
   
  var body: some View {
    Button(action: action, label: label)
      .introspectNavigationController { nav in
        self.nav = nav
      }
  }
   
  func action() {
    let dest = UIHostingController<Destination>(rootView: destination())
    nav?.pushViewController(dest, animated: true)
  }
}
