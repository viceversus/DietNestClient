//
//  BTService.m
//  Arduino_Servo
//
//  Created by Owen Lacy Brown on 5/21/14.
//  Copyright (c) 2014 Razeware LLC. All rights reserved.
//

#import "BTService.h"


@interface BTService()
@property (strong, nonatomic) CBPeripheral *peripheral;
@property (strong, nonatomic) CBCharacteristic *motorCharacteristic;
@property (strong, nonatomic) CBCharacteristic *momentCharacteristic;
@end

@implementation BTService

#pragma mark - Lifecycle

- (instancetype)initWithPeripheral:(CBPeripheral *)peripheral {
    self = [super init];
    if (self) {
        self.peripheral = peripheral;
        [self.peripheral setDelegate:self];
    }
    return self;
}

- (void)dealloc {
    [self reset];
}

- (void)startDiscoveringServices {
    [self.peripheral discoverServices:nil];
}

- (void)reset {
    
    if (self.peripheral) {
        self.peripheral = nil;
    }
    
    // Deallocating therefore send notification
    [self sendBTServiceNotificationWithIsBluetoothConnected:NO];
}

#pragma mark - CBPeripheralDelegate

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error {
    NSArray *services = nil;
    
    if (peripheral != self.peripheral) {
        NSLog(@"Wrong Peripheral.\n");
        return ;
    }
    
    if (error != nil) {
        NSLog(@"Error %@\n", error);
        return ;
    }
    
    services = [peripheral services];
    if (!services || ![services count]) {
        NSLog(@"No Services");
        return ;
    }
    
    for (CBService *service in services) {
        if ([[service UUID] isEqual:RWT_TESSEL_WRITE_SERVICE_UUID]) {
            [peripheral discoverCharacteristics:nil forService:service];
        }
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error {
    NSArray *characteristics    = [service characteristics];
    
    if (peripheral != self.peripheral) {
        NSLog(@"Wrong Peripheral.\n");
        return ;
    }
    
    if (error != nil) {
        NSLog(@"Error %@\n", error);
        return ;
    }
    
    self.motorCharacteristic = characteristics[0];
    self.momentCharacteristic = characteristics[1];
    
    // Send notification that Bluetooth is connected and all required characteristics are discovered
    [self sendBTServiceNotificationWithIsBluetoothConnected:YES];
}


- (void)triggerMotor:(int)power {
    NSLog(@"Trigger Motor: %d", power);
    [self.peripheral writeValue:[NSData dataWithBytes:&power length:sizeof(power)] forCharacteristic:self.motorCharacteristic type:CBCharacteristicWriteWithResponse];
}

- (void)triggerMoment {
    int moment = 1;
    NSLog(@"Trigger Moment");
    [self.peripheral writeValue:[NSData dataWithBytes:&moment length:sizeof(moment)] forCharacteristic:self.momentCharacteristic type:CBCharacteristicWriteWithResponse];
}

#pragma mark - CBPeripheralDelegate

- (void) peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    NSLog([error description]);
}

#pragma mark - Private

- (void)sendBTServiceNotificationWithIsBluetoothConnected:(BOOL)isBluetoothConnected {
    NSDictionary *connectionDetails = @{@"isConnected": @(isBluetoothConnected)};
    [[NSNotificationCenter defaultCenter] postNotificationName:RWT_BLE_SERVICE_CHANGED_STATUS_NOTIFICATION object:self userInfo:connectionDetails];
}

@end
