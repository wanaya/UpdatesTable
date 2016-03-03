//
//  UpdateTable.swift
//  ChangeTable
//
//  Created by Guillermo Anaya on 3/3/16.
//  Copyright © 2016 gbox. All rights reserved.
//

import Foundation

final class Box<Element> {
  let unbox: Element
  init(_ x: Element) { unbox = x }
}


struct Data {
  var name: String
}

extension Data: Equatable {}
func ==(lhs: Data, rhs: Data) -> Bool {
  return lhs.name == rhs.name
}

protocol CollectionSourceUpdater {
  func modelUpdate(indexPath: NSIndexPath)
  func modelDelete(indexPath: NSIndexPath)
  func modelAdd()
}

class CollectionSource<T> {
  var collectionSourceUpdater: CollectionSourceUpdater? = nil
  var source: [T]
  init(source: [T]) {
    self.source = source
  }
}


enum UpdateType<T> {
  case New(T)
  case Update(T, indexPath: NSIndexPath)
  case Delete(indexPath: NSIndexPath)
}

protocol ModelUpdate {
  typealias ModelType
  func updateWith(updateType: UpdateType<ModelType>)
}

extension CollectionSource: ModelUpdate {
  func updateWith(updateType: UpdateType<T>) {
    switch updateType {
    case .New(let value):
      source.append(value)
      collectionSourceUpdater?.modelAdd()
    case .Update(let value, let indexPath):
      source[indexPath.row] = value
      collectionSourceUpdater?.modelUpdate(indexPath)
    case .Delete(let indexPath):
      source.removeAtIndex(indexPath.row)
      collectionSourceUpdater?.modelDelete(indexPath)
    }
  }
}


struct ModelDetail<T: ModelUpdate> {
  var updater: T
  let model: T.ModelType?
  let selectedIndexPath: NSIndexPath?
}
