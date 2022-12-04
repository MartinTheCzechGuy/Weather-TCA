import Foundation

public enum LoadingState<Value: Equatable, Failure: Equatable>: Equatable {
  case loading
  case idle
  case loaded(Value)
  case failed(Failure)
}
