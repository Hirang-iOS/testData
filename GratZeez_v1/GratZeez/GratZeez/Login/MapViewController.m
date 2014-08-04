//
//  MapViewController.m
//  GratZeez
//
//  Created by cloudZon Infosoft on 18/11/13.
//  Copyright (c) 2013 cloudZon Infosoft. All rights reserved.
//

#import "MapViewController.h"
@interface MapViewController ()

@end

@implementation MapViewController
@synthesize mapView,coordinate,city,landmark,lbl_instruction,mapToolbar,islblHide;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)setTitle:(NSString *)title {
    //    [super setTitle:title];
    UILabel *titleView = (UILabel *)self.navigationItem.titleView;
    if (!titleView) {
        titleView = [[UILabel alloc] initWithFrame:CGRectZero];
        titleView.backgroundColor = [UIColor clearColor];
        titleView.font = [UIFont fontWithName:@"Garamond 3 SC" size:20.0];
        titleView.textColor = [UIColor whiteColor];
        self.navigationItem.titleView = titleView;
    }
    titleView.text = title;
    [titleView sizeToFit];
}



- (void)viewDidLoad
{
    [super viewDidLoad];

    isDragEnable=FALSE;
    self.title=@"Location Preview";
    NSLog(@"latitiude of...%f",coordinate.latitude);
    map=[[MapObjects alloc]initwithCoordinate:coordinate title:city subtitle:landmark];
    self.edgesForExtendedLayout=UIRectEdgeNone;
    [self.mapView addAnnotation:map];
    
    MKCoordinateRegion viewRegion;
    viewRegion.center.latitude=coordinate.latitude;
    viewRegion.center.longitude=coordinate.longitude;
    
    viewRegion.span.latitudeDelta=0.2;
    viewRegion.span.longitudeDelta=0.2;
    [self.mapView setRegion:viewRegion animated:YES];
    if(islblHide==0){
    UIBarButtonItem *drag=[[UIBarButtonItem alloc]initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(SavePinAction:)];
    self.navigationItem.rightBarButtonItem=drag;
        lbl_instruction.hidden=NO;
    }
    else{
        lbl_instruction.hidden=YES;
    }
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    [[UIBarButtonItem appearance] setTitleTextAttributes:textAttributesTabBar forState:UIControlStateNormal];

    mapToolbar.frame=CGRectMake(0, 524, 320, 44);
    [self.view addSubview:mapToolbar];
    UIButton *backBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 36, 21)];
    [backBtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    UIBarButtonItem *btnitem=[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    mapToolbar.items=@[btnitem];
    [mapToolbar setBackgroundImage:toolBarImage forToolbarPosition:UIBarPositionBottom barMetrics:UIBarMetricsDefault];
    [self addLeftMenuButtonWithImage:[UIImage imageNamed:@"menu_icon"]];
    UISwipeGestureRecognizer *rightRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(backAction:)];
    rightRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [rightRecognizer setNumberOfTouchesRequired:1];
    [self.view addGestureRecognizer:rightRecognizer];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewDidAppear:(BOOL)animated{
    NSLog(@"%f",mapToolbar.frame.origin.y);
}
-(IBAction)backAction:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)viewWillAppear:(BOOL)animated{
    isDragEnable=TRUE;
    
}

-(IBAction)SavePinAction:(id)sender
{
    NSLog(@"clicked");
    [_delegate changeLatLong:droppedAt flag:1];
    [self.navigationController popViewControllerAnimated:YES];

   // isDragEnable=TRUE;
}
- (void)mapView:(MKMapView *)mapView
 annotationView:(MKAnnotationView *)annotationView
didChangeDragState:(MKAnnotationViewDragState)newState
   fromOldState:(MKAnnotationViewDragState)oldState
{
    if (newState == MKAnnotationViewDragStateEnding)
    {
        droppedAt = annotationView.annotation.coordinate;
        map.coordinate=droppedAt;
        [self reverseGeoCode:droppedAt];
      
        //annotationView.rightCalloutAccessoryView=saveButton;
            //  map.subtitle=[NSString stringWithFormat:@"latitiude %f ,longitude %f",droppedAt.latitude,droppedAt.longitude];
        NSLog(@"Pin dropped at %f,%f", droppedAt.latitude, droppedAt.longitude);
    }
}

