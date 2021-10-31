// swift-tools-version:5.3
//
//  AFDateHelper.swift
//  https://github.com/melvitax/DateHelper
//  Version 4.5.2
//
//  Created by David Velarde on 6/7/19.
//  Copyright (c) 2019. All rights reserved.
//

import PackageDescription

let package = Package(
    name: "DateHelper",
    platforms: [
        .iOS(.v11),
        .macOS(.v10_13),
        .tvOS(.v12),
        .watchOS(.v4)
    ],
    products: [
        .library(name: "DateHelper", targets: ["DateHelper"])
    ],
    targets: [
        .target(
            name: "DateHelper",
            path: "Sources",
            exclude: [
                "Info.plist"
            ]
        )
    ],
    swiftLanguageVersions: [.v5]
)
