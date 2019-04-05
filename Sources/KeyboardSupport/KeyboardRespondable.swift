//
//  KeyboardRespondable.swift
//  KeyboardSupport
//
//  Created by Earl Gaspard on 12/19/17.
//  Copyright © 2017 Bottle Rocket Studios. All rights reserved.
//

import UIKit

/// Inherits from both KeyboardDismissable and KeyboardScrollable for convenience.
public protocol KeyboardRespondable: KeyboardDismissable, KeyboardScrollable {}
