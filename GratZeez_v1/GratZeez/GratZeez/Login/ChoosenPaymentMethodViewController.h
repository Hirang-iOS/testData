//
//  ChoosenPaymentMethodViewController.h
//  GratZeez
//
//  Created by cloudZon Infosoft on 26/12/13.
//  Copyright (c) 2013 cloudZon Infosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"
@interface ChoosenPaymentMethodViewController : UIViewController
- (IBAction)continueAction:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *txt_paypal;

@end
