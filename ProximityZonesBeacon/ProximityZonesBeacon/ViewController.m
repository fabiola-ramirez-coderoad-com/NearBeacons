//
//  ViewController.m
//  ProximityZonesBeacon
//
//  Created by Fabiola Ramirez on 7/22/15.
//  Copyright (c) 2015 Fabiola Ramirez. All rights reserved.
//

#import "ViewController.h"
#import <EstimoteSDK/EstimoteSDK.h>


#define BEACON_1_UUID @"B9407F30-F5F8-466E-AFF9-25556B57FE6D"
#define BEACON_1_MAJOR 51134
#define BEACON_1_MINOR 6459

BOOL isBeaconWithUUIDMajorMinor(CLBeacon *beacon, NSString *UUIDString, CLBeaconMajorValue major, CLBeaconMinorValue minor) {
    return [beacon.proximityUUID.UUIDString isEqualToString:UUIDString] && beacon.major.unsignedShortValue == major && beacon.minor.unsignedShortValue == minor;
}

@interface ViewController ()<ESTBeaconManagerDelegate>

@property (nonatomic, strong) CLBeacon *beacon;
@property (nonatomic, strong) ESTBeaconManager *beaconManager;
@property (nonatomic, strong) CLBeaconRegion *beaconRegion;


@property (weak, nonatomic) IBOutlet UILabel *titleLabel;




@end

@implementation ViewController



- (id)initWithBeacon:(CLBeacon *)beacon
{
    NSLog(@" entra initWithBeacon");
    
    self = [super init];
    if (self)
    {
        self.beacon = beacon;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
     NSLog(@" entra viewDidLoad");
    
   // self.beaconManager = [[ESTBeaconManager alloc] init];
    
    self.beaconManager = [ESTBeaconManager new];
    self.beaconManager.delegate = self;
    
    
    self.beaconManager.returnAllRangedBeaconsAtOnce = YES;
    
    [self.beaconManager requestWhenInUseAuthorization];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    /*self.beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:self.beacon.proximityUUID
                                                                major:[self.beacon.major unsignedIntValue]
                                                                minor:[self.beacon.minor unsignedIntValue]
                                                           identifier:@"RegionIdentifier"];
    */
    self.beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:[[NSUUID alloc] initWithUUIDString:BEACON_1_UUID] major:BEACON_1_MAJOR minor:BEACON_1_MINOR identifier:@"beaconRegion1"];
    
    
    NSLog(@"del beacon su UUID :%@",self.beacon.proximityUUID);
    NSLog(@"del beacon su major :%i",[self.beacon.major unsignedIntValue]);
    NSLog(@"del beacon su minor :%i",[self.beacon.minor unsignedIntValue]);
    
    [self.beaconManager startRangingBeaconsInRegion:self.beaconRegion];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.beaconManager startRangingBeaconsInRegion:self.beaconRegion];
   
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.beaconManager stopRangingBeaconsInRegion:self.beaconRegion];
    
    
}


#pragma mark - ESTBeaconManager delegate

- (void)beaconManager:(id)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region
{
    
    
    
    if (beacons.count > 0)
    {
        
        
        CLBeacon *fBeacon = [beacons firstObject];
        
        _titleLabel.text  = [self textForProximity:fBeacon.proximity];
        
        NSLog(@" titleLabel:%@",_titleLabel.text);
        
        
        [self.view setBackgroundColor:[self cForProximity:fBeacon.proximity]];
    }
}

#pragma mark -

- (NSString *)textForProximity:(CLProximity)proximity
{
    
    
    switch (proximity) {
        case CLProximityFar:
            return @"Far";
            break;
        case CLProximityNear:
            return @"Near";
            break;
        case CLProximityImmediate:
            return @"Immediate";
            break;
        case CLProximityUnknown:
            return @"Unknown";
            break;
        default:
            return @"";
            break;
    }
}


- (UIColor *)cForProximity:(CLProximity)proximity
{
    switch (proximity) {
        case CLProximityFar:
            return [UIColor colorWithRed:(230/255.0) green:(126/255.0) blue:(34/255.0) alpha:1];
            break;
        case CLProximityNear:
            return [UIColor colorWithRed:(241/255.0) green:(196/255.0) blue:(15/255.0) alpha:1];
            break;
        case CLProximityImmediate:
            return [UIColor colorWithRed:(46/255.0) green:(204/255.0) blue:(113/255.0) alpha:1];
            break;
        case CLProximityUnknown:
            return [UIColor colorWithRed:(231/255.0) green:(76/255.0) blue:(60/255.0) alpha:1];
            break;
        default:
            return [UIColor whiteColor];
            break;
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
