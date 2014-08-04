//
//  EditProfileViewController.m
//  GratZeez
//
//  Created by cloudZon Infosoft on 01/01/14.
//  Copyright (c) 2014 cloudZon Infosoft. All rights reserved.
//

#import "EditProfileViewController.h"

@interface EditProfileViewController ()

@end

@implementation EditProfileViewController
@synthesize proImage;
@synthesize uploadImgButton,updateImageButton;
@synthesize editProfileArray;
@synthesize txt_firstName,txt_lastName,txt_contactNo,txt_zipcode,txt_birthdate,lbl_birthdate;
@synthesize datePicker;
@synthesize editProfileDictionary,saveButton,editProToolbar,lbl_length,btn_EnableSecondProfile,lbl_EnableSecondProfile;
NSString *d1;
NSDate *dt;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)setTitle:(NSString *)title {
    //    [super setTitle:title];
    UILabel *titleView = (UILabel *)self.navigationItem.titleView;
    if (!titleView) {
        titleView = [[UILabel alloc] initWithFrame:CGRectZero];
        titleView.backgroundColor = [UIColor clearColor];
        titleView.font = [UIFont fontWithName:@"Garamond 3 SC" size:20.0];
        titleView.textColor = [UIColor whiteColor];
        self.navigationItem.titleView = titleView;
    }
    titleView.text = title;
    [titleView sizeToFit];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"Edit Profile";
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])self.edgesForExtendedLayout = UIRectEdgeNone;
        NSLog(@"Edit Profile Array%@",editProfileArray);
    [[UIBarButtonItem appearance] setTitleTextAttributes:textAttributesTabBar forState:UIControlStateNormal];
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"UserLogedInType"] intValue] != LoginTypeFacebook){
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTapped:)];
        proImage.userInteractionEnabled = YES;
        [proImage addGestureRecognizer:tap];
        uploadImgButton.hidden=YES;
        updateImageButton.hidden=NO;
    }
    else{
        uploadImgButton.hidden=YES;
        updateImageButton.hidden=YES;
    }
   // NSArray *tempArray=[editProfileArray objectAtIndex:0];
    uploadImgButton.layer.borderWidth=0.3;
    uploadImgButton.layer.cornerRadius=3.0;
    uploadImgButton.layer.masksToBounds=YES;
    updateImageButton.layer.borderWidth=0.3;
    updateImageButton.layer.cornerRadius=3.0;
    updateImageButton.layer.masksToBounds=YES;
    NSString *urlString=[ImageURL stringByAppendingPathComponent:editProfileDictionary[@"profilePicture"]];
    proImage.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]]];
    proImage.layer.cornerRadius=3.0;
    proImage.layer.masksToBounds=YES;
    proImage.layer.borderWidth=0.5;
    txt_firstName.text=editProfileDictionary[@"firstName"];
    txt_lastName.text=editProfileDictionary[@"lastName"];
    df = [[NSDateFormatter alloc] init];
    
    
    lbl_birthdate.font=[UIFont fontWithName:GZFont size:16];
    //txt_address.font=[UIFont fontWithName:GZFont size:16];
    txt_contactNo.font=[UIFont fontWithName:GZFont size:16];
    txt_firstName.font=[UIFont fontWithName:GZFont size:16];
    txt_lastName.font=[UIFont fontWithName:GZFont size:16];
    txt_zipcode.font=[UIFont fontWithName:GZFont size:16];
    updateImageButton.titleLabel.font=[UIFont fontWithName:GZFont size:15];
    uploadImgButton.titleLabel.font=[UIFont  fontWithName:GZFont size:15];
    
    [df setDateFormat:@"MMMM-dd-yyyy"];
