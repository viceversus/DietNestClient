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

static NSArray *HOURS = nil;
static NSArray *MINUTES = nil;
static NSArray *SECONDS = nil;
NSNumber *hour;
NSNumber *minute;
NSNumber *second;
NSArray *components;

@synthesize hourPicker;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (HOURS == nil) {
        HOURS = @[@0, @1, @2, @3, @4, @5, @6, @7, @8, @9, @10, @11, @12, @13, @14, @15, @16, @17, @18, @19, @20, @21, @22, @23, @24];
        hour = HOURS[0];
    }
    if (MINUTES == nil) {
        MINUTES = @[@0, @1, @2, @3, @4, @5, @6, @7, @8, @9, @10, @11, @12, @13, @14, @15, @16, @17, @18, @19, @20, @21, @22, @23, @24, @25, @26, @27, @28, @29, @30,
                    @31, @32, @33, @34, @35, @36, @37, @38, @39, @40, @41, @42, @43, @44, @45, @46, @47, @48, @49, @50, @51, @52, @53, @54, @55, @56, @57, @58, @59];
        minute = MINUTES[0];
    }
    if (SECONDS == nil) {
        SECONDS= @[@0, @1, @2, @3, @4, @5, @6, @7, @8, @9, @10, @11, @12, @13, @14, @15, @16, @17, @18, @19, @20, @21, @22, @23, @24, @25, @26, @27, @28, @29, @30,
                   @31, @32, @33, @34, @35, @36, @37, @38, @39, @40, @41, @42, @43, @44, @45, @46, @47, @48, @49, @50, @51, @52, @53, @54, @55, @56, @57, @58, @59];
        second = SECONDS[0];
    }
    components = @[HOURS, MINUTES, SECONDS];
    
    // Watch Bluetooth connection
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(connectionChanged:) name:RWT_BLE_SERVICE_CHANGED_STATUS_NOTIFICATION object:nil];
    
    // Start the Bluetooth discovery process
    [BTDiscovery sharedInstance];
}

-(BOOL)shouldAutorotate {
    return NO;
}

-(void)disableMotor:(id)sender {
    [[[BTDiscovery sharedInstance] bleService] triggerMotor:0];
    [_stopButton setHidden:true];
    [_startButton setHidden:false];
    [_momentButton setHidden:true];
}

-(void)activateMotor:(id)sender {
    [[[BTDiscovery sharedInstance] bleService] triggerMotor:1];
    [_stopButton setHidden:false];
    [_startButton setHidden:true];
    [_momentButton setHidden:false];
}

-(void)triggerMoment:(id)sender {
    [[[BTDiscovery sharedInstance] bleService] triggerMoment];
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

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSArray *target = components[component];
    return [target count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component {
    NSArray *target = components[component];
    NSNumber *value = target[row];
    
    return [value stringValue];
}

- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSArray *target = components[component];
    NSNumber *value = target[row];
    NSAttributedString *attString = [[NSAttributedString alloc] initWithString:[value stringValue] attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    return attString;
    
}

@end
