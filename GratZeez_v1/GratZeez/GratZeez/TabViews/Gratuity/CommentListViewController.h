//
//  CommentListViewController.h
//  GratZeez
//
//  Created by cloudZon Infosoft on 08/01/14.
//  Copyright (c) 2014 cloudZon Infosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"
@interface CommentListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    CGSize size ;
}
@property (strong, nonatomic) IBOutlet UIImageView *commentListProImage;
@property(strong,nonatomic) NSString *imageString;
@property (strong, nonatomic) IBOutlet UILabel *lbl_name;
@property(strong,nonatomic)NSString *nameString;
@property(strong,nonatomic) NSMutableArray *commentListArray;
@property (strong, nonatomic) IBOutlet UIToolbar *commentToolbar;
@end
