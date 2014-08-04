//
//  MapViewController.h
//  GratZeez
//
//  Created by cloudZon Infosoft on 18/11/13.
//  Copyright (c) 2013 cloudZon Infosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "MapObjects.h"
#import "HelpViewController.h"
#import "Constant.h"
#import <CoreLocation/CoreLocation.h>
//#import "WorkLocationViewController.h"
@protocol MapViewDelegateMethods <NSObject>

@required
-(void)changeLatLong:(CLLocationCoordinate2D)coordinateChange flag:(int )flag;

@end

@interface MapViewController : UIViewController <MKMapViewDelegate>{
    CLLocationCoordinate2D coordinate,droppedAt;
    BOOL isDragEnable;
    MapObjects *map;
}
@property(nonatomic,assign)BOOL islblHide;
@property (strong, nonatomic) IBOutlet UILabel *lbl_instruction;
@property(nonatomic,retain)NSString *city;
@property(nonatomic,retain)NSString *landmark;
@property(nonatomic,assign)id<MapViewDelegateMethods> delegate;
@property(nonatomic,assign) CLLocationCoordinate2D coordinate;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutlet UIToolbar *mapToolbar;
@end
