//
//  ExsitingCharityViewController.h
//  GratZeez
//
//  Created by cloudZon Infosoft on 02/12/13.
//  Copyright (c) 2013 cloudZon Infosoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExsitingCharityViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    NSMutableArray *dataArray,*tempArray,*searchResultArray,*nameSearchArray;
    BOOL search;
    NSMutableDictionary *dataDict;
    CGPoint originalCenter;
    NSString *charityId;
    CGRect frame1;
    int j;
    NSMutableArray *searchedName;
}
@property(strong,nonatomic) NSString *charityId;
@property(strong,nonatomic) NSMutableDictionary *dataDict;
@property (strong, nonatomic) IBOutlet UITableView *charityTable;
@property (strong, nonatomic) IBOutlet UITextField *txtCharityName;
@property (strong, nonatomic) IBOutlet UITextField *txtCharityMail;
@property (strong, nonatomic) IBOutlet UITextField *txtGratuity;
- (IBAction)enableTextFieldAction:(id)sender;
@property (strong, nonatomic) IBOutlet UISearchBar *charitySearchBar;
@end
