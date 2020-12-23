//
//  main.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 12/22/20.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import Foundation
import UIKit

CommandLine.unsafeArgv.withMemoryRebound(to: UnsafeMutablePointer<Int8>.self, capacity: Int(CommandLine.argc))
{   argv in
    _ = UIApplicationMain(CommandLine.argc, argv, NSStringFromClass(InterractionUIApplication.self), NSStringFromClass(AppDelegate.self))
}
