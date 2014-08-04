//
//  GratuityReceiver.m
//  GratZeez
//
//  Created by cloudZon Infosoft on 21/10/13.
//  Copyright (c) 2013 cloudZon Infosoft. All rights reserved.
//

#import "GratuityReceiver.h"

@implementation GratuityReceiver

@synthesize userid;
@synthesize first_name;
@synthesize last_name;
@synthesize username;
@synthesize number;
@synthesize establishment;


+ (id)GratuietyReceiverWithUserid:(NSString*)userid
              firstname:(NSString*)first_name
               lastname:(NSString*)last_name
               username:(NSString*)username
                 number:(NSString*)number
          establishment:(NSString*)establishment {
    
    GratuityReceiver *newReceiver = [[self alloc] init];
    [newReceiver setUserid:userid];
    [newReceiver setFirst_name:first_name];
    [newReceiver setLast_name:last_name];
    [newReceiver setUsername:username];
    [newReceiver setNumber:number];
    [newReceiver setEstablishment:establishment];
    
    return newReceiver;
}

- (GratuityReceiver*)initWithDict:(NSDictionary*)dictGratuityReceiver {
    self = [super init];
    if (self) {
		self.userid = [dictGratuityReceiver objectForKey:@"userid"];
        self.first_name = [dictGratuityReceiver objectForKey:@"first_name"];
        self.last_name = [dictGratuityReceiver objectForKey:@"last_name"];
        self.username = [dictGratuityReceiver objectForKey:@"username"];
        self.number = [dictGratuityReceiver objectForKey:@"number"];
        self.establishment = [dictGratuityReceiver objectForKey:@"establishment"];
    }
    return self;
}


@end
