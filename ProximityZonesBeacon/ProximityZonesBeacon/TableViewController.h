//
//  TableViewController.h
//  ProximityZonesBeacon
//
//  Created by Fabiola Ramirez on 7/22/15.
//  Copyright (c) 2015 Fabiola Ramirez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <EstimoteSDK/EstimoteSDK.h>

@interface TableViewController : UITableViewController


- (id)initWithBeacon:(CLBeacon *)beacon;

@end
