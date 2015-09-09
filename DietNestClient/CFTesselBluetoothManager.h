//
//  CFTesselBluetoothManager.h
//  DietNestClient
//
//  Created by Ken Shimizu on 9/9/15.
//  Copyright (c) 2015 Carbon Five. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@class CBCentralManager;
@class CBPeripheral;

FOUNDATION_EXPORT NSString * const kTesselDataTransceivingServiceUUID;

typedef NS_ENUM(NSUInteger, CFTesselBluetoothStatus) {
    TesselBluetoothStatusUnknown = 0,
    TesselBluetoothStatusScanning,
    TesselBluetoothStatusDiscovered,
    TesselBluetoothStatusConnected,
    TesselBluetoothStatusDisconnected,
    TesselBluetoothStatusReconnecting,
    TesselBluetoothStatusConnectionFailed
};

@protocol CFTesselBluetoothManagerDelegate <NSObject>

@required
- (void)didTurnOnBluetooth;
- (void)didChangeTesselConnectionStatus;
- (void)didLogEvent;
@end



@interface CFTesselBluetoothManager : NSObject <CBCentralManagerDelegate>

@property (weak, nonatomic) id<CFTesselBluetoothManagerDelegate> delegate;
@property (nonatomic, readonly) CBPeripheral *peripheral;
@property (nonatomic, readonly) CFTesselBluetoothStatus status;
@property (nonatomic, readonly) NSMutableArray *logHistory;


+ (NSString *)descriptionForStatus:(CFTesselBluetoothStatus)status;

- (instancetype)init __attribute__((unavailable("Use initWithCBCentralManager: instead")));
- (instancetype)initWithCBCentralManager:(CBCentralManager *)cbCentralManager;
- (void)scanAndConnectToTessel;
- (void)killConnection;
- (void)clearLogHistory;

@end
