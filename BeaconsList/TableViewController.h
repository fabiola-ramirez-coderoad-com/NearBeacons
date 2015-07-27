//
//  TableViewController.h
//  BeaconsList
//
//  Created by Fabiola Ramirez on 7/21/15.
//  Copyright (c) 2015 Fabiola Ramirez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <EstimoteSDK/EstimoteSDK.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreBluetooth/CoreBluetooth.h>
@interface TableViewController : UITableViewController

typedef enum : int
{
    ESTScanTypeBluetooth,
    ESTScanTypeBeacon
    
} ESTScanType;



//Selected beacon is returned on given completion handler.

- (id)initWithScanType:(ESTScanType)scanType completion:(void (^) (id))completion;



@end
