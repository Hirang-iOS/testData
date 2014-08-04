//
//  MapObjects.h
//  GratZeez
//
//  Created by cloudZon Infosoft on 18/11/13.
//  Copyright (c) 2013 cloudZon Infosoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@interface MapObjects : NSObject<MKMapViewDelegate,MKAnnotation>
{
    NSString *title,*subtitle;
    CLLocationCoordinate2D coordinate;
}
@property(nonatomic,retain)NSString *title,*subtitle;
@property(nonatomic) CLLocationCoordinate2D coordinate;
-(MapObjects *)initwithCoordinate:(CLLocationCoordinate2D)coordinate title:(NSString *)title subtitle:(NSString *)subtitle;
@end
