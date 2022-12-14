/*
 * Copyright (c) Meta Platforms, Inc. and affiliates.
 * All rights reserved.
 *
 * This source code is licensed under the license found in the
 * LICENSE file in the root directory of this source tree.
 */

@testable import FBAEMKit
import Foundation

enum SampleAEMConfigurations {

  enum Keys {
    static let defaultCurrency = "default_currency"
    static let cutoffTime = "cutoff_time"
    static let validFrom = "valid_from"
    static let mode = "config_mode"
    static let conversionValueRules = "conversion_value_rules"
    static let conversionValue = "conversion_value"
    static let priority = "priority"
    static let events = "events"
    static let eventName = "event_name"
    static let businessID = "advertiser_id"
    static let paramRule = "param_rule"
    static let values = "values"
    static let currency = "currency"
    static let amount = "amount"
  }

  enum Values {
    static let purchase = "fb_mobile_purchase"
    static let addToCart = "fb_mobile_add_to_cart"
    static let donate = "Donate"
    static let defaultMode = "DEFAULT"
    static let brandMode = "BRAND"
    static let cpasMode = "CPAS"
    static let USD = "USD"
  }

  static func createWithMultipleRules() -> AEMConfiguration {
    AEMConfiguration(
      json: [
        Keys.defaultCurrency: Values.USD,
        Keys.cutoffTime: 1,
        Keys.validFrom: 10000,
        Keys.mode: Values.defaultMode,
        Keys.conversionValueRules: [
          [
            Keys.conversionValue: 4,
            Keys.priority: 11,
            Keys.events: [
              [
                Keys.eventName: Values.purchase,
                Keys.values: [
                  [
                    Keys.currency: Values.USD,
                    Keys.amount: 100.0,
                  ],
                ],
              ],
            ],
          ],
          [
            Keys.conversionValue: 3,
            Keys.priority: 10,
            Keys.events: [
              [
                Keys.eventName: Values.purchase,
                Keys.values: [
                  [
                    Keys.currency: Values.USD,
                    Keys.amount: 0.0,
                  ],
                ],
              ],
            ],
          ],
          [
            Keys.conversionValue: 2,
            Keys.priority: 9,
            Keys.events: [
              [
                Keys.eventName: Values.addToCart,
              ],
            ],
          ],
          [
            Keys.conversionValue: 1,
            Keys.priority: 8,
            Keys.events: [
              [
                Keys.eventName: Values.donate,
              ],
            ],
          ],
        ],
      ]
    )! // swiftlint:disable:this force_unwrapping
  }

  static func createConfigurationWithBusinessID() -> AEMConfiguration {
    let advertiserRuleFactory = AEMAdvertiserRuleFactory()

    AEMConfiguration.configure(withRuleProvider: advertiserRuleFactory)

    return AEMConfiguration(
      json: [
        Keys.defaultCurrency: Values.USD,
        Keys.cutoffTime: 1,
        Keys.validFrom: 10000,
        Keys.mode: Values.defaultMode,
        Keys.businessID: "test_advertiserid_123",
        Keys.paramRule: #"{"and": [{"value": {"contains": "abc"}}]}"#,
        Keys.conversionValueRules: [
          [
            Keys.conversionValue: 2,
            Keys.priority: 10,
            Keys.events: [
              [
                Keys.eventName: Values.purchase,
              ],
              [
                Keys.eventName: Values.donate,
              ],
            ],
          ],
        ],
      ]
    )! // swiftlint:disable:this force_unwrapping
  }

  static func createConfigurationWithBusinessIDAndContentRule() -> AEMConfiguration {
    let advertiserRuleFactory = AEMAdvertiserRuleFactory()

    AEMConfiguration.configure(withRuleProvider: advertiserRuleFactory)

    return AEMConfiguration(
      json: [
        Keys.defaultCurrency: Values.USD,
        Keys.cutoffTime: 1,
        Keys.validFrom: 10000,
        Keys.mode: Values.brandMode,
        Keys.businessID: "test_advertiserid_content_test",
        Keys.paramRule: #"{"or": [{"fb_content[*].id": {"eq": "abc"}}]}"#,
        Keys.conversionValueRules: [
          [
            Keys.conversionValue: 2,
            Keys.priority: 10,
            Keys.events: [
              [
                Keys.eventName: Values.purchase,
              ],
            ],
          ],
        ],
      ]
    )! // swiftlint:disable:this force_unwrapping
  }

  static func createConfigurationWithoutBusinessID() -> AEMConfiguration {
    let advertiserRuleFactory = AEMAdvertiserRuleFactory()

    AEMConfiguration.configure(withRuleProvider: advertiserRuleFactory)

    return AEMConfiguration(
      json: [
        Keys.defaultCurrency: Values.USD,
        Keys.cutoffTime: 1,
        Keys.validFrom: 10000,
        Keys.mode: Values.defaultMode,
        Keys.conversionValueRules: [
          [
            Keys.conversionValue: 2,
            Keys.priority: 10,
            Keys.events: [
              [
                Keys.eventName: Values.purchase,
              ],
              [
                Keys.eventName: Values.donate,
              ],
            ],
          ],
        ],
      ]
    )! // swiftlint:disable:this force_unwrapping
  }

  static func createCpasConfiguration() -> AEMConfiguration {
    let advertiserRuleFactory = AEMAdvertiserRuleFactory()

    AEMConfiguration.configure(withRuleProvider: advertiserRuleFactory)

    return AEMConfiguration(
      json: [
        Keys.defaultCurrency: Values.USD,
        Keys.cutoffTime: 1,
        Keys.validFrom: 10000,
        Keys.mode: Values.cpasMode,
        Keys.businessID: "test_advertiserid_cpas",
        Keys.paramRule: #"{"or": [{"fb_content[*].id": {"eq": "abc"}}]}"#,
        Keys.conversionValueRules: [
          [
            Keys.conversionValue: 2,
            Keys.priority: 10,
            Keys.events: [
              [
                Keys.eventName: Values.purchase,
              ],
            ],
          ],
        ],
      ]
    )! // swiftlint:disable:this force_unwrapping
  }
}
