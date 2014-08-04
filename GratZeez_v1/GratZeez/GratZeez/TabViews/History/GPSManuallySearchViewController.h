//
//  GPSManuallySearchViewController.h
//  GratZeez
//
//  Created by cloudZon Infosoft on 07/11/13.
//  Copyright (c) 2013 cloudZon Infosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchResultViewController.h"
#import "HelpViewController.h"
#import "Constant.h"
@interface GPSManuallySearchViewController : UIViewController{
    NSMutableArray *searchedResult,*tempData,*tempSearchResult;
    NSMutableDictionary *locateManually;
    BOOL search;
}
@property (retain, nonatomic) IBOutlet UISearchBar *searchbar;
@property (retain, nonatomic) IBOutlet UITableView *searchTable;
@property(retain,nonatomic)NSMutableDictionary *locateManually;
@property (strong, nonatomic) IBOutlet UIToolbar *gpsSearchToolbar;
@property(retain,nonatomic)NSMutableArray *searchedResult,*tempData;
@end
