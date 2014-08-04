//
//  ServiceProviderEditProfileViewController.h
//  GratZeez
//
//  Created by cloudZon Infosoft on 06/01/14.
//  Copyright (c) 2014 cloudZon Infosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"
#import "CharityDetailViewController.h"
#import "WorkLocationDetailsViewController.h"
#import "WorkLocationViewController.h"
@interface ServiceProviderEditProfileViewController : UIViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIPickerViewDataSource,UIPickerViewDelegate,CharityDetailViewDelegate,WorkLocationViewDelegate,UIScrollViewDelegate,UIScrollViewAccessibilityDelegate,WorkLocationDetailViewDelegate,UITextViewDelegate>
{
    UIView *subview;
    NSDateFormatter *df;
    NSString *Todaydate;
    UIPickerView *charityPicker;
    NSMutableArray *dataArray,*searchedName;
    NSString *charityId,*charityName,*charityEmail;
    
    int number_of_textfields;
    float space_between_textfield;
    float frame_y;
    float height_of_component,width_of_lbl;
    
    
    IBOutlet UILabel *lblEstablishment;
    UIPickerView *establishPickerView;
    UILabel *firstlbl,*lbl1,*lbl2,*worklocation_lbl,*worklocation_lbl1,*worklocation_lbl2;
    UIButton *btn,*rm1,*rm2;
    UITextField *txt,*txt1,*txt2;
    
    NSMutableDictionary *establsihTypeDataDictionary;
    NSString *establishmentId1,*establishmentId2,*establishmentId3,*workLocationId1,*workLocationId2,*workLocationId3,*establishmnetString,*organizationString;
    
    
    float sizeOfContent;
    UIView *lLast;
    NSInteger wd,ht;


}
@property(strong,nonatomic) NSMutableArray *establishTypeDataArray;
@property (strong, nonatomic) IBOutlet UIView *view_scroll;
@property (strong, nonatomic) IBOutlet UIScrollView *scroller;
@property (strong, nonatomic) IBOutlet UILabel *lbl_workInfo;

- (IBAction)btn_help:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *btn_EnableSecondLogin;
@property (strong, nonatomic) IBOutlet UILabel *lbl_SecondLogin;
@property (strong, nonatomic) IBOutlet UILabel *lbl_length;
- (IBAction)enableSecondLoginAction:(id)sender;

- (IBAction)removeCharityAction:(id)sender;
@property(strong,nonatomic) EstablishmentViewController *EVC;
@property (strong, nonatomic) IBOutlet UIView *btn_removeCharity;
@property (strong, nonatomic) IBOutlet UIImageView *proImage;
@property (strong, nonatomic) IBOutlet UIButton *uploadImgButton;
@property (strong, nonatomic) IBOutlet UIButton *updateImageButton;
@property(strong,nonatomic) UIDatePicker *datePicker;
@property(strong,nonatomic) NSMutableDictionary *editProfileDictionay;
@property(strong,nonatomic)NSMutableArray *charityDataArray;
- (IBAction)saveImageAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *saveButton;
- (IBAction)saveInfoAction:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *txt_firstName;
@property (strong, nonatomic) IBOutlet UITextField *txt_lastName;
@property (strong, nonatomic) IBOutlet UITextField *txt_zipcode;
@property (strong, nonatomic) IBOutlet UITextField *txt_contactNo;
@property (strong, nonatomic) IBOutlet UITextView *txt_address;
@property (strong, nonatomic) IBOutlet UILabel *lbl_birthdate;
@property (strong, nonatomic) IBOutlet UIToolbar *serviceProEditToolbar;
@property (weak, nonatomic) IBOutlet UIButton *btnShareProfile;
- (IBAction)btnShareProfileAction:(id)sender;
- (IBAction)editWorkInfoAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *view_charity;
@property (strong, nonatomic) IBOutlet UILabel *lbl_charitydisplay;
@property (strong, nonatomic) IBOutlet UITextField *txt_gratuityAmount;
@property(strong,nonatomic) NSString *charityName;
@property(strong,nonatomic) NSString *charityEmail;
@property (strong, nonatomic) IBOutlet UILabel *lbl_shareRating;
@property (strong, nonatomic) IBOutlet UILabel *lbl_charity;
@property (strong, nonatomic) IBOutlet UILabel *lbl_dontedAmount;
@property (strong, nonatomic) IBOutlet UIView *view_workInfo;

- (IBAction)showImagePickerView:(id)sender;
@end