//    if([[editProfileDictionary valueForKey:@"address" ]  isEqual:(id)[NSNull null]] || [[editProfileDictionary valueForKey:@"address"] isEqualToString:@""]){
//        NSLog(@"Address is empty");
//        txt_address.text=@"Address";
//        txt_address.textColor=[UIColor grayColor];
//        lbl_length.text=@"100";
//        lbl_length.font=[UIFont fontWithName:GZFont size:9];
//        NSLog(@"adres");
//    }else{
//    txt_address.text=[editProfileDictionary valueForKey:@"address" ];
//        lbl_length.text=[NSString stringWithFormat:@"%d",100-[txt_address.text length]];
//        lbl_length.font=[UIFont fontWithName:GZFont size:9];
//    }
//    txt_address.layer.cornerRadius=3.0;
//    txt_address.layer.masksToBounds=YES;
    if([editProfileDictionary[@"contactNumber"] integerValue]==0){
        txt_contactNo.text=@"";
    }
    else{
    txt_contactNo.text=[editProfileDictionary[@"contactNumber"] stringValue];
    }
    if ([editProfileDictionary[@"zipcode"] isEqual:(id)[NSNull null]] || [editProfileDictionary[@"zipcode"] isEqualToString:@""]) {
        txt_zipcode.text=@"";
    }
    else{
        txt_zipcode.text=editProfileDictionary[@"zipcode"];
    }
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];
    lbl_birthdate.layer.borderWidth=0.5;
    lbl_birthdate.layer.borderColor=[[UIColor grayColor]CGColor];
    [lbl_birthdate.layer setCornerRadius:3];
    [lbl_birthdate.layer setMasksToBounds:YES];
    lbl_birthdate.userInteractionEnabled=YES;
    lbl_birthdate.textAlignment = NSTextAlignmentCenter;
    lbl_birthdate.backgroundColor=RGB(233, 228, 223);
    
    subview=[[UIView alloc]initWithFrame:CGRectMake(0, 640, 320, 250)];
    datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0,40, 325, 300)];
    datePicker.datePickerMode =UIDatePickerModeDate;
    datePicker.hidden = NO;
    if([editProfileDictionary[@"dob"]  isEqual:(id)[NSNull null]]){
        datePicker.date=[NSDate date];
    }
    
    else{
        double dt_b=[editProfileDictionary[@"dob"] doubleValue]/1000;
        NSLog(@"double %f",[editProfileDictionary[@"dob"] doubleValue]);
        dt=[NSDate dateWithTimeIntervalSince1970:dt_b];
        d1=[NSString stringWithFormat:@"%@",[df stringFromDate:dt]];
        lbl_birthdate.text=d1;
        datePicker.date=dt;
    }
    datePicker.backgroundColor=RGB(210, 200, 191);
    [datePicker addTarget:self action:@selector(LabelChange:) forControlEvents:UIControlEventValueChanged];
    [subview addSubview:datePicker];
    [self.view addSubview:subview];
    
    UITapGestureRecognizer *tapGesture =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelTap:)];
    [lbl_birthdate addGestureRecognizer:tapGesture];
    // Do any additional setup after loading the view from its nib.
    editProToolbar.frame=CGRectMake(0,524, 320, 44);
    [self.view addSubview:editProToolbar];
    UIButton *backBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 36, 21)];
    [backBtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    UIBarButtonItem *btnitem=[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    editProToolbar.items=@[btnitem];
    [editProToolbar setBackgroundImage:toolBarImage forToolbarPosition:UIBarPositionBottom barMetrics:UIBarMetricsDefault];
    [self addLeftMenuButtonWithImage:[UIImage imageNamed:@"menu_icon"]];
    [self addrightMenuButtonWithImage:[UIImage imageNamed:@"help"]];
    
    UISwipeGestureRecognizer *rightRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(backAction:)];
    rightRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [rightRecognizer setNumberOfTouchesRequired:1];
    [self.view addGestureRecognizer:rightRecognizer];
    
   // btn_EnableSecondProfile.selected=[[[NSUserDefaults standardUserDefaults] valueForKey:@"isServiceProvider"] boolValue];
    lbl_EnableSecondProfile.font=[UIFont fontWithName:GZFont size:16];
    
//    UIDatePicker *picker = [UIDatePicker appearance];
//    picker.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.3];
//    
//    UIView *view;
//    view = [UIView appearanceWhenContainedIn:[UITableView class], [UIDatePicker class], nil];
//    view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    
//    UILabel *label = [UILabel appearanceWhenContainedIn:[UITableView class], [UIDatePicker class], nil];
//    label.font =[UIFont fontWithName:GZFont size:15];
//    label.textColor = [UIColor blueColor];
    if([[[NSUserDefaults standardUserDefaults] valueForKey:@"isServiceProvider"] boolValue]==1){
        btn_EnableSecondProfile.hidden=YES;
        lbl_EnableSecondProfile.hidden=YES;
    }
    
}
-(IBAction)backAction:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)chagneTextFieldStyle:(UITextField *)textField{
    textField.layer.borderColor=[[UIColor redColor] CGColor];
    textField.layer.borderWidth=1;
    textField.layer.masksToBounds=YES;
    textField.layer.cornerRadius=4.7;
//    textField.layer.shadowOpacity = 0.2;
//    textField.layer.shadowRadius = 0.0;
//    textField.layer.shadowColor = [UIColor redColor].CGColor;
//    textField.layer.shadowOffset = CGSizeMake(1.0, -0.5);
}

