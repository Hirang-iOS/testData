//
//  MapObjects.m
//  GratZeez
//
//  Created by cloudZon Infosoft on 18/11/13.
//  Copyright (c) 2013 cloudZon Infosoft. All rights reserved.
//

#import "MapObjects.h"

@implementation MapObjects
@synthesize title,subtitle,coordinate;

-(MapObjects *)initwithCoordinate:(CLLocationCoordinate2D)coordinate title:(NSString *)title subtitle:(NSString *)subtitle{
    
    if(self==[super init]){
        
        self.title=title;
        self.subtitle=subtitle;
        self.coordinate=coordinate;
        
    }
    return self;
}

@end
