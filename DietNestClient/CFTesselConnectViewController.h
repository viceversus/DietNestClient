//
//  ViewController.h
//  DietNestClient
//
//  Created by Ken Shimizu on 9/9/15.
//  Copyright (c) 2015 Carbon Five. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CFTesselConnectViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *zeroButton;
@property (weak, nonatomic) IBOutlet UIButton *oneButton;
@property (nonatomic, assign) BOOL isConnected;
- (IBAction)sendZero:(id)sender;
- (IBAction)sendOne:(id)sender;

@end

