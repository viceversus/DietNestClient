//
//  ViewController.m
//  DietNestClient
//
//  Created by Ken Shimizu on 9/9/15.
//  Copyright (c) 2015 Carbon Five. All rights reserved.
//

#import "CFTesselConnectViewController.h"
#import "BTDiscovery.h"
#import "BTService.h"

@implementation CFTesselConnectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Watch Bluetooth connection
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(connectionChanged:) name:RWT_BLE_SERVICE_CHANGED_STATUS_NOTIFICATION object:nil];
    
    // Start the Bluetooth discovery process
    [BTDiscovery sharedInstance];
}

-(void)sendZero:(id)sender {
    [[[BTDiscovery sharedInstance] bleService] writePosition:0];
}

-(void)sendOne:(id)sender {
    [[[BTDiscovery sharedInstance] bleService] writePosition:1];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:RWT_BLE_SERVICE_CHANGED_STATUS_NOTIFICATION object:nil];
}

- (void)connectionChanged:(NSNotification *)notification {
    // Connection status changed. Indicate on GUI.
    self.isConnected = [(NSNumber *) (notification.userInfo)[@"isConnected"] boolValue];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        // Set image based on connection status
        
        if (self.isConnected) {
            NSLog(@"I'm Connected");
        }
    });
}

@end
