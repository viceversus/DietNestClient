//
//  ViewController.h
//  DietNestClient
//
//  Created by Ken Shimizu on 9/9/15.
//  Copyright (c) 2015 Carbon Five. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface CFTesselConnectViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIButton *stopButton;
@property (weak, nonatomic) IBOutlet UIButton *momentButton;
@property (weak, nonatomic) IBOutlet UIPickerView *hourPicker;
@property (weak, nonatomic) IBOutlet UIPickerView *minutePicker;
@property (weak, nonatomic) IBOutlet UIPickerView *secondsPicker;

@property (nonatomic, assign) BOOL isConnected;
- (IBAction)disableMotor:(id)sender;
- (IBAction)activateMotor:(id)sender;
- (IBAction)triggerMoment:(id)sender;

@end

