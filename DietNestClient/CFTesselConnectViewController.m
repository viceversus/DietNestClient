//
//  ViewController.m
//  DietNestClient
//
//  Created by Ken Shimizu on 9/9/15.
//  Copyright (c) 2015 Carbon Five. All rights reserved.
//

#import <CoreBluetooth/CoreBluetooth.h>
#import "CFTesselConnectViewController.h"
#import "CFTesselBluetoothManager.h"

@interface CFTesselConnectViewController () <CFTesselBluetoothManagerDelegate>
@property (nonatomic) CFTesselBluetoothManager *bluetoothManager;
@property (nonatomic) NSNumberFormatter *numberFormatter;
@property (nonatomic) NSTimer *connectionTimer;
@end

@implementation CFTesselConnectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CBCentralManager *centralManager = [[CBCentralManager alloc] initWithDelegate:nil queue:nil];
    self.bluetoothManager = [[CFTesselBluetoothManager alloc] initWithCBCentralManager:centralManager];
    self.bluetoothManager.delegate = self;
    [self.bluetoothManager scanAndConnectToTessel];
    [self didChangeTesselConnectionStatus];
}

- (void)didChangeTesselConnectionStatus {
    [self.connectionTimer invalidate];
    
    if (self.bluetoothManager.status == TesselBluetoothStatusReconnecting ||
        self.bluetoothManager.status == TesselBluetoothStatusScanning) {
        self.connectionTimer = [NSTimer timerWithTimeInterval:15
                                                       target:self
                                                     selector:@selector(askToKeepScanning:)
                                                     userInfo:nil
                                                      repeats:NO];
        [[NSRunLoop mainRunLoop] addTimer:self.connectionTimer forMode:NSDefaultRunLoopMode];
    }
}


- (void)askToKeepScanning:(NSTimer *)timer {
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Keep Scanning?"
                                                                        message:@"You've been scanning for your Tessel for 15 seconds. Would you like to keep searching?"
                                                                 preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *continueAction = [UIAlertAction actionWithTitle:@"Yes, continue scanning"
                                                             style:UIAlertActionStyleDefault
                                                           handler:nil];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"No, stop scanning"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction *action) {
                                                             [self.bluetoothManager killConnection];
                                                         }];
    [controller addAction:continueAction];
    [controller addAction:cancelAction];
    [self presentViewController:controller
                       animated:YES
                     completion:nil];
}

- (void)didLogEvent
{
    
}

- (void)didTurnOnBluetooth
{
    
}

@end