-(IBAction)saveLatLong:(id)sender{
   }

-(void)changeLatLong:(CLLocationCoordinate2D)coordinateChange{
    
}

-(void)reverseGeoCode:(CLLocationCoordinate2D)coordinateGeo{
    CLGeocoder *geocoder=[[CLGeocoder alloc]init];


    CLLocation *loc=[[CLLocation alloc]initWithLatitude:coordinateGeo.latitude
                                              longitude:coordinate.longitude];       //sanala rd=22.8155805,70.83208430000001 , CA=:37.685830,-122.406417
    
    [geocoder reverseGeocodeLocation:loc completionHandler:^(NSArray *placemarks, NSError *error) {
        NSLog(@"reverseGeocodeLocation:completionHandler: Completion Handler called!");
        
        if (error){
            NSLog(@"Geocode failed with error: %@", error);
            
            return;
        }
        if(placemarks && placemarks.count > 0)
        {
            //do something
            CLPlacemark *topResult = [placemarks objectAtIndex:0];
            
            NSString *addressTxt = [NSString stringWithFormat:@"Name:%@ throughfare:%@, subthroug:%@ locality:%@ sublocality:%@, administrativeArea:%@, subAdmini:%@, posta:%@, ISOCOunty:%@, country:%@, inland:%@, ocean:%@, area of int:%@",[topResult name],
                                    [topResult thoroughfare],[topResult subThoroughfare],
                                    [topResult locality],[topResult subLocality], [topResult administrativeArea],[topResult subAdministrativeArea],[topResult postalCode],[topResult ISOcountryCode],[topResult country],[topResult inlandWater],[topResult ocean],[topResult areasOfInterest]];
            NSLog(@"ADDRESS %@",addressTxt);
            NSLog(@"maptitile%@",map.title);
            if([[topResult thoroughfare] length]<=0 && [[topResult thoroughfare] length]<=0){
                map.title=@"Location Name Not Found";
                map.subtitle=@"";
            }
            else{
            map.title=[topResult thoroughfare];
            map.subtitle=[topResult subThoroughfare];
            }}
    }];

}


/*- (void) createAnnotation
{
    for (id annotation in [mapView annotations])
    {
        if ([annotation isKindOfClass:[MKUserLocation class]])
        {
            continue;
        }
        [mapView removeAnnotation:annotation];
    }
    
    CLLocationDegrees latitude  = [searchLat doubleValue];
    CLLocationDegrees longitude = [searchLong doubleValue];
    
    CLLocation *searchLocation = [[[CLLocation alloc] initWithLatitude:latitude longitude:longitude] autorelease];
    
    CLLocationCoordinate2D theCoordinate;
    theCoordinate.latitude = latitude;
    theCoordinate.longitude = longitude;
    
    DDAnnotation *annotation = [[DDAnnotation alloc] initWithCoordinate:searchLocation.coordinate title:@""];
    annotation.title = @"Drag to Move Pin";
    annotation.subtitle = [NSString stringWithFormat:@"%f %f", annotation.coordinate.latitude, annotation.coordinate.longitude];
    
    MKCoordinateRegion region;
    region.span.longitudeDelta = 0.05;
    region.span.latitudeDelta  = 0.05;
    region.center = searchLocation.coordinate;
    [myMapView setRegion:region animated:YES];
    [myMapView regionThatFits:region];
    [myMapView addAnnotation:annotation];
} */
#pragma mark - MapView Delegate Methods

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    
    if([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    
    static NSString *identifier = @"myAnnotation";
    MKPinAnnotationView * annotationView = (MKPinAnnotationView*)[self.mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    if (!annotationView)
    {
        
        annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        annotationView.pinColor = MKPinAnnotationColorGreen;
        annotationView.animatesDrop = YES;
        annotationView.canShowCallout = YES;
        //        if (isDragEnable) {
//            annotationView.draggable=YES;
//        }
//        else{
//            annotationView.draggable=NO;
//        }
        if(islblHide==0){
        annotationView.draggable=YES;
        }
        else{
            annotationView.draggable=NO;
        }
       // annotationView.dr
    }
    else {
        annotationView.annotation = annotation;
    }
    //annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    return annotationView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
