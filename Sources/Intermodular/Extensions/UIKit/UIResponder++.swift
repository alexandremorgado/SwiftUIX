//
// Copyright (c) Vatsal Manot
//

#if os(iOS) || os(tvOS)

import Swift
import UIKit

extension UIResponder {
    open func nearestResponder<Responder: UIResponder>(ofKind kind: Responder.Type) -> Responder? {
        guard !isKind(of: kind) else {
            return (self as! Responder)
        }

        return next?.nearestResponder(ofKind: kind)
    }

    private func furthestResponder<Responder: UIResponder>(ofKind kind: Responder.Type, default _default: Responder?) -> Responder? {
        return next?.furthestResponder(ofKind: kind, default: self as? Responder) ?? _default
    }

    open func furthestResponder<Responder: UIResponder>(ofKind kind: Responder.Type) -> Responder? {
        return furthestResponder(ofKind: kind, default: nil)
    }

    open func forEach<Responder: UIResponder>(ofKind kind: Responder.Type, recursive iterator: (Responder) throws -> ()) rethrows {
        if isKind(of: kind) {
            try iterator(self as! Responder)
        }

        try next?.forEach(ofKind: kind, recursive: iterator)
    }
}

extension UIResponder {
    open var nearestViewController: UIViewController? {
        return nearestResponder(ofKind: UIViewController.self)
    }

    open var furthestViewController: UIViewController? {
        return furthestResponder(ofKind: UIViewController.self)
    }

    open var nearestNavigationController: UINavigationController? {
        return nearestResponder(ofKind: UINavigationController.self)
    }

    open var furthestNavigationController: UINavigationController? {
        return furthestResponder(ofKind: UINavigationController.self)
    }
}

#endif
