//
//  RadioButtonView.h
//  GratZeez
//
//  Created by cloudZon Infosoft on 14/11/13.
//  Copyright (c) 2013 cloudZon Infosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "ServiceProviderProfileViewController.h"
//@class RegistrationViewController;
@class ServiceProviderProfileViewController;

@protocol RadioButtonDelegate <NSObject>

@required
-(void) buttonWasActivated:(int) buttonTag;

@end




@interface RadioButtonView : UIView
{
    NSMutableArray *radioButtons;
    NSMutableArray *payPalRadioButton;
    
}
@property (nonatomic, assign) id<RadioButtonDelegate> delegate;
@property(nonatomic,assign)NSInteger genderButtonIndex;
@property (nonatomic,retain) NSMutableArray *radioButtons;
@property(nonatomic,retain)NSMutableArray *payPalRadioButton;
@property(nonatomic,weak) ServiceProviderProfileViewController *svc;
- (id)initWithFrame:(CGRect)frame andOptions:(NSArray *)options andColumns:(int)columns;
- (id)initWithPayPalFrame:(CGRect)frame andOptions:(NSArray *)options andColumns:(int)columns tag:(int)tag;
-(IBAction) radioButtonClicked:(UIButton *) sender;
-(IBAction) payPalRadioButtonClicked:(UIButton *) sender;
-(void) removeButtonAtIndex:(int)index;
-(void) setSelected:(int) index;
-(void)clearAll;
-(void)setPayPalSelected:(int)index;
@end
