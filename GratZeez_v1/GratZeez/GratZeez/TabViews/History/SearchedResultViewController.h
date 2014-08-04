//
//  SearchedResultViewController.h
//  GratZeez
//
//  Created by cloudZon Infosoft on 29/01/14.
//  Copyright (c) 2014 cloudZon Infosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DYRateView.h"
#import "SearchedProfileViewController.h"
#import "HelpViewController.h"
#import "Constant.h"
@interface SearchedResultViewController : UIViewController<DYRateViewDelegate>
{
    
    NSMutableDictionary *searchResultDict;
    NSMutableArray *tempArray;
    NSString *service_providerId;
}
@property (strong, nonatomic) IBOutlet UIToolbar *searchResultToolbar;
@property(strong,nonatomic)NSArray *tempArray;
@end