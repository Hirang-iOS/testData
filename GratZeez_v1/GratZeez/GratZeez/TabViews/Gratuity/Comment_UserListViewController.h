//
//  Comment_UserListViewController.h
//  GratZeez
//
//  Created by cloudZon Infosoft on 08/01/14.
//  Copyright (c) 2014 cloudZon Infosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import  "Constant.h"
#import "CommentListViewController.h"
@interface Comment_UserListViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property(strong,nonatomic) NSMutableArray *commentedUserListArray;
@property (strong, nonatomic) IBOutlet UIToolbar *commentListToolbar;
@end
