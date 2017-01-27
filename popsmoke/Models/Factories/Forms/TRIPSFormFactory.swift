//
//  TRIPSFormFactory.swift
//  popsmoke
//
//  Created by Charles Cliff on 1/26/17.
//  Copyright © 2017 Charles Cliff. All rights reserved.
//

import Eureka

let trips_driver_age	= "DRIVER AGE"
let trips_day_or_night	= "DAY / NIGHT"
let trips_nightly_sleep	= "NIGHTLY SLEEP"
let trips_road			= "ROADS"
let trips_rest_stops	= "REST STOPS"
let trips_alcohol		= "ALCOHOL"
let trips_weather		= "WEATHER REPORT"
let trips_rv			= "RV"

let bracket1 = "15 - 20"
let bracket2 = "21 - 24"
let bracket3 = "25 - 34"
let bracket4 = "35 - 44"
let bracket5 = "45 - 54"
let bracket6 = "55 or older"

let trips_day	= "DAY"
let trips_night	= "NIGHT"

let trips_sleep_bracket1		= "Less than 2 Hours"
let trips_sleep_bracket2		= "Between 2 and 4 Hours"
let trips_sleep_bracket3		= "Between 4 and 6 Hours"
let trips_sleep_bracket4		= "Between 6 and 8 Hours"
let trips_sleep_bracket5		= "More than 8 Hours"
let trips_road_bracket1			= "Two-lane Roads"
let trips_road_bracket2			= "Multi-lane Roads"
let trips_rest_stop_bracket1	= "NO - I am planning to drive straight through"
let trips_rest_stop_bracket2	= "YES - I plan to stop every two hours"
let trips_rest_stop_bracket3	= "YES - I plan to stop every three hours"
let trips_rest_stop_bracket4	= "YES - I plan to stop every four hours"
let trips_rest_stop_bracket5	= "My trip is less than 3 hours"
let trips_alcohol_bracket1		= "Yes"
let trips_alcohol_bracket2		= "No"
let trips_weather_bracket1		= "Yes"
let trips_weather_bracket2		= "No"
let trips_rv_bracket1			= "Yes"
let trips_rv_bracket2			= "No"


class TRIPSFormFactory: NSObject {

	private class func ageBrackets() -> [String] {
		return [bracket1, bracket2, bracket3, bracket4, bracket5, bracket6]
	}
	
	private class func dayOrNightBrackets() -> [String] {
		return [trips_day, trips_night]
	}
	
	private class func sleepBrackets() -> [String] {
		return [trips_sleep_bracket1, trips_sleep_bracket2, trips_sleep_bracket3, trips_sleep_bracket4, trips_sleep_bracket5]
	}
	
	private class func roadBrackets() -> [String] {
		return [trips_road_bracket1, trips_road_bracket2]
	}
	
	private class func restStopBrackets() -> [String] {
		return [trips_rest_stop_bracket1, trips_rest_stop_bracket2, trips_rest_stop_bracket3, trips_rest_stop_bracket4, trips_rest_stop_bracket5]
	}
	
	private class func alcoholBrackets() -> [String] {
		return [trips_alcohol_bracket1, trips_alcohol_bracket2]
	}
	
	private class func weatherBrackets() -> [String] {
		return [trips_weather_bracket1, trips_weather_bracket2]
	}
	
	private class func rvBrackets() -> [String] {
		return [trips_rv_bracket1, trips_rv_bracket2]
	}
	
	class func appendQuestions(form: Form) {
		
