//
//  CharityDetailViewController.h
//  GratZeez
//
//  Created by cloudZon Infosoft on 02/12/13.
//  Copyright (c) 2013 cloudZon Infosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"

@protocol CharityDetailViewDelegate <NSObject>

-(void)charityName:(NSString *)name mail:(NSString *)Email;
@end
@interface CharityDetailViewController : UIViewController<UITextFieldDelegate>
- (IBAction)charityContinueAction:(id)sender;
@property(weak,nonatomic) id<CharityDetailViewDelegate> delegate;
@property (strong, nonatomic) IBOutlet UITextField *txtCharityName;
@property (strong, nonatomic) IBOutlet UITextField *txtCharityEmail;
@property (strong, nonatomic) IBOutlet UIToolbar *charityToolBar;
@end
