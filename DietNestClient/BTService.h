//
//  BTService.h
//  Arduino_Servo
//
//  Created by Owen Lacy Brown on 5/21/14.
//  Copyright (c) 2014 Razeware LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

/* Services & Characteristics UUIDs */
/* @"E80F9957-714D-91B6-0986-7BC9DA1BF607" */
/* @"08C8C7A0-6CC5-11E3-981F-0800200C9A66" */
#define RWT_BLE_SERVICE_UUID		        [CBUUID UUIDWithString:@"08C8C7A0-6CC5-11E3-981F-0800200C9A66"]
#define RWT_TESSEL_WRITE_SERVICE_UUID		[CBUUID UUIDWithString:@"D752C5FB-1380-4CD5-B0EF-CAC7D72CFF20"]

/* Notifications */
static NSString* const RWT_BLE_SERVICE_CHANGED_STATUS_NOTIFICATION = @"kBLEServiceChangedStatusNotification";

/* BTService */
@interface BTService : NSObject <CBPeripheralDelegate>

- (instancetype)initWithPeripheral:(CBPeripheral *)peripheral;
- (void)reset;
- (void)startDiscoveringServices;

- (void)triggerMotor:(int)power;
- (void)triggerMoment;

@end
