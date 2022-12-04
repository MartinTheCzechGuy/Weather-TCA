import SwiftUI

public struct LoadingView: View {

  private let title: String

  public init(_ title: String) {
    self.title = title
  }

  public var body: some View {
    ProgressView(title)
  }
}

struct LoadingView_Previews: PreviewProvider {
  static var previews: some View {
    LoadingView("Loading...")
  }
}
