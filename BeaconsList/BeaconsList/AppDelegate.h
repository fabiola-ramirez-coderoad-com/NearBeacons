//
//  AppDelegate.h
//  BeaconsList
//
//  Created by Fabiola Ramirez on 7/21/15.
//  Copyright (c) 2015 Fabiola Ramirez. All rights reserved.
//
#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#import <UIKit/UIKit.h>
#import <EstimoteSDK/EstimoteSDK.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreBluetooth/CoreBluetooth.h>


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@end

