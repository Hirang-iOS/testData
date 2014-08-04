//
//  SearchResultViewController.h
//  GratZeez
//
//  Created by cloudZon Infosoft on 23/10/13.
//  Copyright (c) 2013 cloudZon Infosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DYRateView.h"
#import "SearchedProfileViewController.h"
#import "HelpViewController.h"
#import "Constant.h"
@interface SearchResultViewController : UITableViewController <DYRateViewDelegate>
{
    
    NSMutableDictionary *searchResultDict;
    NSMutableArray *tempArray;
    NSString *service_providerId;
}
@property (strong, nonatomic) IBOutlet UIToolbar *searchResultToolbar;
@property(strong,nonatomic)NSArray *tempArray;
@end
