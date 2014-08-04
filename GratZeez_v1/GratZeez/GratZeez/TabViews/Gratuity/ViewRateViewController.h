//
//  ViewRateViewController.h
//  GratZeez
//
//  Created by cloudZon Infosoft on 06/01/14.
//  Copyright (c) 2014 cloudZon Infosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DYRateView.h"
#import "Constant.h"
@interface ViewRateViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray *tempArray;
}
@property (strong,nonatomic) NSMutableArray *rateListDataArray;
@property (strong, nonatomic) IBOutlet UIToolbar *viewRateToolbar;
@end