-(void)viewDidAppear:(BOOL)animated{
    NSLog(@"%f %f %f",self.view.frame.origin.y,self.view.frame.size.height,self.editProToolbar.frame.origin.y);
}

#pragma mark - ImagePicker delegate method
- (void )imageTapped:(UITapGestureRecognizer *) gestureRecognizer
{
    NSLog(@"image tapped");
    UIImagePickerController *imgPicker=[[UIImagePickerController alloc]init];
    imgPicker.delegate=self;
  //  imgPicker.allowsEditing=YES;
    [imgPicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [self presentViewController:imgPicker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    NSLog(@"info is%@",info);
    proImage.image=[info valueForKey:@"UIImagePickerControllerOriginalImage"];
//    UIImage *img=[info valueForKey:@"UIImagePickerControllerOriginalImage"];
//    NSLog(@"==>%f %f %f",img.size.width,img.size.height,proImage.image.size.height);
//    UIView *imgView=[[UIView alloc]initWithFrame:CGRectMake(0, 40, 320 ,420)];
//    UIImageView *cropView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0,320,420)];
//    cropView.image=img;
//    [imgView addSubview:cropView];
//    [self.view addSubview:imgView];
    uploadImgButton.hidden=NO;
    updateImageButton.hidden=YES;
    [uploadImgButton setTitle:@"Save" forState:UIControlStateNormal];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Action for Image save
-(UIImage *) resizeImage:(UIImage *)orginalImage resizeSize:(CGSize)size
{
    CGFloat actualHeight = orginalImage.size.height;
    CGFloat actualWidth = orginalImage.size.width;
    
    float oldRatio = actualWidth/actualHeight;
    float newRatio = size.width/size.height;
    if(oldRatio < newRatio)
    {
        oldRatio = size.height/actualHeight;
        actualWidth = oldRatio * actualWidth;
        actualHeight = size.height;
    }
    else
    {
        oldRatio = size.width/actualWidth;
        actualHeight = oldRatio * actualHeight;
        actualWidth = size.width;
    }
    
    CGRect rect = CGRectMake(0.0,0.0,actualWidth,actualHeight);
    UIGraphicsBeginImageContext(rect.size);
    [orginalImage drawInRect:rect];
    orginalImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return orginalImage;
    
}

- (IBAction)saveImageAction:(id)sender {
    ASIFormDataRequest *_request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:URLSaveImage]];
    __unsafe_unretained ASIFormDataRequest *request = _request;
    [ASIHTTPRequest setShouldThrottleBandwidthForWWAN:YES];
    [request setUploadProgressDelegate:self];
    proImage.image=[self resizeImage:proImage.image resizeSize:CGSizeMake(178,178)];
    NSData *data=UIImageJPEGRepresentation(proImage.image, 1.0);
    [request setPostValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"userid"] forKey:@"userid"];
    [request setData:data
        withFileName:@"profile.jpg"
      andContentType:@"image/jpeg"
              forKey:@"file"];
    
    [request setCompletionBlock:^{
        //NSData *responseData = [NSJSONSerialization JSONObjectWithData:[request responseString] options:0 error:nil];
        uploadImgButton.hidden=YES;
        NSDictionary *root=[NSJSONSerialization JSONObjectWithData:[request responseData] options:0 error:nil];
        NSLog(@"root===>%@",root);
        NSData *d=[Base64 decode:[root valueForKey:@"image"]];
        NSLog(@"newdata@@@@%@",d);
        UIImageView *img2=[[UIImageView alloc]initWithImage:[UIImage imageWithData:d scale:1.0f]];
        img2.frame=CGRectMake(0, 300, 60, 60);
        [self.view addSubview:img2];
    
    }];
    [request setFailedBlock:^{
        NSError *error = [request error];
        NSLog(@"Error: %@",error.localizedDescription);
        [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                        type:AJNotificationTypeRed
                                       title:error.localizedDescription
                             linedBackground:AJLinedBackgroundTypeDisabled
                                   hideAfter:GZAJNotificationDelay];
    }];
    [request startAsynchronous];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [txt_contactNo resignFirstResponder];
    [txt_firstName resignFirstResponder];
    [txt_lastName resignFirstResponder];
    [txt_zipcode resignFirstResponder];
    [UIView animateWithDuration:0.25 delay:0.0 options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         CGRect f1;
                         f1=self.view.frame;
                         NSLog(@"%f %f %f",f1.size.height,f1.size.width,f1.origin.y);
                         // self.view.frame=CGRectMake(0, -20, 320, 464);
                         subview.frame=CGRectMake(0, 640, subview.frame.size.width , subview.frame.size.height);
                     }
                     completion:^(BOOL finished){
                         if(finished)  {NSLog(@"Finished end !!!!!");}
                     }];
}
- (IBAction)saveInfoAction:(id)sender {
    if([[txt_firstName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]<=0 || [[txt_lastName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]<=0)
    {
        [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                        type:AJNotificationTypeRed
                                       title:@"Please Enter firstname and lastname."
                             linedBackground:AJLinedBackgroundTypeDisabled
                                   hideAfter:GZAJNotificationDelay];
        if([[txt_firstName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0){
            [self chagneTextFieldStyle:txt_firstName];
        }
        if([[txt_lastName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0)
        {
            [self chagneTextFieldStyle:txt_lastName];
        }
    }
    else if([txt_zipcode.text isEqualToString:@"00000"]){
        [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                        type:AJNotificationTypeRed
                                       title:@"ZipCode Not Valid"
                             linedBackground:AJLinedBackgroundTypeDisabled
                                   hideAfter:GZAJNotificationDelay];
    }
    else{
        NSMutableArray *objects=[[NSMutableArray alloc]init];
        NSMutableArray *keys=[[NSMutableArray alloc]init];
        [objects addObject:[txt_firstName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
        [keys addObject:@"firstName"];
        [objects addObject:[txt_lastName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
        [keys addObject:@"lastName"];
//        if(![txt_address.text isEqualToString:@"Address"] && [txt_address.text length]>0){
//            [objects addObject:txt_address.text];
//            [keys addObject:@"address"];
//        }
        if([[txt_contactNo.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]>0){
            [objects addObject:[txt_contactNo.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
            [keys addObject:@"contactNumber"];
        }
        if([[txt_zipcode.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]>0){
            [objects addObject:[txt_zipcode.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
            [keys addObject:@"zipcode"];
        }
        if(![lbl_birthdate.text isEqualToString:@"Birthdate"]){
            NSDateFormatter *f1=[[NSDateFormatter alloc]init];
            [f1 setDateFormat:@"MM-dd-yyyy"];
            NSDate *sendDate=[f1 dateFromString:lbl_birthdate.text];
            NSLog(@"send date is %@",sendDate);
            NSDateFormatter *f2=[[NSDateFormatter alloc]init];
            [f2 setDateFormat:@"MM-dd-YYYY"];
            NSString *ds=[NSString stringWithFormat:@"%@",[f2 stringFromDate:sendDate]];
            NSLog(@"date srinf %@",ds);
            [objects addObject:ds];
            [keys addObject:@"dob"];
            //[df setDateFormat:@"MM-dd-yyyy"]; NSString *str_date=[df stringFromDate:date_Picker.date];
        }
        if(!btn_EnableSecondProfile.isHidden){
        [objects addObject:(btn_EnableSecondProfile.isSelected?@"true":@"false")];
        [keys addObject:@"isServiceProvider"];
        }
        [objects addObject:[[NSUserDefaults standardUserDefaults] valueForKey:@"userid"]];
        [keys addObject:@"senderId"];
        NSDictionary *senderEditProfile=[[NSDictionary alloc]initWithObjects:objects forKeys:keys];
        NSError *error;
        NSData *senderEditProfileData=[NSJSONSerialization dataWithJSONObject:senderEditProfile options:NSJSONWritingPrettyPrinted error:&error];
    ASIFormDataRequest *_request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:URLSaveSenderEditProfile]];
    __unsafe_unretained ASIFormDataRequest *request = _request;
        [request addRequestHeader:ContentType value:ContentTypeValue];
    [request appendPostData:senderEditProfileData];
    NSLog(@"%@",senderEditProfile);
    [request setCompletionBlock:^{
        NSMutableDictionary *root = [NSJSONSerialization JSONObjectWithData:[request responseData] options:0 error:nil];
        NSLog(@"EditProfile Root %@",root);
        [[NSUserDefaults standardUserDefaults] setValue:txt_firstName.text forKey:@"first_name"];
        [[NSUserDefaults standardUserDefaults] setValue:txt_lastName.text forKey:@"last_name"];
        if(!btn_EnableSecondProfile.isHidden){
        [[NSUserDefaults standardUserDefaults] setValue:(btn_EnableSecondProfile.isSelected?@"1":@"0") forKey:@"isServiceProvider"];
        if(btn_EnableSecondProfile.isSelected){
        btn_EnableSecondProfile.hidden=YES;
        lbl_EnableSecondProfile.hidden=YES;
        }
        }
        MenuViewController   *menuVC = [[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil];
        [[self sideMenuController ] changeMenuViewController:menuVC closeMenu:YES];
        [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                        type:AJNotificationTypeBlue
                                       title:root[@"message"]
                             linedBackground:AJLinedBackgroundTypeDisabled
                                   hideAfter:GZAJNotificationDelay];
        
    }];
        [request setFailedBlock:^{
            NSError *error=[request error];
            [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                            type:AJNotificationTypeRed
                                           title:error.localizedDescription
                                 linedBackground:AJLinedBackgroundTypeDisabled
                                       hideAfter:GZAJNotificationDelay];
        }];
        [request startAsynchronous];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    //    if(textField==txtContactNumber){
    //        NSCharacterSet *nonNumberSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    //        return ([string stringByTrimmingCharactersInSet:nonNumberSet].length > 0) || [string isEqualToString:@""];
    //    }
    if(textField==txt_contactNo){
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        if(newLength>12){
            return NO;
        }
        
        NSCharacterSet *nonNumberSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
        if([string rangeOfCharacterFromSet:nonNumberSet].location != NSNotFound){
            return ([string stringByTrimmingCharactersInSet:nonNumberSet].length > 0) || [string isEqualToString:@""];
        }
        
    }
    
    if (textField==txt_firstName) {
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        return (newLength > 15) ? NO : YES;
    }
    if (textField==txt_lastName) {
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        return (newLength > 15) ? NO : YES;
    }
    if (textField==txt_zipcode) {
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        return (newLength > 5) ? NO : YES;
    }
    
    else
        return 1;
    
}
//- (void)textViewDidChange:(UITextView *)textView{
//    if(textView==txt_address){
//        NSLog(@"length%d",[textView.text length]);
//        int i=[textView.text length];
//        lbl_length.text=[NSString stringWithFormat:@"%d",100-i];
//    }
//}
//- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
//    if ([text  isEqualToString:@"\n"]) {
//        [txt_address resignFirstResponder];
//        return NO;
//    }
//    if (textView==txt_address) {
//        NSUInteger newLength = [textView.text length] + [text length] - range.length;
//        return (newLength > 100) ? NO : YES;
//    }
//    return YES;
//}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField==txt_firstName) {
        [txt_firstName resignFirstResponder];
        [txt_lastName becomeFirstResponder];
    }
    else if (textField==txt_lastName) {
        [txt_lastName resignFirstResponder];
        }
    else if (textField==txt_contactNo){
        [txt_contactNo resignFirstResponder];
    }
    else if (textField==txt_zipcode) {
        [txt_zipcode resignFirstResponder];
        [txt_contactNo becomeFirstResponder];
    }
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if(textField==txt_zipcode){
        [UIView animateWithDuration:0.25 delay:0.0 options: UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             CGRect f1;
                             f1=self.view.frame;
                             NSLog(@"%f %f %f",f1.size.height,f1.size.width,f1.origin.y);
                            // self.view.frame=CGRectMake(0, -20, 320, 464);
                             subview.frame=CGRectMake(0, 640, subview.frame.size.width , subview.frame.size.height);
                         }
                         completion:^(BOOL finished){
                             if(finished)  {NSLog(@"Finished end !!!!!");}
                         }];
    }
    if (textField==txt_firstName) {
        txt_firstName.layer.borderWidth=0;
        txt_firstName.layer.shadowOpacity=0;
        [UIView animateWithDuration:0.25 delay:0.0 options: UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             // self.view.frame=CGRectMake(0, -30, 320, 200);
                             subview.frame=CGRectMake(0, 640,subview.frame.size.width , subview.frame.size.height);
                             //                             CGRect f1;
                             //                             f1=self.view.frame;
                             //                             f1.origin.y=f1.origin.y-100;
                             // self.view.frame=f1;
                             // v1.backgroundColor=[UIColor blackColor];
                         }
                         completion:^(BOOL finished){
                             if(finished)  {NSLog(@"Finished end !!!!!");}
                         }];
    }
    if(textField==txt_contactNo){
        [UIView animateWithDuration:0.25 delay:0.0 options: UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             // self.view.frame=CGRectMake(0, -30, 320, 200);
                             subview.frame=CGRectMake(0, 640,subview.frame.size.width , subview.frame.size.height);
                           //  self.view.frame=CGRectMake(0, -20, 320, self.view.frame.size.height);
                             //                             CGRect f1;
                             //                             f1=self.view.frame;
                             //                             f1.origin.y=f1.origin.y-100;
                             // self.view.frame=f1;
                             // v1.backgroundColor=[UIColor blackColor];
                         }
                         completion:^(BOOL finished){
                             if(finished)  {NSLog(@"Finished end !!!!!");}
                         }];
    }
    if(textField==txt_lastName){
        txt_firstName.layer.borderWidth=0;
        txt_firstName.layer.shadowOpacity=0;
        [UIView animateWithDuration:0.25 delay:0.0 options: UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             // self.view.frame=CGRectMake(0, -30, 320, 200);
                             subview.frame=CGRectMake(0, 640,subview.frame.size.width , subview.frame.size.height);
                             //                             CGRect f1;
                             //                             f1=self.view.frame;
                             //                             f1.origin.y=f1.origin.y-100;
                             // self.view.frame=f1;
                             // v1.backgroundColor=[UIColor blackColor];
                         }
                         completion:^(BOOL finished){
                             if(finished)  {NSLog(@"Finished end !!!!!");}
                         }];
        
    }
}
//- (void)textViewDidBeginEditing:(UITextView *)textView{
//    txt_address.text=@"";
//    txt_address.textColor=[UIColor blackColor];
//    [UIView animateWithDuration:0.25 delay:0.0 options: UIViewAnimationOptionCurveEaseInOut
//                     animations:^{
//                         // self.view.frame=CGRectMake(0, -30, 320, 200);
//                         subview.frame=CGRectMake(0, 640, subview.frame.size.width , subview.frame.size.height);
//                         //                             CGRect f1;
//                         //                             f1=self.view.frame;
//                         //                             f1.origin.y=f1.origin.y-100;
//                         // self.view.frame=f1;
//                         // v1.backgroundColor=[UIColor blackColor];
//                     }
//                     completion:^(BOOL finished){
//                         if(finished)  {NSLog(@"Finished end !!!!!");}
//                     }];
//}
//- (void)textViewDidEndEditing:(UITextView *)textView{
//    if([textView.text isEqualToString:@""]){
//        txt_address.text=@"Address";
//        txt_address.textColor=[UIColor grayColor];
//    }
//}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if(textField==txt_contactNo){
        [UIView animateWithDuration:0.20 delay:0.0 options: UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             //                             CGRect f1;
                             //                             f1=self.view.frame;
                             //                             NSLog(@"%f %f",f1.size.height,f1.size.width);
                          //   self.view.frame=CGRectMake(0, 64, 320, self.view.frame.size.height);
                         }
                         completion:^(BOOL finished){
                             if(finished)  {NSLog(@"Finished end !!!!!");}
                         }];
    }
    
}
#pragma mark - datepicker action

-(void)labelTap:(UIGestureRecognizer *)sender{

	datePicker.hidden=NO;
       UIToolbar *toolBar=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
	UIBarButtonItem *barButtonDone = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                      style:UIBarButtonItemStyleBordered target:self action:@selector(doneAction:)];
    barButtonDone.tag=2;
    UIBarButtonItem *barButtonCancel = [[UIBarButtonItem alloc] initWithTitle:@"Cancel"
                                                                        style:UIBarButtonItemStyleBordered target:self action:@selector(CancelAction:)];
    barButtonCancel.tag=4;
    UIBarButtonItem *flexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    flexible.width=200;
    toolBar.items = [[NSArray alloc] initWithObjects:barButtonDone,flexible,barButtonCancel,nil];    toolBar.translucent=NO;
    toolBar.barTintColor=RGB(155, 130, 110);
    [subview addSubview:toolBar];
    [UIView animateWithDuration:0.20 delay:0.0 options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         // self.view.frame=CGRectMake(0, -30, 320, 200);
                         subview.frame=CGRectMake(0, 240, 320, 180);
                         //                             CGRect f1;
                         //                             f1=self.view.frame;
                         //                             f1.origin.y=f1.origin.y-100;
                         // self.view.frame=f1;
                         // v1.backgroundColor=[UIColor blackColor];
                     }
                     completion:^(BOOL finished){
                         if(finished)  {NSLog(@"Finished end !!!!!");}
                     }];
    [txt_firstName resignFirstResponder];
    [txt_lastName resignFirstResponder];
    [txt_zipcode resignFirstResponder];
    [txt_contactNo resignFirstResponder];
   // [txt_address resignFirstResponder];
}

-(IBAction)CancelAction:(id)sender{
    if([editProfileDictionary[@"dob"]  isEqual:(id)[NSNull null]]){
        datePicker.date=[NSDate date];
        lbl_birthdate.text=@"Birthdate";
    }
    else{
    lbl_birthdate.text=d1;
    datePicker.date=dt;
    }
    [UIView animateWithDuration:0.25 delay:0.0 options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         subview.frame=CGRectMake(0, 640, 320, 180);
                     }
                     completion:^(BOOL finished){
                         if(finished)  {NSLog(@"Finished end !!!!!");
                             saveButton.userInteractionEnabled=YES;
                         }
                     }];
}

-(IBAction)doneAction:(id)sender{

    NSDate *date1=[NSDate date];
    NSDate *date2=datePicker.date;
    NSLog(@"date1 is: %@",date1);
    NSLog(@"date2 is: %@",date2);
   BOOL f= [self isSameDay:date1 withDate2:date2];
    NSComparisonResult result = [date1 compare:date2];
    if(result==NSOrderedAscending)
            {
                NSLog(@"big ascending");
                [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                                type:AJNotificationTypeRed
                                               title:@"Birthdate should be less than today date."
                                     linedBackground:AJLinedBackgroundTypeDisabled
                                           hideAfter:GZAJNotificationDelay];
                return;
        
            }
    else if(f){
        [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
    type:AJNotificationTypeRed
    title:@"Birthdate should be less than today date."
    linedBackground:AJLinedBackgroundTypeDisabled
    hideAfter:GZAJNotificationDelay];
        return;
    }
    else{
        [UIView animateWithDuration:0.25 delay:0.0 options: UIViewAnimationOptionCurveEaseInOut
                                      animations:^{
                                          // self.view.frame=CGRectMake(0, -30, 320, 200);
                                          subview.frame=CGRectMake(0, 640, 320, 180);
                                          //                             CGRect f1;
                                          //                             f1=self.view.frame;
                                          //                             f1.origin.y=f1.origin.y-100;
                                         // self.view.frame=f1;
                                          // v1.backgroundColor=[UIColor blackColor];
                                      }
                                      completion:^(BOOL finished){
                                          if(finished)  {NSLog(@"Finished end !!!!!");}
                                      }];
    }
    NSLog(@"%d",f);
    
}
- (BOOL)isSameDay:(NSDate *)date1 withDate2:(NSDate *)date2
{
    if (nil == date1 || nil == date2) {
        return NO;
    }
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    NSDateComponents* comp1 = [calendar components:unitFlags fromDate:date1];
    NSDateComponents* comp2 = [calendar components:unitFlags fromDate:date2];
    
    return [comp1 day] == [comp2 day] &&
    [comp1 month] == [comp2 month] &&
    [comp1 year]  == [comp2 year];
}
- (void)LabelChange:(id)sender
{
	lbl_birthdate.text = [NSString stringWithFormat:@"%@",[df stringFromDate:datePicker.date]];
    
    NSLog(@"date is %@",lbl_birthdate.text);
}
- (IBAction)showImagePickerView:(id)sender {
    UIImagePickerController *imgPicker=[[UIImagePickerController alloc]init];
    imgPicker.delegate=self;
    [imgPicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [self presentViewController:imgPicker animated:YES completion:nil];
}
- (IBAction)enableSecondProfileAction:(id)sender {
    if (![btn_EnableSecondProfile isSelected]){
		[btn_EnableSecondProfile setSelected:YES];
	} else {
		[btn_EnableSecondProfile setSelected:NO];
	}
}
@end
