//
//  Log.swift
//  Pingd
//
//  Created by David Acevedo on 2/16/20.
//  Copyright © 2020 David Acevedo. All rights reserved.
//

import os

private let subsystem = "com.davidacevedo.Pingd"

struct Log {
    static let view = OSLog(subsystem: subsystem, category: "view")
    static let networking = OSLog(subsystem: subsystem, category: "networking")
}
