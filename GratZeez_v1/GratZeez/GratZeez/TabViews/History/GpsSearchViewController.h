//
//  GpsSearchViewController.h
//  GratZeez
//
//  Created by cloudZon Infosoft on 31/10/13.
//  Copyright (c) 2013 cloudZon Infosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchedResultViewController.h"
#import "GPSManuallySearchViewController.h"
#import "HelpViewController.h"
#import <CoreText/CoreText.h>
@interface GpsSearchViewController : UIViewController<CLLocationManagerDelegate>
{
    CLLocationManager *locationManager;
    NSDictionary *coordinateDictionary;
}
- (IBAction)searchLocation:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btn_manually;
- (IBAction)locateManually:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btn_nearestLocation;
@property (strong, nonatomic) IBOutlet UIToolbar *mainToolBar;
@property (strong, nonatomic) IBOutlet UIButton *requestForRegister;


@end
