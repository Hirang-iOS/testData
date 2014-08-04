//
//  GratuityViewController.m
//  GratZeez
//
//  Created by cloudZon Infosoft on 14/10/13.
//  Copyright (c) 2013 cloudZon Infosoft. All rights reserved.
//

#import "GratuityViewController.h"

@interface GratuityViewController ()

@end

@implementation GratuityViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Gratuity";
    
    if (!MyAppDelegate.session.isOpen) {
        [MyAppDelegate LoginRequired:nil];
    }
}

- (void)LoadData:(id)sender {
    //    type=homescreen&DisplayDtm=2013-05-20&DeviceID=%27test"
    
    NSString *strURL = [NSString stringWithFormat:@"%@type=homescreen&DisplayDtm=2013-05-20&DeviceID=%@",URLHomeScreen,@""];
    strURL = [strURL stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    
    
    ASIFormDataRequest *_request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:strURL]];
    __unsafe_unretained ASIFormDataRequest *request = _request;
    [request setDelegate:self];
    
    [request setCompletionBlock:^{
        NSDictionary *root = [NSJSONSerialization JSONObjectWithData:request.responseData options:0 error:nil];
        NSLog(@"==> ROOT: %@",root);
        if (![[root objectForKey:@"IsError"] boolValue]) {
            //            if (!MyAppDelegate.dictHomeVideo) {
            //                MyAppDelegate.dictHomeVideo = [[NSMutableDictionary alloc] init];
            //            } else {
            //                MyAppDelegate.dictHomeVideo = nil;
            //            }
            //            MyAppDelegate.dictHomeVideo = (NSMutableDictionary*)root;
            //
            //            NSString *strThumbURL = [NSString stringWithFormat:@"%@/%@",[root objectForKey:@"path"],[[[root objectForKey:@"Result"] objectForKey:@"Video"] objectForKey:@"ThumbnailImage"]];
            //            [titleImage setImageWithURL:[NSURL URLWithString:strThumbURL] placeholderImage:[UIImage imageNamed:@"Icon.png"]];
            
            NSLog(@"Loading URL: %@",[[[root objectForKey:@"Result"] objectForKey:@"Video"] objectForKey:@"URL"]);
        }
        else {
            [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                            type:AJNotificationTypeRed
                                           title:[root objectForKey:@"ErrorMessage"]
                                 linedBackground:AJLinedBackgroundTypeDisabled
                                       hideAfter:GZAJNotificationDelay];
        }
    }];
    [request setFailedBlock:^{
        NSError *error = [request error];
        [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                        type:AJNotificationTypeRed
                                       title:error.localizedDescription
                             linedBackground:AJLinedBackgroundTypeDisabled
                                   hideAfter:GZAJNotificationDelay];
    }];
    [request startAsynchronous];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
