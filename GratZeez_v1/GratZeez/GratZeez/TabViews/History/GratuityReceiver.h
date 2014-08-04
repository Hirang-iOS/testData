//
//  GratuityReceiver.h
//  GratZeez
//
//  Created by cloudZon Infosoft on 21/10/13.
//  Copyright (c) 2013 cloudZon Infosoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GratuityReceiver : NSObject {

    NSString *userid;
    NSString *first_name;
    NSString *last_name;
    NSString *username;
    NSString *number;
    NSString *establishment;

}
@property (nonatomic, copy) NSString *userid;
@property (nonatomic, copy) NSString *first_name;
@property (nonatomic, copy) NSString *last_name;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *number;
@property (nonatomic, copy) NSString *establishment;

+ (id)GratuietyReceiverWithUserid:(NSString*)userid
              firstname:(NSString*)first_name
               lastname:(NSString*)last_name
               username:(NSString*)username
                 number:(NSString*)number
          establishment:(NSString*)establishment;

- (GratuityReceiver*)initWithDict:(NSDictionary*)dictGratuityReceiver;


@end
