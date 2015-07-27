//
//  ViewController.m
//  NearestBeacon
//
//  Created by Fabiola Ramirez on 7/23/15.
//  Copyright (c) 2015 Fabiola Ramirez. All rights reserved.
//

#import "ViewController.h"
#import <EstimoteSDK/EstimoteSDK.h>

#define BEACON_1_UUID @"B9407F30-F5F8-466E-AFF9-25556B57FE6D"
#define BEACON_1_MAJOR 51134
#define BEACON_1_MINOR 6459

#define BEACON_2_UUID @"B9407F30-F5F8-466E-AFF9-25556B57FE6D"
#define BEACON_2_MAJOR 21580
#define BEACON_2_MINOR 50459


#define BEACON_3_UUID @"B9407F30-F5F8-466E-AFF9-25556B57FE6D"
#define BEACON_3_MAJOR 3144
#define BEACON_3_MINOR 41160

BOOL isBeaconWithUUIDMajorMinor(CLBeacon *beacon, NSString *UUIDString, CLBeaconMajorValue major, CLBeaconMinorValue minor) {
    return [beacon.proximityUUID.UUIDString isEqualToString:UUIDString] && beacon.major.unsignedShortValue == major && beacon.minor.unsignedShortValue == minor;
}
@interface ViewController ()<ESTBeaconManagerDelegate>


@property (nonatomic) ESTBeaconManager *beaconManager;

@property (nonatomic) CLBeaconRegion *beaconRegion1;
@property (nonatomic) CLBeaconRegion *beaconRegion2;
@property (nonatomic) CLBeaconRegion *beaconRegion3;


@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.beaconManager = [ESTBeaconManager new];
    self.beaconManager.delegate = self;
    
    
    self.beaconManager.returnAllRangedBeaconsAtOnce = YES;
    
    [self.beaconManager requestWhenInUseAuthorization];
    
    self.beaconRegion1 = [[CLBeaconRegion alloc] initWithProximityUUID:[[NSUUID alloc] initWithUUIDString:BEACON_1_UUID] major:BEACON_1_MAJOR minor:BEACON_1_MINOR identifier:@"beaconRegion1"];
    self.beaconRegion2 = [[CLBeaconRegion alloc] initWithProximityUUID:[[NSUUID alloc] initWithUUIDString:BEACON_2_UUID] major:BEACON_2_MAJOR minor:BEACON_2_MINOR identifier:@"beaconRegion2"];
    self.beaconRegion3 = [[CLBeaconRegion alloc] initWithProximityUUID:[[NSUUID alloc] initWithUUIDString:BEACON_3_UUID] major:BEACON_3_MAJOR minor:BEACON_3_MINOR identifier:@"beaconRegion3"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.beaconManager startRangingBeaconsInRegion:self.beaconRegion1];
    [self.beaconManager startRangingBeaconsInRegion:self.beaconRegion2];
    [self.beaconManager startRangingBeaconsInRegion:self.beaconRegion3];}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [self.beaconManager stopRangingBeaconsInRegion:self.beaconRegion1];
    [self.beaconManager stopRangingBeaconsInRegion:self.beaconRegion2];
    [self.beaconManager stopRangingBeaconsInRegion:self.beaconRegion3];}

- (void)beaconManager:(id)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region {
    CLBeacon *nearestBeacon = [beacons firstObject];
    
    if (nearestBeacon) {
        if (isBeaconWithUUIDMajorMinor(nearestBeacon, BEACON_1_UUID, BEACON_1_MAJOR, BEACON_1_MINOR)) {
            
            
            // beacon #1
            self.label.text = @"Purple Beacon!";
            [self.view setBackgroundColor:[UIColor colorWithRed:(126/255.0) green:(87/255.0) blue:(194/255.0) alpha:1]] ;
            
        } else if (isBeaconWithUUIDMajorMinor(nearestBeacon, BEACON_2_UUID, BEACON_2_MAJOR, BEACON_2_MINOR)) {
            // beacon #2
            self.label.text = @"Green Beacon!";
            [self.view setBackgroundColor:[UIColor colorWithRed:(197/255.0) green:(225/255.0) blue:(165/255.0) alpha:1]] ;
        }
        else if (isBeaconWithUUIDMajorMinor(nearestBeacon, BEACON_3_UUID, BEACON_3_MAJOR, BEACON_3_MINOR)) {
            // beacon #3
            self.label.text = @"Blue Beacon!";
            [self.view setBackgroundColor:[UIColor colorWithRed:(187/255.0) green:(222/255.0) blue:(251/255.0) alpha:1]] ;
        }
    }else {
        // no beacons found
        self.label.text = @"There are no beacons nearby";
       
    }
    
    
}

- (void)beaconManager:(id)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    if (status == kCLAuthorizationStatusDenied || status == kCLAuthorizationStatusRestricted) {
        NSLog(@"Location Services authorization denied, can't range");
    }
}

- (void)beaconManager:(id)manager rangingBeaconsDidFailForRegion:(CLBeaconRegion *)region withError:(NSError *)error {
    NSLog(@"Ranging beacons failed for region '%@'\n\nMake sure that Bluetooth and Location Services are on, and that Location Services are allowed for this app. Also note that iOS simulator doesn't support Bluetooth.\n\nThe error was: %@", region.identifier, error);
}


@end
