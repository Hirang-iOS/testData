//
//  WorkLocationDetailsViewController.h
//  GratZeez
//
//  Created by cloudZon Infosoft on 26/11/13.
//  Copyright (c) 2013 cloudZon Infosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WorkDetailCell.h"
#import "MapViewController.h"
#import "Constant.h"
@protocol WorkLocationDetailViewDelegate <NSObject>
@required
-(void)organizationInfo:(NSString *) organization_id name:(NSString *)name tag:(int )tag;

@end
@interface WorkLocationDetailsViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UINavigationBarDelegate>
{
    IBOutlet UITableView *workLocationTableView;
    IBOutlet UISearchBar *workLocationSearchBar;
    NSMutableArray *workDetailArray,*tempDataArray,*searchArray,*searchResultArray;
    BOOL search;
    int lblTag;
    NSString *establishId;
}
@property(assign,nonatomic) BOOL isFromEditProfile_WorkDetail;
@property(nonatomic,assign)int lblTag;
@property(nonatomic,strong)NSString *establishId;
@property(nonatomic,assign)id<WorkLocationDetailViewDelegate> delegate;
@property(nonatomic,retain)NSMutableArray *workDetailArray;
@property (strong, nonatomic) IBOutlet UIToolbar *workToolbar;
@end
