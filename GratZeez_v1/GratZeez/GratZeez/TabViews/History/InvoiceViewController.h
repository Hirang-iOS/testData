//
//  InvoiceViewController.h
//  GratZeez
//
//  Created by cloudZon Infosoft on 13/02/14.
//  Copyright (c) 2014 cloudZon Infosoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InvoiceViewController : UIViewController<UIScrollViewDelegate>
@property (strong,nonatomic) NSString *receiverName;
@property(strong,nonatomic) NSString *amountPaid;
@property(strong,nonatomic)NSString *date;
- (IBAction)receiverProfileAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIToolbar *invoiceToolbar;
@property (strong, nonatomic) IBOutlet UILabel *lbl_gratuityGiven;
@property (strong, nonatomic) IBOutlet UILabel *lbl_amountPaid;
@property (strong, nonatomic) IBOutlet UILabel *lbl_Ondate;
@property (strong, nonatomic) IBOutlet UIButton *btn_receiver;
@property (strong, nonatomic) IBOutlet UILabel *lbl_amount;
@property (strong, nonatomic) IBOutlet UILabel *lbl_date;
@property (strong, nonatomic) IBOutlet UILabel *lbl_gratuityAmount;
@property (strong, nonatomic) IBOutlet UILabel *lbl_gratuity;
@property (strong,nonatomic) NSString *gratuity;
- (IBAction)okAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *img;
@property (strong, nonatomic) IBOutlet UILabel *lbl_fromaccount;

@end
