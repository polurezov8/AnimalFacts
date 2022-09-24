//
//  Command.swift
//  AnimalFacts
//
//  Created by Dmitry Polurezov on 22.09.2022.
//

import Foundation

final class Command<T> {
  private let id: String
  private let file: StaticString
  private let function: StaticString
  private let line: UInt
  private let closure: (T) -> Void

  init(
    id: String = "com.redux.command",
    file: StaticString = #file,
    function: StaticString = #function,
    line: UInt = #line,
    _ closure: @escaping (T) -> Void
  ) {
    self.id = id
    self.file = file
    self.function = function
    self.line = line
    self.closure = closure
  }

  func perform(_ value: T) {
    closure(value)
  }

  static func nop(
    id: String = "com.redux.command.nop",
    file: StaticString = #file,
    function: StaticString = #function,
    line: UInt = #line
  ) -> Command {
    Self(id: id, file: file, function: function, line: line) { value in
      let info = """
          type: \(type(of: value))
          id: \(id),
          file: \(file),
          function: \(function),
          line: \(line)
      """
      debugPrint("\(info)")
    }
  }
}

extension Command where T == Void {
  func perform() {
    closure(())
  }
}

extension Command {
  func then(_ another: Command) -> Command {
    Command { value in
      self.closure(value)
      another.closure(value)
    }
  }

  func map<U>(_ transform: @escaping (U) -> T) -> Command<U> {
    Command<U> { value in
      self.closure(transform(value))
    }
  }
}

extension Command: Hashable {
  func hash(into hasher: inout Hasher) {
    hasher.combine(ObjectIdentifier(self))
  }

  static func == (lhs: Command, rhs: Command) -> Bool {
    lhs.id == rhs.id
      && lhs.function.utf8Start == rhs.function.utf8Start
      && lhs.line == rhs.line
  }
}

extension Command: CustomDebugStringConvertible {
  var debugDescription: String {
    """
    \(String(describing: type(of: self)))(
        id: \(id),
        file: \(file),
        function: \(function),
        line: \(line)
    )
    """
  }
}
