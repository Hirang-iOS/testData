//
//  ServiceProviderProfileViewController.h
//  GratZeez
//
//  Created by cloudZon Infosoft on 09/11/13.
//  Copyright (c) 2013 cloudZon Infosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RadioButtonView.h"
#import "WorkLocationViewController.h"
#import "WorkLocationDetailsViewController.h"
#import "HelpViewController.h"
#import "CharityDetailViewController.h"
#import "Base64.h"
#import "EstablishmentViewController.h"
#import "ChoosenPaymentMethodViewController.h"
#import <CoreText/CoreText.h>
@class RadioButtonView;
@class WorkLocationDetailsViewController;

@interface ServiceProviderProfileViewController : UIViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate,RadioButtonDelegate,UIPickerViewDelegate,UIPickerViewDataSource,CharityDetailViewDelegate,UITextFieldDelegate,WorkLocationDetailViewDelegate,WorkLocationViewDelegate>
{
    NSString *gratuityStr,*paymentStr;
    RadioButtonView *gratuityGroup,*paymentGroup;
    IBOutlet UILabel *usernameLabel;
    NSString *gratuitySelection,*receivePayment;
    WorkLocationDetailsViewController *WorkVC;
    UIPickerView *charityPicker;
    UIView *picker_view;

    UIView *subview;
    NSMutableArray *searchedName;
    NSString *charityId,*charityName,*charityEmail,*charityPercentage;
    NSMutableArray *dataArray;
    NSInteger labeltapped;
   // NSString *isWorkLocationEntered;
    IBOutlet UIView *charityView,*charityBoxView,*ratingView;
    
    IBOutlet UILabel *lbl_workInfo;
    
    int number_of_textfields;
    float space_between_textfield;
    float frame_y;
    float height_of_component,width_of_lbl;
    
    
    IBOutlet UILabel *lblEstablishment;
    UIPickerView *establishPicker;
    UILabel *firstlbl,*lbl1,*lbl2,*worklocation_lbl,*worklocation_lbl1,*worklocation_lbl2;
    UIButton *btn,*rm1,*rm2;
    UITextField *txt,*txt1,*txt2;
    //NSMutableArray *pickerDataArray,*exsitingWorkArray;
    NSMutableArray *establishTypeDataArray;
    NSMutableDictionary *establsihTypeDataDictionary;
    NSString *establishmentId1,*establishmentId2,*establishmentId3,*workLocationId1,*workLocationId2,*workLocationId3,*organizationString,*establishmnetString;
    
    NSInteger pickerDisplayindex1,pickerDisplayindex2,pickerDisplayindex3,pickerRow;
    
}
@property(assign,nonatomic)NSString *isWorkLocationEntered;
@property (strong, nonatomic) IBOutlet UILabel *lblReceiveGratuity;
@property (strong, nonatomic) IBOutlet UILabel *lblFundTransfer;
- (IBAction)showImagePicker:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *view_agreeterms_continue;
@property (strong, nonatomic) IBOutlet UIToolbar *completeProServiceToolbar;

@property (strong, nonatomic) IBOutlet UIScrollView *view_scroll;

@property (strong, nonatomic) IBOutlet UIButton *saveImageButton;

@property (weak, nonatomic) IBOutlet UIButton *uploadImgButton;
- (IBAction)saveImageAction:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *lbl_charityname;
@property (strong, nonatomic) IBOutlet UILabel *lbl_sharerating;
@property (strong, nonatomic) IBOutlet UILabel *lbl_agreeterms;

@property (strong, nonatomic) IBOutlet UILabel *txtgratuity;
@property (strong, nonatomic) IBOutlet UITextField *txt_gratuity;

@property (weak, nonatomic) IBOutlet UIImageView *proImage;
@property(retain,nonatomic) NSString *gratuityStr,*paymentStr;
@property (weak, nonatomic) IBOutlet UIButton *btnShareProfile;
- (IBAction)btnAgreeTermAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnContinue;
- (IBAction)btnShareProfileAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnAgreeTerm;
- (IBAction)btnContinueAction:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *btn_cancel;

- (IBAction)cancelButtonAction:(id)sender;




@end