		form +++ Section("QUESTION")
			<<< AlertRow<String>() { row in
				row.tag = trips_driver_age
				row.title = trips_driver_age
				row.selectorTitle = "How old is the driver?"
				row.options = TRIPSFormFactory.ageBrackets()
				row.value = TRIPSFormFactory.ageBrackets()[0]
				row.add(rule: RuleRequired())
				}.onChange { row in
					print(row.value ?? "No Value")
				}.onPresent{ _, to in
					to.view.tintColor = .purple
				}.cellUpdate { cell, row in
					if !row.isValid {
						
					}
			}
			<<< AlertRow<String>() { row in
				row.tag = trips_day_or_night
				row.title = trips_day_or_night
				row.selectorTitle = "When will the majority of your trip take place?"
				row.options = TRIPSFormFactory.dayOrNightBrackets()
				row.value = TRIPSFormFactory.dayOrNightBrackets()[0]
				row.add(rule: RuleRequired())
				}.onChange { row in
					print(row.value ?? "No Value")
				}.onPresent{ _, to in
					to.view.tintColor = .purple
				}.cellUpdate { cell, row in
					if !row.isValid {
						
					}
			}
			<<< AlertRow<String>() { row in
				row.tag = trips_nightly_sleep
				row.title = trips_nightly_sleep
				row.selectorTitle = "How much sleep will you have before you begin your trip?"
				row.options = TRIPSFormFactory.sleepBrackets()
				row.value = TRIPSFormFactory.sleepBrackets()[0]
				row.add(rule: RuleRequired())
				}.onChange { row in
					print(row.value ?? "No Value")
				}.onPresent{ _, to in
					to.view.tintColor = .purple
				}.cellUpdate { cell, row in
					if !row.isValid {
						
					}
			}
			<<< AlertRow<String>() { row in
				row.tag = trips_road
				row.title = trips_road
				row.selectorTitle = "What type of roads will you be travelling on?"
				row.options = TRIPSFormFactory.roadBrackets()
				row.value = TRIPSFormFactory.roadBrackets()[0]
				row.add(rule: RuleRequired())
				}.onChange { row in
					print(row.value ?? "No Value")
				}.onPresent{ _, to in
					to.view.tintColor = .purple
				}.cellUpdate { cell, row in
					if !row.isValid {
						
					}
			}
			<<< AlertRow<String>() { row in
				row.tag = trips_rest_stops
				row.title = trips_rest_stops
				row.selectorTitle = "Will you take rest stops?"
				row.options = TRIPSFormFactory.restStopBrackets()
				row.value = TRIPSFormFactory.restStopBrackets()[0]
				row.add(rule: RuleRequired())
				}.onChange { row in
					print(row.value ?? "No Value")
				}.onPresent{ _, to in
					to.view.tintColor = .purple
				}.cellUpdate { cell, row in
					if !row.isValid {
						
					}
			}
			<<< AlertRow<String>() { row in
				row.tag = trips_alcohol
				row.title = trips_alcohol
				row.selectorTitle = "Will you consume any alcohol 8 hours before or during your trip?"
				row.options = TRIPSFormFactory.alcoholBrackets()
				row.value = TRIPSFormFactory.alcoholBrackets()[0]
				row.add(rule: RuleRequired())
				}.onChange { row in
					print(row.value ?? "No Value")
				}.onPresent{ _, to in
					to.view.tintColor = .purple
				}.cellUpdate { cell, row in
					if !row.isValid {
						
					}
			}
			<<< AlertRow<String>() { row in
				row.tag = trips_weather
				row.title = trips_weather
				row.selectorTitle = "Will you check the weather prior to departure?"
				row.options = TRIPSFormFactory.weatherBrackets()
				row.value = TRIPSFormFactory.weatherBrackets()[0]
				row.add(rule: RuleRequired())
				}.onChange { row in
					print(row.value ?? "No Value")
				}.onPresent{ _, to in
					to.view.tintColor = .purple
				}.cellUpdate { cell, row in
					if !row.isValid {
						
					}
			}
			<<< AlertRow<String>() { row in
				row.tag = trips_rv
				row.title = trips_rv
				row.selectorTitle = "Are you pulling a Recreational Vehicle (RV) or trailer?"
				row.options = TRIPSFormFactory.rvBrackets()
				row.value = TRIPSFormFactory.rvBrackets()[0]
				row.add(rule: RuleRequired())
				}.onChange { row in
					print(row.value ?? "No Value")
				}.onPresent{ _, to in
					to.view.tintColor = .purple
				}.cellUpdate { cell, row in
					if !row.isValid {
						
					}
			}
	}
}
