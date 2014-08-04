//
//  ServiceProviderDetailHistoryViewController.h
//  GratZeez
//
//  Created by cloudZon Infosoft on 30/12/13.
//  Copyright (c) 2013 cloudZon Infosoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ServiceProviderDetailHistoryViewController : UIViewController
@property(strong,nonatomic) NSMutableArray *detailHistoryDataArray;
@property (strong, nonatomic) IBOutlet UILabel *lbl_sender;

@end
