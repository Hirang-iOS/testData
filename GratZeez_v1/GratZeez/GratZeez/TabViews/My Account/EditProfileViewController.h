//
//  EditProfileViewController.h
//  GratZeez
//
//  Created by cloudZon Infosoft on 01/01/14.
//  Copyright (c) 2014 cloudZon Infosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"
@interface EditProfileViewController : UIViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITextViewDelegate,UITextFieldDelegate>
{
    UIView *subview;
    NSDateFormatter *df;
    NSString *Todaydate;

}
@property (strong, nonatomic) IBOutlet UIImageView *proImage;
@property (strong, nonatomic) IBOutlet UILabel *lbl_length;
@property (strong, nonatomic) IBOutlet UIToolbar *editProToolbar;
@property (strong, nonatomic) IBOutlet UIButton *uploadImgButton;
@property (strong, nonatomic) IBOutlet UIButton *updateImageButton;
@property(strong,nonatomic) UIDatePicker *datePicker;
@property(strong,nonatomic) NSMutableArray *editProfileArray;
@property(strong,nonatomic) NSMutableDictionary *editProfileDictionary;
- (IBAction)saveImageAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *saveButton;
- (IBAction)saveInfoAction:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *txt_firstName;
@property (strong, nonatomic) IBOutlet UITextField *txt_lastName;
@property (strong, nonatomic) IBOutlet UITextField *txt_zipcode;
@property (strong, nonatomic) IBOutlet UITextField *txt_contactNo;
//@property (strong, nonatomic) IBOutlet UITextView *txt_address;
@property (strong, nonatomic) IBOutlet UITextField *txt_birthdate;
@property (strong, nonatomic) IBOutlet UILabel *lbl_birthdate;
- (IBAction)showImagePickerView:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btn_EnableSecondProfile;
@property (strong, nonatomic) IBOutlet UILabel *lbl_EnableSecondProfile;

- (IBAction)enableSecondProfileAction:(id)sender;


@end
