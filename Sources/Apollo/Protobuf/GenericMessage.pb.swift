/*
 * DO NOT EDIT.
 *
 * Generated by the protocol buffer compiler.
 * Source: GenericMessage.proto
 *
 */

import Foundation
import SwiftProtobuf

// If the compiler emits an error on this type, it is because this file
// was generated by a version of the `protoc` Swift plug-in that is
// incompatible with the version of SwiftProtobuf to which you are linking.
// Please ensure that your are building against the same version of the API
// that was used to generate this file.
fileprivate struct _GeneratedWithProtocGenSwiftVersion: SwiftProtobuf.ProtobufAPIVersionCheck {
  struct _1: SwiftProtobuf.ProtobufAPIVersion_1 {}
  typealias Version = _1
}

struct GenericMessage: SwiftProtobuf.Proto3Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = "GenericMessage"
  static let protoPackageName: String = ""
  static let _protobuf_fieldNames: FieldNameMap = [
    1: .same(proto: "service"),
    2: .same(proto: "title"),
    4: .same(proto: "subtitle"),
    5: .same(proto: "author"),
    3: .same(proto: "data"),
  ]


  enum OneOf_X: Equatable {
    case subtitle(String)
    case author(String)

    static func ==(lhs: GenericMessage.OneOf_X, rhs: GenericMessage.OneOf_X) -> Bool {
      switch (lhs, rhs) {
      case (.subtitle(let l), .subtitle(let r)): return l == r
      case (.author(let l), .author(let r)): return l == r
      default: return false
      }
    }

    fileprivate init?<T: SwiftProtobuf.Decoder>(byDecodingFrom decoder: inout T, fieldNumber: Int) throws {
      switch fieldNumber {
      case 4:
        var value = String()
        try decoder.decodeSingularStringField(value: &value)
        self = .subtitle(value)
        return
      case 5:
        var value = String()
        try decoder.decodeSingularStringField(value: &value)
        self = .author(value)
        return
      default:
        break
      }
      return nil
    }

    fileprivate func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V, start: Int, end: Int) throws {
      switch self {
      case .subtitle(let v):
        if start <= 4 && 4 < end {
          try visitor.visitSingularStringField(value: v, fieldNumber: 4)
        }
      case .author(let v):
        if start <= 5 && 5 < end {
          try visitor.visitSingularStringField(value: v, fieldNumber: 5)
        }
      }
    }
  }

  ///      int64 id = 1;
  var service: String = ""

  var title: String = ""

  var subtitle: String {
    get {
      if case .subtitle(let v)? = x {
        return v
      }
      return ""
    }
    set {
      x = .subtitle(newValue)
    }
  }

  var x: GenericMessage.OneOf_X? = nil

  var author: String {
    get {
      if case .author(let v)? = x {
        return v
      }
      return ""
    }
    set {
      x = .author(newValue)
    }
  }

  ///  string title = 2;
  var data: Data = Data()

  init() {}

  mutating func _protoc_generated_decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      try decodeField(decoder: &decoder, fieldNumber: fieldNumber)
    }
  }

  mutating func _protoc_generated_decodeField<D: SwiftProtobuf.Decoder>(decoder: inout D, fieldNumber: Int) throws {
    switch fieldNumber {
    case 1: try decoder.decodeSingularStringField(value: &service)
    case 2: try decoder.decodeSingularStringField(value: &title)
    case 4, 5:
      if x != nil {
        try decoder.handleConflictingOneOf()
      }
      x = try GenericMessage.OneOf_X(byDecodingFrom: &decoder, fieldNumber: fieldNumber)
    case 3: try decoder.decodeSingularBytesField(value: &data)
    default: break
    }
  }

  func _protoc_generated_traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !service.isEmpty {
      try visitor.visitSingularStringField(value: service, fieldNumber: 1)
    }
    if !title.isEmpty {
      try visitor.visitSingularStringField(value: title, fieldNumber: 2)
    }
    if data != Data() {
      try visitor.visitSingularBytesField(value: data, fieldNumber: 3)
    }
    try x?.traverse(visitor: &visitor, start: 4, end: 6)
  }

  func _protoc_generated_isEqualTo(other: GenericMessage) -> Bool {
    if service != other.service {return false}
    if title != other.title {return false}
    if x != other.x {return false}
    if data != other.data {return false}
    return true
  }
}