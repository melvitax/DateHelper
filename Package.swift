// swift-tools-version:5.0
//
//  AFDateHelper.swift
//  https://github.com/melvitax/DateHelper
//  Version 4.2.9
//
//  Created by David Velarde on 6/7/19.
//  Copyright (c) 2019. All rights reserved.
//

import PackageDescription

let package = Package(
    name: "DateHelper",
    platforms: [
        .iOS(.v9),
        .macOS(.v10_11),
        .tvOS(.v9),
        .watchOS(.v2)
    ],
    products: [
        .library(name: "DateHelper", targets: ["DateHelper"])
    ],
    targets: [
        .target(
            name: "DateHelper",
            path: "Sources"
        )
    ],
    swiftLanguageVersions: [.v5]
)
