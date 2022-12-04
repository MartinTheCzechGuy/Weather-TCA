import SwiftUI

public struct ErrorView: View {

  private let action: () -> Void
  private let buttonLabel: String

  public init(
    action: @escaping () -> Void,
    buttonLabel: String
  ) {
    self.action = action
    self.buttonLabel = buttonLabel
  }

  public var body: some View {
    ZStack {
      Image("error")
        .resizable()
        .scaledToFill()
        .edgesIgnoringSafeArea(.all)

      VStack(spacing: 20) {
        Text("Something went wrong")
          .font(.title)

        Text("Please try again")
          .font(.body)

        Spacer()

        Button(
          action: action,
          label: { Text(buttonLabel) }
        )
        .padding()
        .background(Color.black)
        .clipShape(Capsule())
        .foregroundColor(.white)
      }
      .padding()
    }
  }
}

struct ErrorView_Previews: PreviewProvider {
  static var previews: some View {
    ErrorView(
      action: {},
      buttonLabel: "Understood"
    )
  }
}
