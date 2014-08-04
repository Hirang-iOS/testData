//
//  ServiceProviderEditProfileViewController.m
//  GratZeez
//
//  Created by cloudZon Infosoft on 06/01/14.
//  Copyright (c) 2014 cloudZon Infosoft. All rights reserved.
//

#import "ServiceProviderEditProfileViewController.h"

@interface ServiceProviderEditProfileViewController ()

@end

@implementation ServiceProviderEditProfileViewController
@synthesize proImage;
@synthesize uploadImgButton,updateImageButton,btnShareProfile,btn_removeCharity,saveButton;
@synthesize editProfileDictionay,charityDataArray;
@synthesize txt_firstName,txt_lastName,txt_address,txt_contactNo,txt_zipcode,lbl_birthdate,lbl_charitydisplay,txt_gratuityAmount,lbl_shareRating,lbl_charity,lbl_dontedAmount;
@synthesize datePicker;
@synthesize view_charity;
@synthesize charityEmail,charityName;
@synthesize view_scroll,scroller,view_workInfo,serviceProEditToolbar,lbl_workInfo,lbl_length,btn_EnableSecondLogin,lbl_SecondLogin;
@synthesize establishTypeDataArray;
WorkLocationViewController *workVC;
WorkLocationDetailsViewController *workDetailVC;
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
    [[UIBarButtonItem appearance] setTitleTextAttributes:textAttributesTabBar forState:UIControlStateNormal];
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])self.edgesForExtendedLayout = UIRectEdgeNone;
    //self.edgesForExtendedLayout=FALSE;
    subview=[[UIView alloc]initWithFrame:CGRectMake(0, 640, 320, 250)];

    self.view=view_scroll;
    //self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];//RGB(210, 200, 191);
    
    scroller.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"edit_profile_bgr"]];
    scroller.scrollEnabled=YES;
    sizeOfContent = 0;
    scroller.contentSize=CGSizeMake(320, 1200);
    NSLog(@"height %f",scroller.contentSize.height);

    view_workInfo.backgroundColor=[UIColor clearColor];
    view_charity.layer.borderColor=[[UIColor grayColor] CGColor];
    view_charity.layer.borderWidth=0.5f;
    view_charity.backgroundColor=RGB(224,216, 209);
    [view_charity.layer setCornerRadius:3];
    [view_charity.layer setMasksToBounds:YES];
    lbl_charitydisplay.layer.borderColor=[[UIColor grayColor] CGColor];
    lbl_charitydisplay.layer.borderWidth=0.5f;
    [lbl_charitydisplay.layer setCornerRadius:3];
    [lbl_charitydisplay.layer setMasksToBounds:YES];
    lbl_charitydisplay.userInteractionEnabled=YES;
    lbl_birthdate.layer.borderWidth=0.5;
    lbl_birthdate.layer.borderColor=[[UIColor grayColor]CGColor];
    [lbl_birthdate.layer setCornerRadius:3];
    [lbl_birthdate.layer setMasksToBounds:YES];
    lbl_birthdate.userInteractionEnabled=YES;
    lbl_birthdate.textAlignment = NSTextAlignmentCenter;
    lbl_birthdate.backgroundColor=RGB(233, 228, 223);
    lbl_birthdate.font=[UIFont fontWithName:GZFont size:16.0];
    txt_address.layer.cornerRadius=6.0;
    txt_address.layer.masksToBounds=YES;
    txt_firstName.font=[UIFont fontWithName:GZFont size:15];
    txt_lastName.font=[UIFont fontWithName:GZFont size:15];
    lbl_shareRating.font=[UIFont fontWithName:GZFont size:15];
    lbl_charity.font=[UIFont fontWithName:GZFont size:15];
    lbl_charitydisplay.font=[UIFont fontWithName:GZFont size:15];
    txt_gratuityAmount.font=[UIFont fontWithName:GZFont size:15];
    lbl_dontedAmount.font=[UIFont fontWithName:GZFont size:15];
    lbl_workInfo.font=[UIFont fontWithName:GZFont size:17];
    txt_address.font=[UIFont fontWithName:GZFont size:15];
    txt_contactNo.font=[UIFont fontWithName:GZFont size:15];
    txt_zipcode.font=[UIFont fontWithName:GZFont size:15];
    
    NSString *urlString=[ImageURL stringByAppendingPathComponent:editProfileDictionay[@"profilePicture"]];
    proImage.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]]];
    proImage.layer.cornerRadius=3.0;
    proImage.layer.masksToBounds=YES;
    proImage.layer.borderWidth=0.5;
    
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"UserLogedInType"] intValue] != LoginTypeFacebook){
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTapped:)];
        proImage.userInteractionEnabled = YES;
        [proImage addGestureRecognizer:tap];
        uploadImgButton.hidden=YES;
        updateImageButton.hidden=NO;
        uploadImgButton.layer.borderWidth=0.3;
        uploadImgButton.layer.cornerRadius=3.0;
        uploadImgButton.layer.masksToBounds=YES;
        updateImageButton.layer.borderWidth=0.3;
        updateImageButton.layer.cornerRadius=3.0;
        updateImageButton.layer.masksToBounds=YES;
        updateImageButton.titleLabel.font=[UIFont fontWithName:GZFont size:15];
        uploadImgButton.titleLabel.font=[UIFont fontWithName:GZFont size:15];
    }
    else{
        uploadImgButton.hidden=YES;
        updateImageButton.hidden=YES;
        
    }
    
    [[UIBarButtonItem appearance] setTitleTextAttributes:textAttributesTabBar forState:UIControlStateNormal];
  
    //WorkinfoView
    
    number_of_textfields = 1;
    space_between_textfield = 10.0;
    frame_y=0;
    height_of_component=30;
    width_of_lbl=180;
    
    establishPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 40, 320, 185)];
    establishPickerView.delegate = self;
    establishPickerView.backgroundColor=RGB(210, 200, 191);
    establishPickerView.showsSelectionIndicator = YES;
    [subview addSubview:establishPickerView];
    
    
    lblEstablishment.userInteractionEnabled = YES;
      [self.view addSubview:subview];
    
    //Adding label and textfiled
    
   establishmnetString=@"Select EstablishmentType";
    organizationString=@"Select Establishment";
    
    
    lbl1 = [[UILabel alloc]init];
    lbl1.userInteractionEnabled=YES;
    lbl1.font=[UIFont fontWithName:GZFont size:16.0f];
    lbl1.text=establishmnetString;
    lbl1.layer.borderWidth=1.0;
    lbl1.layer.borderColor=[[UIColor grayColor]CGColor];
    [lbl1.layer setCornerRadius:6];
    [lbl1.layer setMasksToBounds:YES];
    lbl1.textAlignment = NSTextAlignmentCenter;
    lbl1.backgroundColor=RGB(233, 228, 223);
    lbl1.tag=2;
    
    lbl2 = [[UILabel alloc]init];
    lbl2.userInteractionEnabled=YES;
    lbl2.font=[UIFont fontWithName:GZFont size:16.0f];
    lbl2.text=establishmnetString;
    lbl2.layer.borderWidth=1.0;
    lbl2.layer.borderColor=[[UIColor grayColor]CGColor];
    [lbl2.layer setCornerRadius:6];
    [lbl2.layer setMasksToBounds:YES];
    lbl2.textAlignment = NSTextAlignmentCenter;
    lbl2.backgroundColor=RGB(233, 228, 223);
    lbl2.tag=3;
    
    firstlbl=[[UILabel alloc]init];
    firstlbl.frame=CGRectMake(30,frame_y,width_of_lbl,height_of_component);
    firstlbl.text=establishmnetString;
    firstlbl.userInteractionEnabled=YES;
    firstlbl.layer.borderWidth=1.0;
    firstlbl.layer.borderColor=[[UIColor grayColor]CGColor];
    [firstlbl.layer setCornerRadius:6];
    [firstlbl.layer setMasksToBounds:YES];
    firstlbl.textAlignment = NSTextAlignmentCenter;
    firstlbl.tag=1;
    firstlbl.backgroundColor=RGB(233, 228, 223);
    firstlbl.font=[UIFont fontWithName:GZFont size:16.0f];
    
    worklocation_lbl1=[[UILabel alloc]init];
    worklocation_lbl1.text=organizationString;
    worklocation_lbl1.layer.borderWidth=1.0;
    worklocation_lbl1.layer.borderColor=[[UIColor grayColor]CGColor];
    [worklocation_lbl1.layer setCornerRadius:6];
    [worklocation_lbl1.layer setMasksToBounds:YES];
    worklocation_lbl1.textAlignment = NSTextAlignmentCenter;
    worklocation_lbl1.tag=2;
    worklocation_lbl1.backgroundColor=RGB(233, 228, 223);
    worklocation_lbl1.font=[UIFont fontWithName:GZFont size:16.0f];
    worklocation_lbl1.userInteractionEnabled=YES;
    
    worklocation_lbl2=[[UILabel alloc]init];
    worklocation_lbl2.text=organizationString;
    worklocation_lbl2.layer.borderWidth=1.0;
    worklocation_lbl2.layer.borderColor=[[UIColor grayColor]CGColor];
    [worklocation_lbl2.layer setCornerRadius:6];
    [worklocation_lbl2.layer setMasksToBounds:YES];
    worklocation_lbl2.textAlignment = NSTextAlignmentCenter;
    worklocation_lbl2.tag=3;
    worklocation_lbl2.backgroundColor=RGB(233, 228, 223);
    worklocation_lbl2.userInteractionEnabled=YES;
    worklocation_lbl2.font=[UIFont fontWithName:GZFont size:16.0f];
    
    worklocation_lbl=[[UILabel alloc]init];
    worklocation_lbl.font=[UIFont fontWithName:GZFont size:16.0f];
    worklocation_lbl.frame=CGRectMake(30, firstlbl.frame.origin.y+height_of_component+space_between_textfield, width_of_lbl, height_of_component);
    worklocation_lbl.text=organizationString;
    worklocation_lbl.layer.borderColor=[[UIColor grayColor] CGColor];
    worklocation_lbl.layer.borderWidth=1.0;
    [worklocation_lbl.layer setCornerRadius:6];
    [worklocation_lbl.layer setMasksToBounds:YES];
    worklocation_lbl.backgroundColor=RGB(233, 228, 223);
    worklocation_lbl.textAlignment = NSTextAlignmentCenter;
    worklocation_lbl.userInteractionEnabled=YES;
    worklocation_lbl.tag=1;
    
    
    
    rm1=[UIButton buttonWithType:UIButtonTypeCustom];
    [rm1 addTarget:self action:@selector(removetxt:) forControlEvents:UIControlEventTouchUpInside];
    //[rm1 setTitle:@"remove" forState:UIControlStateNormal];
    [rm1 setImage:[UIImage imageNamed:@"minus_white"] forState:UIControlStateNormal];
    [rm1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    rm1.tag=1;
    
    
    // txt2=[[UITextField alloc]init];
    rm2=[UIButton buttonWithType:UIButtonTypeCustom];
    [rm2 addTarget:self action:@selector(removetxt:) forControlEvents:UIControlEventTouchUpInside];
   [rm2 setImage:[UIImage imageNamed:@"minus_white"] forState:UIControlStateNormal];
    [rm2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    rm2.tag=2;
    
    
    
    
    btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"plus_white"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(addtxtfld:) forControlEvents:UIControlEventTouchUpInside];
    btn.frame=CGRectMake(30,worklocation_lbl.frame.origin.y+height_of_component+space_between_textfield, 50, height_of_component);
    saveButton.frame=CGRectMake(120, btn.frame.origin.y+10, 87, 63);
    [view_workInfo addSubview:saveButton];
    frame_y=worklocation_lbl.frame.origin.y;
    
    [view_workInfo addSubview:firstlbl];
    [view_workInfo addSubview:worklocation_lbl];
    [view_workInfo addSubview:btn];
    
    NSArray *organizationDataArray=editProfileDictionay[@"userOrganization"];
    [organizationDataArray count];
    NSDictionary *organizationDict=[organizationDataArray objectAtIndex:0];
    firstlbl.text=organizationDict[@"establishmentName"];
    worklocation_lbl.text=organizationDict[@"organizationName"];
    establishmentId1=organizationDict[@"establishmentId"];
    workLocationId1=organizationDict[@"organizationId"];
    
    
        if([organizationDataArray count]==2){
            organizationDict=[organizationDataArray objectAtIndex:1];
            number_of_textfields=1;
            lbl1.text=organizationDict[@"establishmentName"];
            worklocation_lbl1.text=organizationDict[@"organizationName"];
            establishmentId2=organizationDict[@"establishmentId"];
            workLocationId2=organizationDict[@"organizationId"];
            [self create_textfield];
        }
        if([organizationDataArray count]==3){
            organizationDict=[organizationDataArray objectAtIndex:1];
            number_of_textfields=1;
            lbl1.text=organizationDict[@"establishmentName"];
            worklocation_lbl1.text=organizationDict[@"organizationName"];
            establishmentId2=organizationDict[@"establishmentId"];
            workLocationId2=organizationDict[@"organizationId"];
            [self create_textfield];
            
            
            organizationDict=[organizationDataArray objectAtIndex:2];
            lbl2.text=organizationDict[@"establishmentName"];
            worklocation_lbl2.text=organizationDict[@"organizationName"];
            establishmentId3=organizationDict[@"establishmentId"];
            workLocationId3=organizationDict[@"organizationId"];
            [self create_textfield];
        }
    
    UITapGestureRecognizer *tapGesture =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(establishLabelTap:)];
    [firstlbl addGestureRecognizer:tapGesture];
    UITapGestureRecognizer *tapGesture1 =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(establishLabelTap:)];
    [lbl1 addGestureRecognizer:tapGesture1];
    UITapGestureRecognizer *tapGesture2 =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(establishLabelTap:)];
    [lbl2 addGestureRecognizer:tapGesture2];
    UITapGestureRecognizer *worklocationtap =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(WorkLocation_lbl_tap:)];
    [worklocation_lbl addGestureRecognizer:worklocationtap];
    UITapGestureRecognizer *worklocationtap1 =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(WorkLocation_lbl_tap:)];
    [worklocation_lbl1 addGestureRecognizer:worklocationtap1];
    UITapGestureRecognizer *worklocationtap2 =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(WorkLocation_lbl_tap:)];
    [worklocation_lbl2 addGestureRecognizer:worklocationtap2];
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    [[UIBarButtonItem appearance] setTitleTextAttributes:textAttributes forState:UIControlStateNormal];
    
    charityPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 20, 320, 300)];
    charityPicker.delegate = self;
    charityPicker.dataSource=self;
    charityPicker.showsSelectionIndicator = YES;
    charityPicker.backgroundColor=RGB(210, 200, 191);
    charityName=@"";
    charityEmail=@"";
    
    UITapGestureRecognizer *tapGesture_charity=
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(charityLabelTap:)];
    [lbl_charitydisplay addGestureRecognizer:tapGesture_charity];
    [subview addSubview:charityPicker];
    
    
    txt_firstName.text=editProfileDictionay[@"firstName"];
    txt_lastName.text=editProfileDictionay[@"lastName"];
    if([[editProfileDictionay valueForKey:@"zipcode" ]  isEqual:(id)[NSNull null]] || [[editProfileDictionay valueForKey:@"zipcode"] isEqualToString:@""]){
        txt_zipcode.text=@"";
    }
    else{
    txt_zipcode.text=editProfileDictionay[@"zipcode"];
    }
    if([[editProfileDictionay valueForKey:@"contactNumber"] integerValue]==0){
        txt_contactNo.text=@"";
    }
    else{
    txt_contactNo.text=[editProfileDictionay[@"contactNumber"] stringValue];
    }
//    if([[editProfileDictionay valueForKey:@"address" ]  isEqual:(id)[NSNull null]] || [[editProfileDictionay valueForKey:@"address"] isEqualToString:@""]){
//        txt_address.text=@"Address";
//        txt_address.textColor=[UIColor grayColor];
//        lbl_length.text=@"100";
//        lbl_length.font=[UIFont fontWithName:GZFont size:9.0];
//    }
//    else{
//        txt_address.text=editProfileDictionay[@"address"];
//        txt_address.textColor=[UIColor blackColor];
//        lbl_length.text=[NSString stringWithFormat:@"%d",100-[txt_address.text length]];
//         lbl_length.font=[UIFont fontWithName:GZFont size:9.0];
//    }
    
    btnShareProfile.selected=[editProfileDictionay[@"isShareRate"] boolValue];
    if([editProfileDictionay[@"userCharity"]  isEqual:(id)[NSNull null]]){
        btn_removeCharity.hidden=YES;
    }
    else{
        NSArray *tempArray=editProfileDictionay[@"userCharity"];
        NSDictionary *tempdict=[tempArray objectAtIndex:0];
        lbl_charitydisplay.text=tempdict[@"charityName"];
        charityId=[tempdict[@"charityId"] stringValue];
        txt_gratuityAmount.text=[tempdict[@"amountToCharity"] stringValue];
        btn_removeCharity.hidden=NO;
    }
    df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"MMMM-dd-yyyy"];
    datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0,40, 325, 300)];
    datePicker.datePickerMode =UIDatePickerModeDate;
    datePicker.hidden = NO;
    datePicker.backgroundColor=RGB(210, 200, 191);
    if([editProfileDictionay[@"dob"]  isEqual:(id)[NSNull null]]){
        datePicker.date=[NSDate date];
    }
    
    else{
        double dt_b=[editProfileDictionay[@"dob"] doubleValue]/1000;
        NSLog(@"double %f",[editProfileDictionay[@"dob"] doubleValue]);
        dt=[NSDate dateWithTimeIntervalSince1970:dt_b];
        d1=[NSString stringWithFormat:@"%@",[df stringFromDate:dt]];
        lbl_birthdate.text=d1;
        datePicker.date=dt;
    }
   
    [txt_gratuityAmount addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    [datePicker addTarget:self action:@selector(LabelChange:) forControlEvents:UIControlEventValueChanged];
    [subview addSubview:datePicker];
    [self.view addSubview:subview];
    
    UITapGestureRecognizer *tapGesture_date =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelTap:)];
    [lbl_birthdate addGestureRecognizer:tapGesture_date];
    serviceProEditToolbar.frame=CGRectMake(0, 460, 320, 44);
    [self.view addSubview:serviceProEditToolbar];
    UIButton *backBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 36, 21)];
    [backBtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    UIBarButtonItem *btnitem=[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    serviceProEditToolbar.items=@[btnitem];
    [serviceProEditToolbar setBackgroundImage:toolBarImage forToolbarPosition:UIBarPositionBottom barMetrics:UIBarMetricsDefault];
    [self addLeftMenuButtonWithImage:[UIImage imageNamed:@"menu_icon"]];
    [self addrightMenuButtonWithImage:[UIImage imageNamed:@"help"]];
    UISwipeGestureRecognizer *rightRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(backAction:)];
    rightRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [rightRecognizer setNumberOfTouchesRequired:1];
    [self.view addGestureRecognizer:rightRecognizer];
    
    if([[[NSUserDefaults standardUserDefaults] valueForKey:@"isSender"] boolValue]==1){
        btn_EnableSecondLogin.hidden=YES;
        lbl_SecondLogin.hidden=YES;
    }
    establishTypeDataArray=editProfileDictionay[@"establishmentType"];
    [establishPickerView reloadAllComponents];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureCaptured:)];
    [scroller addGestureRecognizer:singleTap];
    // Do any additional setup after loading the view from its nib.
}
-(void)singleTapGestureCaptured:(id)sender{
    [txt_zipcode resignFirstResponder];
    [txt_lastName resignFirstResponder];
    [txt_firstName resignFirstResponder];
    [txt_contactNo resignFirstResponder];
    [txt_gratuityAmount resignFirstResponder];
    [UIView animateWithDuration:0.25 delay:0.0 options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         // self.view.frame=CGRectMake(0, -30, 320, 200);
                         subview.frame=CGRectMake(0, 640, 320, 180);
                         [scroller scrollRectToVisible:CGRectMake(0, 0, scroller.frame.size.width, scroller.frame.size.height) animated:YES];
                     }
                     completion:^(BOOL finished){
                         if(finished)  {NSLog(@"Finished end !!!!!");
                         }
                     }];
}
-(IBAction)backAction:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
-(IBAction)addtxtfld:(id)sender{
    NSLog(@"method called");
    [self create_textfield];
    [self.view bringSubviewToFront:subview];
    NSLog(@"created");
}
-(IBAction)removetxt:(id)sender{
    if([sender tag]==1){
        if(number_of_textfields==3){
            NSLog(@"tag 1 fld 3");
            lbl1.text=lbl2.text;
            worklocation_lbl1.text=worklocation_lbl2.text;
            lbl2.text=establishmnetString;
            worklocation_lbl2.text=organizationString;
            btn.frame=CGRectMake(30, worklocation_lbl1.frame.origin.y+height_of_component+space_between_textfield, 50, height_of_component);
            [saveButton setFrame:CGRectMake(120, btn.frame.origin.y+10, saveButton.frame.size.width, saveButton.frame.size.height)];
            number_of_textfields -=1;
            establishmentId2=establishmentId3;
            workLocationId2=workLocationId3;
            establishmentId3=NULL;
            workLocationId3=NULL;
            [lbl2 removeFromSuperview];
            [worklocation_lbl2 removeFromSuperview];
            [rm2 removeFromSuperview];
        }
        else if(number_of_textfields==2){
            NSLog(@"tag 1 fld 2");
            [lbl1 removeFromSuperview];
            [worklocation_lbl1 removeFromSuperview];
            [rm1 removeFromSuperview];
            lbl1.text=establishmnetString;
            worklocation_lbl1.text=organizationString;
            establishmentId2=NULL;
            workLocationId2=NULL;
            btn.frame=CGRectMake(30, worklocation_lbl.frame.origin.y+height_of_component+space_between_textfield, 50, height_of_component);
            [saveButton setFrame:CGRectMake(120, btn.frame.origin.y+10, saveButton.frame.size.width, saveButton.frame.size.height)];
            number_of_textfields -=1;
            frame_y=worklocation_lbl.frame.origin.y;
            NSLog(@"%d",number_of_textfields);
        }
        
    }
    if([sender tag]==2){
        
        if(number_of_textfields==2){
            NSLog(@"tag 2 fld 2");
            btn.frame=CGRectMake(30, worklocation_lbl.frame.origin.y+height_of_component+space_between_textfield, 50, height_of_component);
            [saveButton setFrame:CGRectMake(120, btn.frame.origin.y+10, saveButton.frame.size.width, saveButton.frame.size.height)];
            number_of_textfields -=1;
            frame_y=worklocation_lbl.frame.origin.y;
            lbl1.text=establishmnetString;
            worklocation_lbl1.text=organizationString;
            establishmentId2=NULL;
            workLocationId2=NULL;
        }
        if(number_of_textfields==3){
            NSLog(@"tag 2 fld 3");
            btn.frame=CGRectMake(30, worklocation_lbl1.frame.origin.y+height_of_component+space_between_textfield, 50, height_of_component);
            [saveButton setFrame:CGRectMake(120, btn.frame.origin.y+10, saveButton.frame.size.width, saveButton.frame.size.height)];
            number_of_textfields -=1;
            lbl2.text=establishmnetString;
            worklocation_lbl2.text=organizationString;
            establishmentId3=NULL;
            workLocationId3=NULL;
        }
        [lbl2 removeFromSuperview];
        [worklocation_lbl2 removeFromSuperview];
        [rm2 removeFromSuperview];
        // number_of_textfields=2;
    }
}

-(void)showEstablishSecond{
    NSLog(@"creating secondestablish");
    NSLog(@"frame of second from est %f",frame_y);
    frame_y=worklocation_lbl.frame.origin.y;
    lbl1.frame=CGRectMake(30, frame_y+height_of_component+space_between_textfield, width_of_lbl, height_of_component);
    worklocation_lbl1.frame=CGRectMake(30, lbl1.frame.origin.y+height_of_component+space_between_textfield, width_of_lbl, height_of_component);
    rm1.frame=CGRectMake(220,worklocation_lbl1.frame.origin.y, 70, 30);
    number_of_textfields++;
    
    [view_workInfo  addSubview:rm1];
    [view_workInfo addSubview:lbl1];
    [view_workInfo addSubview:worklocation_lbl1];
    CGRect frame1 = [btn frame];
    frame1.origin.y = worklocation_lbl1.frame.origin.y+height_of_component+space_between_textfield;
    frame1.origin.x=30;
    [btn setFrame:frame1];
    [saveButton setFrame:CGRectMake(120, btn.frame.origin.y+10, saveButton.frame.size.width, saveButton.frame.size.height)];
    frame_y=worklocation_lbl1.frame.origin.y;
}

-(BOOL)create_textfield {
    //check that the user can create it
    NSLog(@"called from outside");
    if(number_of_textfields == 1) {
        NSLog(@"creat");
        NSLog(@"framey second%f",frame_y);
      
        
        [self showEstablishSecond];
        
        
        //ubdate the number of textfields
        
        
        
        NSLog(@"no of.%d",number_of_textfields);
        //textfield created
        
        return YES;
    }
    else if(number_of_textfields==2){
        lbl2.frame=CGRectMake(30, worklocation_lbl1.frame.origin.y+height_of_component+space_between_textfield, width_of_lbl, height_of_component);
        worklocation_lbl2.frame=CGRectMake(30, lbl2.frame.origin.y+height_of_component+space_between_textfield, width_of_lbl, height_of_component);
        rm2.frame=CGRectMake(220,worklocation_lbl2.frame.origin.y, 70, 30);
        
        //ubdate the number of textfields
        
        number_of_textfields++;
        
        //add a tag to be able to retrive it when you are going to delete it
        
        [view_workInfo  addSubview:rm2];
        [view_workInfo addSubview:lbl2];
        [view_workInfo addSubview:worklocation_lbl2];
        
        //move down the button
        CGRect frame1 = [btn frame];
        frame1.origin.y = worklocation_lbl2.frame.origin.y+height_of_component+space_between_textfield;
        frame1.origin.x=30;
        [btn setFrame:frame1];
        [saveButton setFrame:CGRectMake(120, btn.frame.origin.y+10, saveButton.frame.size.width, saveButton.frame.size.height)];
        frame_y=worklocation_lbl2.frame.origin.y;
        NSLog(@"no of.%d",number_of_textfields);
        //textfield created
        return YES;
        
    }
    else {
        //textfield not created
        NSLog(@"max 3 loc");
        [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                        type:AJNotificationTypeRed
                                       title:@"Max. 3 WorkLocation Allow"
                             linedBackground:AJLinedBackgroundTypeDisabled
                                   hideAfter:GZAJNotificationDelay];
        return NO;
    }
}

-(void)WorkLocation_lbl_tap:(UIGestureRecognizer *)sender{
    if(sender.view.tag==1 && establishmentId1==NULL){
        [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                        type:AJNotificationTypeRed
                                       title:@"First Select EstablishmentType"
                             linedBackground:AJLinedBackgroundTypeDisabled
                                   hideAfter:GZAJNotificationDelay];
        return;
    }
    else if(sender.view.tag==2 && establishmentId2==NULL){
        [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                        type:AJNotificationTypeRed
                                       title:@"First Select EstablishmentType"
                             linedBackground:AJLinedBackgroundTypeDisabled
                                   hideAfter:GZAJNotificationDelay];
        return;
    }
    else if(sender.view.tag==3 && establishmentId3==NULL){
        [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                        type:AJNotificationTypeRed
                                       title:@"First Select EstablishmentType"
                             linedBackground:AJLinedBackgroundTypeDisabled
                                   hideAfter:GZAJNotificationDelay];
        return;
    }
    else{
        ASIFormDataRequest *_request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:URLRequestForOrganizationList]];
        __unsafe_unretained ASIFormDataRequest *request = _request;
        [request setDelegate:self];
        NSDictionary *organizationDictionary;
        if(sender.view.tag==1){
            organizationDictionary=[[NSDictionary alloc]initWithObjectsAndKeys:establishmentId1,@"e_id", nil];
        }
        else if(sender.view.tag==2){
            organizationDictionary=[[NSDictionary alloc]initWithObjectsAndKeys:establishmentId2,@"e_id", nil];
        }
        else if(sender.view.tag==3){
            organizationDictionary=[[NSDictionary alloc]initWithObjectsAndKeys:establishmentId3,@"e_id", nil];
        }
        [request appendPostData:[[NSString stringWithFormat:@"%@",organizationDictionary] dataUsingEncoding:NSUTF8StringEncoding]];
        NSLog(@"dict:%@",organizationDictionary);
        [request setCompletionBlock:^{
            NSDictionary *root = [NSJSONSerialization JSONObjectWithData:request.responseData options:0 error:nil];
            NSLog(@"Worklocatio root %@",root);
            if([root[@"isError"]boolValue]==1){
                workVC=[[WorkLocationViewController alloc]initWithNibName:@"WorkLocationViewController" bundle:nil];
                if(sender.view.tag==1){
                    // NSLog(@"====>",establishmentId1);
                    workVC.establishId=establishmentId1;
                }
                else if(sender.view.tag==2){
                    workVC.establishId=establishmentId2;
                }
                else if(sender.view.tag==3){
                    workVC.establishId=establishmentId3;
                }
                [AJNotificationView showNoticeInView:self.view
                                                type:AJNotificationTypeRed
                                               title:root[@"message"]
                                     linedBackground:AJLinedBackgroundTypeDisabled
                                           hideAfter:GZAJNotificationDelay];
                
                // [self.navigationController pushViewController:workVC animated:YES];
                ASIFormDataRequest *_request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:URLGetState]];
                __unsafe_unretained ASIFormDataRequest *request = _request;
                [request setDelegate:self];
                [request setCompletionBlock:^{
                    NSDictionary *root = [NSJSONSerialization JSONObjectWithData:request.responseData options:0 error:nil];
                    NSLog(@"Worklocatio root %@",root);
                    // WorkLocationViewController *wvc=[[WorkLocationViewController alloc]init];
                    workVC.stateArray=root[@"stateList"];
                    workVC.delegate=self;
                    workVC.lblTag=sender.view.tag;
                    workVC.isFromEditProfile=1;
                    [self.navigationController pushViewController:workVC animated:YES];
                }];
                [request setFailedBlock:^{
                    NSError *error = [request error];
                    [AJNotificationView showNoticeInView:self.view
                                                    type:AJNotificationTypeRed
                                                   title:error.localizedDescription
                                         linedBackground:AJLinedBackgroundTypeDisabled
                                               hideAfter:GZAJNotificationDelay];
                }];
                [request startAsynchronous];
                return ;
            }else{
                workDetailVC=[[WorkLocationDetailsViewController alloc]initWithNibName:@"WorkLocationDetailsViewController" bundle:nil];
                if(sender.view.tag==1){
                    // NSLog(@"====>",establishmentId1);
                    workDetailVC.establishId=establishmentId1;
                }
                else if(sender.view.tag==2){
                    workDetailVC.establishId=establishmentId2;
                }
                else if(sender.view.tag==3){
                    workDetailVC.establishId=establishmentId3;
                }
                workDetailVC.delegate=self;
                workDetailVC.lblTag=sender.view.tag;
                workDetailVC.isFromEditProfile_WorkDetail=1;
                workDetailVC.workDetailArray=root[@"OrganizationList"];
                
                [self.navigationController pushViewController:workDetailVC animated:YES];
            }
        }];
        [request setFailedBlock:^{
            NSError *error = [request error];
            NSLog(@"Error: %@",error.localizedDescription);
            [AJNotificationView showNoticeInView:self.view
                                            type:AJNotificationTypeRed
                                           title:error.localizedDescription
                                 linedBackground:AJLinedBackgroundTypeDisabled
                                       hideAfter:GZAJNotificationDelay];
        }];
        [request startAsynchronous];
    }
   }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ImagePicker delegate method
- (void )imageTapped:(UITapGestureRecognizer *) gestureRecognizer
{
    NSLog(@"image tapped");
    UIImagePickerController *imgPicker=[[UIImagePickerController alloc]init];
    imgPicker.delegate=self;
    [imgPicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [self presentViewController:imgPicker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    NSLog(@"info is%@",info);
    proImage.image=[info valueForKey:@"UIImagePickerControllerOriginalImage"];
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

#pragma mark-text feild method
- (void)textViewDidChange:(UITextView *)textView{
    if(textView==txt_address){
        NSLog(@"length%d",[textView.text length]);
        int i=[textView.text length];
        lbl_length.text=[NSString stringWithFormat:@"%d",100-i];
    }
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
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
    if(textField==txt_gratuityAmount){
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        if(newLength>3){
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

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text  isEqualToString:@"\n"]) {
        [txt_address resignFirstResponder];
        [UIView animateWithDuration:0.25 delay:0.0 options: UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             self.view.frame=CGRectMake(0, 64, 320, self.view.frame.size.height);
                             //subview.frame=CGRectMake(0, 640, 320, 180);
                         }
                         completion:^(BOOL finished){
                             if(finished)  {NSLog(@"Finished end !!!!!");}
                         }];
        return NO;
    }
    if (textView==txt_address) {
        NSUInteger newLength = [textView.text length] + [text length] - range.length;
        return (newLength > 100) ? NO : YES;
    }
    return YES;
}

-(void)chagneTextFieldStyle:(UITextField *)textField{
    textField.layer.borderColor=[[UIColor redColor] CGColor];
    textField.layer.borderWidth=1;
    textField.layer.masksToBounds=YES;
    textField.layer.cornerRadius=4.7;
}

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
    if(textField==txt_gratuityAmount){
        [txt_gratuityAmount resignFirstResponder];
    }
    return YES;
}

-(IBAction)textFieldDidChange:(id)sender{
    if([txt_gratuityAmount.text integerValue]>100){
        NSString *text=txt_gratuityAmount.text;
        NSString *newString = [text substringToIndex:[text length]-1];
        txt_gratuityAmount.text=newString;
        return;
    }
    
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if(textField==txt_zipcode){
        txt_zipcode.layer.borderWidth=0;
        txt_zipcode.layer.shadowOpacity=0;
        [UIView animateWithDuration:0.20 delay:0.0 options: UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             CGRect f1;
                             f1=self.view.frame;
                             NSLog(@"%f %f %f",f1.size.height,f1.size.width,f1.origin.y);
                             NSLog(@"frame zip before %f %f %f %f",self.view.frame.origin.x,self.view.frame.origin.y,self.view.frame.size.height,self.view.frame.size.width);
                            // self.view.frame=CGRectMake(0, -80, 320, 464);
                             [scroller scrollRectToVisible:CGRectMake(0, 80, scroller.frame.size.width, scroller.frame.size.height) animated:YES];
                             subview.frame=CGRectMake(0, 640, 320, 180);
                         }
                         completion:^(BOOL finished){
                             if(finished)  {NSLog(@"Finished end !!!!!");}
                         }];
    }
    if (textField==txt_firstName) {
        txt_firstName.layer.borderWidth=0;
        txt_firstName.layer.shadowOpacity=0;
        [UIView animateWithDuration:0.20 delay:0.0 options: UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             // self.view.frame=CGRectMake(0, -30, 320, 200);
                             subview.frame=CGRectMake(0, 640, 320, 180);
                            }
                         completion:^(BOOL finished){
                             if(finished)  {NSLog(@"Finished end !!!!!");}
                         }];
    }if(textField==txt_contactNo){
        [UIView animateWithDuration:0.20 delay:0.0 options: UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             subview.frame=CGRectMake(0, 640, 320, 180);
                              [scroller scrollRectToVisible:CGRectMake(0, 140, scroller.frame.size.width, scroller.frame.size.height) animated:YES];
                         }
                         completion:^(BOOL finished){
                             if(finished)  {NSLog(@"Finished end !!!!!");}
                         }];
    }
    if(textField==txt_lastName){
        txt_lastName.layer.borderWidth=0;
        txt_lastName.layer.shadowOpacity=0;
        [UIView animateWithDuration:0.20 delay:0.0 options: UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             // self.view.frame=CGRectMake(0, -30, 320, 200);
                             subview.frame=CGRectMake(0, 640, 320, 180);
                         }
                         completion:^(BOOL finished){
                             if(finished)  {NSLog(@"Finished end !!!!!");}
                         }];
        
    }
    if(textField==txt_gratuityAmount){
        txt_gratuityAmount.layer.borderWidth=0;
        txt_gratuityAmount.layer.shadowOpacity=0;
        [UIView animateWithDuration:0.20 delay:0.0 options: UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             // self.view.frame=CGRectMake(0, -30, 320, 200);
                             subview.frame=CGRectMake(0, 640, 320, 180);
                         }
                         completion:^(BOOL finished){
                             if(finished)  {NSLog(@"Finished end !!!!!");}
                         }];
    }
}
- (void)textViewDidBeginEditing:(UITextView *)textView{
    
    [UIView animateWithDuration:0.20 delay:0.0 options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         // self.view.frame=CGRectMake(0, -30, 320, 200);
                         subview.frame=CGRectMake(0, 640, 320, 180);
                     }
                     completion:^(BOOL finished){
                         if(finished)  {NSLog(@"Finished end !!!!!");}
                     }];
    if(textView==txt_address){
        txt_address.text=@"";
        txt_address.textColor=[UIColor blackColor];
        [UIView animateWithDuration:0.20 delay:0.0 options: UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                              [scroller scrollRectToVisible:CGRectMake(0, 80, scroller.frame.size.width, scroller.frame.size.height) animated:YES];
                         }
                         completion:^(BOOL finished){
                             if(finished)  {NSLog(@"Finished end !!!!!");}
                         }];
    }
}
- (void)textViewDidEndEditing:(UITextView *)textView{
    if([[txt_address.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0){
            txt_address.text=@"Address";
            txt_address.textColor=[UIColor grayColor];
    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if(textField==txt_zipcode){
        [UIView animateWithDuration:0.20 delay:0.0 options: UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             //                             CGRect f1;
                             //                             f1=self.view.frame;
                             //                             NSLog(@"%f %f",f1.size.height,f1.size.width);
                             NSLog(@"frame after %f %f %f %f",self.view.frame.origin.x,self.view.frame.origin.y,self.view.frame.size.height,self.view.frame.size.width);
                             self.view.frame=CGRectMake(0, 64, 320, self.view.frame.size.height);
                         }
                         completion:^(BOOL finished){
                             if(finished)  {NSLog(@"Finished end !!!!!");}
                         }];
    }
    
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [txt_zipcode resignFirstResponder];
    [txt_lastName resignFirstResponder];
    [txt_firstName resignFirstResponder];
    [txt_contactNo resignFirstResponder];
    [UIView animateWithDuration:0.25 delay:0.0 options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         // self.view.frame=CGRectMake(0, -30, 320, 200);
                         subview.frame=CGRectMake(0, 640, 320, 180);
                         [scroller scrollRectToVisible:CGRectMake(0, 0, scroller.frame.size.width, scroller.frame.size.height) animated:YES];
                     }
                     completion:^(BOOL finished){
                         if(finished)  {NSLog(@"Finished end !!!!!");
                         }
                     }];
}
#pragma mark- WorkInformation Picker Methods
-(void)establishLabelTap:(UIGestureRecognizer *)sender{
    charityPicker.hidden=YES;
    datePicker.hidden=YES;
    establishPickerView.hidden=NO;
    UIToolbar *toolBar=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
    UIBarButtonItem *barButtonDone = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                      style:UIBarButtonItemStyleBordered target:self action:@selector(doneAction:)];
    toolBar.items = [[NSArray alloc] initWithObjects:barButtonDone,nil];
    toolBar.translucent=NO;
    toolBar.barTintColor=RGB(155, 130, 110);
    [subview addSubview:toolBar];

    if(sender.view.tag==1){
        firstlbl.layer.borderColor=[[UIColor grayColor] CGColor];
        worklocation_lbl.layer.borderColor=[[UIColor grayColor] CGColor];
        barButtonDone.tag=3;
        establishPickerView.tag=1;
        [UIView animateWithDuration:0.25 delay:0.0 options: UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             // self.view.frame=CGRectMake(0, -30, 320, 200);
                             subview.frame=CGRectMake(0, 240, 320, 180);
                             [scroller scrollRectToVisible:CGRectMake(0, 280, scroller.frame.size.width, scroller.frame.size.height) animated:YES];
                         }
                         completion:^(BOOL finished){
                             if(finished)  {NSLog(@"Finished end !!!!!");
                             }
                         }];
       /* [self requestForEstablishType:^(BOOL result) {
            if (result) {
                barButtonDone.tag=3;
                establishPickerView.tag=1;
                [UIView animateWithDuration:0.25 delay:0.0 options: UIViewAnimationOptionCurveEaseInOut
                                 animations:^{
                                     // self.view.frame=CGRectMake(0, -30, 320, 200);
                                     subview.frame=CGRectMake(0, 240, 320, 180);
                                     [scroller scrollRectToVisible:CGRectMake(0, 280, scroller.frame.size.width, scroller.frame.size.height) animated:YES];
                                 }
                                 completion:^(BOOL finished){
                                     if(finished)  {NSLog(@"Finished end !!!!!");
                                     }
                                 }];
            }
        }];
    */
    }
    if(sender.view.tag==2){
        lbl1.layer.borderColor=[[UIColor grayColor] CGColor];
        worklocation_lbl1.layer.borderColor=[[UIColor grayColor] CGColor];
        barButtonDone.tag=4;
        establishPickerView.tag=2;
        [UIView animateWithDuration:0.25 delay:0.0 options: UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             // self.view.frame=CGRectMake(0, -30, 320, 200);
                             subview.frame=CGRectMake(0, 240, 320, 180);
                             [scroller scrollRectToVisible:CGRectMake(0, 365, scroller.frame.size.width, scroller.frame.size.height) animated:YES];
                         }
                         completion:^(BOOL finished){
                             if(finished)  {NSLog(@"Finished end !!!!!");
                             }
                         }];
   /*     [self requestForEstablishType:^(BOOL result) {
            if (result) {
        barButtonDone.tag=4;
        establishPickerView.tag=2;
        [UIView animateWithDuration:0.25 delay:0.0 options: UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             // self.view.frame=CGRectMake(0, -30, 320, 200);
                             subview.frame=CGRectMake(0, 240, 320, 180);
                             [scroller scrollRectToVisible:CGRectMake(0, 365, scroller.frame.size.width, scroller.frame.size.height) animated:YES];
                         }
                         completion:^(BOOL finished){
                             if(finished)  {NSLog(@"Finished end !!!!!");
                             }
                         }];
            }
        }
         ];*/
    }
    if(sender.view.tag==3){
        lbl2.layer.borderColor=[[UIColor grayColor] CGColor];
        worklocation_lbl2.layer.borderColor=[[UIColor grayColor] CGColor];
        barButtonDone.tag=5;
        establishPickerView.tag=3;
        [UIView animateWithDuration:0.25 delay:0.0 options: UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             // self.view.frame=CGRectMake(0, -30, 320, 200);
                             subview.frame=CGRectMake(0, 240, 320, 180);
                             [scroller scrollRectToVisible:CGRectMake(0, 450, scroller.frame.size.width, scroller.frame.size.height) animated:YES];
                         }
                         completion:^(BOOL finished){
                             if(finished)  {NSLog(@"Finished end !!!!!");
                             }
                         }];
    /*    [self requestForEstablishType:^(BOOL result) {
            if (result) {
        barButtonDone.tag=5;
        establishPickerView.tag=3;
        [UIView animateWithDuration:0.25 delay:0.0 options: UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             // self.view.frame=CGRectMake(0, -30, 320, 200);
                             subview.frame=CGRectMake(0, 240, 320, 180);
                             [scroller scrollRectToVisible:CGRectMake(0, 450, scroller.frame.size.width, scroller.frame.size.height) animated:YES];
                         }
                         completion:^(BOOL finished){
                             if(finished)  {NSLog(@"Finished end !!!!!");
                             }
                         }];
            }
        }]; */
    }
    [txt_address resignFirstResponder];
    [txt_contactNo resignFirstResponder];
    [txt_firstName resignFirstResponder];
    [txt_lastName resignFirstResponder];
    [txt_zipcode resignFirstResponder];
    [txt_gratuityAmount resignFirstResponder];
}

-(void)requestForEstablishType:(void (^)(BOOL result)) return_block{

    ASIFormDataRequest *_request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:URLEstablishmentList]];
    __unsafe_unretained ASIFormDataRequest *request = _request;
    [request setDelegate:self];



    [request setCompletionBlock:^{
        NSDictionary *root = [NSJSONSerialization JSONObjectWithData:request.responseData options:0 error:nil];
        NSLog(@"establishtype root %@",root);
        establishTypeDataArray=root[@"data"];
        [establishPickerView reloadAllComponents];
        return_block(TRUE);
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

#pragma mark - datepicker action
-(void)labelTap:(UIGestureRecognizer *)sender{
    
    datePicker.hidden=NO;
    //    df=[NSDateFormatter da
    
    saveButton.userInteractionEnabled=NO;
    charityPicker.hidden=YES;
    UIToolbar *toolBar=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
	UIBarButtonItem *barButtonDone = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                      style:UIBarButtonItemStyleBordered target:self action:@selector(doneAction:)];
    barButtonDone.tag=2;
    UIBarButtonItem *barButtonCancel = [[UIBarButtonItem alloc] initWithTitle:@"Cancel"
                                                                      style:UIBarButtonItemStyleBordered target:self action:@selector(CancelAction:)];
    barButtonCancel.tag=4;
    UIBarButtonItem *flexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    flexible.width=200;
    toolBar.items = [[NSArray alloc] initWithObjects:barButtonDone,flexible,barButtonCancel,nil];
    toolBar.translucent=NO;
    toolBar.barTintColor=RGB(155, 130, 110);
    [subview addSubview:toolBar];
    [UIView animateWithDuration:0.25 delay:0.0 options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         // self.view.frame=CGRectMake(0, -30, 320, 200);
                         subview.frame=CGRectMake(0, 240, 320, 180);
                     }
                     completion:^(BOOL finished){
                         if(finished)  {NSLog(@"Finished end !!!!!");
                         }
                     }];
    [txt_firstName resignFirstResponder];
    [txt_lastName resignFirstResponder];
    [txt_zipcode resignFirstResponder];
    [txt_contactNo resignFirstResponder];
    [txt_address resignFirstResponder];
    [txt_gratuityAmount resignFirstResponder];
}
-(IBAction)CancelAction:(id)sender{
    if([editProfileDictionay[@"dob"]  isEqual:(id)[NSNull null]]){
        datePicker.date=[NSDate date];
        lbl_birthdate.text=@"Birthdate";
    }
    else{
        lbl_birthdate.text=d1;
        datePicker.date=dt;
    }

    [UIView animateWithDuration:0.25 delay:0.0 options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         // self.view.frame=CGRectMake(0, -30, 320, 200);
                         subview.frame=CGRectMake(0, 640, 320, 180);
                     }
                     completion:^(BOOL finished){
                         if(finished)  {NSLog(@"Finished end !!!!!");
                             saveButton.userInteractionEnabled=YES;
                         }
                     }];
}
-(IBAction)doneAction:(id)sender{
    if([sender tag]==2){
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
                             if(finished)  {NSLog(@"Finished end !!!!!");
                             saveButton.userInteractionEnabled=YES;}
                         }];
    }
    NSLog(@"%d",f);
    }
    if([sender tag]==1){
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
                             if(finished)  {NSLog(@"Finished end !!!!!");
                             saveButton.userInteractionEnabled=YES;}
                         }];
    }
    if([sender tag]==3){
        [UIView animateWithDuration:0.25 delay:0.0 options: UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             // self.view.frame=CGRectMake(0, -30, 320, 200);
                             subview.frame=CGRectMake(0, 640, 320, 180);
                             [scroller scrollRectToVisible:CGRectMake(0, 150, scroller.frame.size.width, scroller.frame.size.height) animated:YES];
                             //                             CGRect f1;
                             //                             f1=self.view.frame;
                             //                             f1.origin.y=f1.origin.y-100;
                             // self.view.frame=f1;
                             // v1.backgroundColor=[UIColor blackColor];
                         }
                         completion:^(BOOL finished){
                             if(finished)  {NSLog(@"Finished end !!!!!");
                                 saveButton.userInteractionEnabled=YES;}
                         }];
    }
    if([sender tag]==4){
        [UIView animateWithDuration:0.25 delay:0.0 options: UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             // self.view.frame=CGRectMake(0, -30, 320, 200);
                             subview.frame=CGRectMake(0, 640, 320, 180);
                             [scroller scrollRectToVisible:CGRectMake(0, 250, scroller.frame.size.width, scroller.frame.size.height) animated:YES];
                             //                             CGRect f1;
                             //                             f1=self.view.frame;
                             //                             f1.origin.y=f1.origin.y-100;
                             // self.view.frame=f1;
                             // v1.backgroundColor=[UIColor blackColor];
                         }
                         completion:^(BOOL finished){
                             if(finished)  {NSLog(@"Finished end !!!!!");
                                 saveButton.userInteractionEnabled=YES;}
                         }];
    }
    if([sender tag]==5){
        [UIView animateWithDuration:0.25 delay:0.0 options: UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             // self.view.frame=CGRectMake(0, -30, 320, 200);
                             subview.frame=CGRectMake(0, 640, 320, 180);
                             [scroller scrollRectToVisible:CGRectMake(0, 350, scroller.frame.size.width, scroller.frame.size.height) animated:YES];
                             //                             CGRect f1;
                             //                             f1=self.view.frame;
                             //                             f1.origin.y=f1.origin.y-100;
                             // self.view.frame=f1;
                             // v1.backgroundColor=[UIColor blackColor];
                         }
                         completion:^(BOOL finished){
                             if(finished)  {NSLog(@"Finished end !!!!!");
                                 saveButton.userInteractionEnabled=YES;}
                         }];
    }
    if([sender tag]==6){
        NSLog(@"Charity Picker Done");
        [UIView animateWithDuration:0.25 delay:0.0 options: UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             // self.view.frame=CGRectMake(0, -30, 320, 200);
                             subview.frame=CGRectMake(0, 640, 320, 180);
                             [scroller scrollRectToVisible:CGRectMake(0, 0, scroller.frame.size.width, scroller.frame.size.height) animated:YES];
                             //                             CGRect f1;
                             //                             f1=self.view.frame;
                             //                             f1.origin.y=f1.origin.y-100;
                             // self.view.frame=f1;
                             // v1.backgroundColor=[UIColor blackColor];
                         }
                         completion:^(BOOL finished){
                             if(finished)  {NSLog(@"Finished end !!!!!");
                                 saveButton.userInteractionEnabled=YES;}
                         }];
    }
    
    
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


#pragma mark - save information method
- (IBAction)saveInfoAction:(id)sender {
    NSLog(@" amount %d",[[txt_gratuityAmount.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] integerValue]);
    if([[txt_firstName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]<=0 || [[txt_lastName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]<=0)
    {
        [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                        type:AJNotificationTypeRed
                                       title:@"Please Enter firstname and lastname."
                             linedBackground:AJLinedBackgroundTypeDisabled
                                   hideAfter:GZAJNotificationDelay];
        if([txt_firstName.text length]==0){
            [self chagneTextFieldStyle:txt_firstName];
        }
        if ([txt_lastName.text length]==0) {
            [self chagneTextFieldStyle:txt_lastName];
        }
    }
    else if([txt_zipcode.text isEqualToString:@"00000"]){
        [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                        type:AJNotificationTypeRed
                                       title:@"ZipCode Not Valid"
                             linedBackground:AJLinedBackgroundTypeDisabled
                                   hideAfter:GZAJNotificationDelay];
        [self chagneTextFieldStyle:txt_zipcode];
    }
    else if (([charityId length]>0 || [charityEmail length]>0) && [[txt_gratuityAmount.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]<=0){
        [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                        type:AJNotificationTypeRed
                                       title:@"Enter Donation Percentage."
                             linedBackground:AJLinedBackgroundTypeDisabled
                                   hideAfter:GZAJNotificationDelay];
        [self chagneTextFieldStyle:txt_gratuityAmount];
    }
    else if ( [[txt_gratuityAmount.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]  length]>0 && ([[txt_gratuityAmount.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] integerValue]<=0 ||[[txt_gratuityAmount.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] integerValue]>100) ){
        [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                        type:AJNotificationTypeRed
                                       title:@"Percentage should be 1 to 100."
                             linedBackground:AJLinedBackgroundTypeDisabled
                                   hideAfter:GZAJNotificationDelay];
        [self chagneTextFieldStyle:txt_gratuityAmount];
        return;
    }
   else if(number_of_textfields==3 && (establishmentId1 ==NULL || [worklocation_lbl.text isEqualToString:organizationString] || establishmentId2 ==NULL || [worklocation_lbl1.text isEqualToString:organizationString] || establishmentId3 ==NULL || [worklocation_lbl2.text isEqualToString:organizationString])){
        
        [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                        type:AJNotificationTypeRed
                                       title:@"Enter Establishment Details"
                             linedBackground:AJLinedBackgroundTypeDisabled
                                   hideAfter:GZAJNotificationDelay];
       
       if(establishmentId1==NULL){
           firstlbl.layer.borderColor=[[UIColor redColor] CGColor];
           worklocation_lbl.layer.borderColor=[[UIColor redColor] CGColor];
       }
       if(establishmentId2==NULL){
           lbl1.layer.borderColor=[[UIColor redColor] CGColor];
           worklocation_lbl1.layer.borderColor=[[UIColor redColor] CGColor];
       }
       if(establishmentId3==NULL){
           lbl2.layer.borderColor=[[UIColor redColor] CGColor];
           worklocation_lbl2.layer.borderColor=[[UIColor redColor] CGColor];
       }
        return;
    }
    else if(number_of_textfields==2 && (establishmentId1 ==NULL || [worklocation_lbl.text isEqualToString:organizationString] || establishmentId2 ==NULL || [worklocation_lbl1.text isEqualToString:organizationString])){
        [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                        type:AJNotificationTypeRed
                                       title:@"Enter Establishment Details"
                             linedBackground:AJLinedBackgroundTypeDisabled
                                   hideAfter:GZAJNotificationDelay];
        if(establishmentId1==NULL){
            firstlbl.layer.borderColor=[[UIColor redColor] CGColor];
            worklocation_lbl.layer.borderColor=[[UIColor redColor] CGColor];
        }
        if(establishmentId2==NULL){
            lbl1.layer.borderColor=[[UIColor redColor] CGColor];
            worklocation_lbl1.layer.borderColor=[[UIColor redColor] CGColor];
        }
        return;
    }
    else if(number_of_textfields==1 && (establishmentId1 ==NULL || [worklocation_lbl.text isEqualToString:organizationString])){
        [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                        type:AJNotificationTypeRed
                                       title:@"Enter Establishment Details"
                             linedBackground:AJLinedBackgroundTypeDisabled
                                   hideAfter:GZAJNotificationDelay];
        return;
    }
    else if ([[txt_gratuityAmount.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]>0 && ([charityId length]==0 && [charityEmail length]==0)){
        [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                        type:AJNotificationTypeRed
                                       title:@"Enter CharityDetails"
                             linedBackground:AJLinedBackgroundTypeDisabled
                                   hideAfter:GZAJNotificationDelay];
        view_charity.layer.borderColor=[[UIColor redColor] CGColor];
        return;
    }
    else if ([workLocationId1 integerValue]==[workLocationId2 integerValue] || [workLocationId1 integerValue]==[workLocationId3 integerValue] ){
        [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                        type:AJNotificationTypeRed
                                       title:@"Same Work Locations are not allow"
                             linedBackground:AJLinedBackgroundTypeDisabled
                                   hideAfter:GZAJNotificationDelay];
        return;
    }
    else if ( ![worklocation_lbl1.text isEqualToString:organizationString] &&([workLocationId2 integerValue]==[workLocationId3 integerValue])){
        [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                        type:AJNotificationTypeRed
                                       title:@"Same Work Locations are not allow"
                             linedBackground:AJLinedBackgroundTypeDisabled
                                   hideAfter:GZAJNotificationDelay];
        return;
    }
    else{
        NSMutableArray *objects=[[NSMutableArray alloc]init];
        NSMutableArray *keys=[[NSMutableArray alloc]init];
        [objects addObject:[txt_firstName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
        [keys addObject:@"first_name"];
        [objects addObject:[txt_lastName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
        [keys addObject:@"last_name"];
//        if(![txt_address.text isEqualToString:@"Address"] && [txt_address.text length]>0){
//            [objects addObject:txt_address.text];
//            [keys addObject:@"address"];
//        }
        if([[txt_contactNo.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]>0){
            [objects addObject:[txt_contactNo.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
            [keys addObject:@"contact_number"];
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
        [objects addObject:[[NSUserDefaults standardUserDefaults] valueForKey:@"userid"]];
        [keys addObject:@"service_providerId"];
        if(!btn_EnableSecondLogin.isHidden){
        [objects addObject:(btn_EnableSecondLogin.isSelected?@"true":@"false")];
        [keys addObject:@"isSender"];
        }
        [objects addObject:(btnShareProfile.isSelected?@"TRUE":@"FALSE")];
        
        [keys addObject:@"share_profile_rating"];
        if([charityId length]>0){
            [objects addObject:charityId];
            [keys addObject:@"charity_id"];
            [objects addObject:[txt_gratuityAmount.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
             [keys addObject:@"gratuity_percentage"];
        }
        if([charityName length]>0 && [charityEmail length]>0){
            NSLog(@"email of charity");
            NSLog(@"email %@ %@",charityEmail,charityName);
            [objects addObject:charityName];
            [keys addObject:@"charity_name"];
            [objects addObject:charityEmail];
            [keys addObject:@"charity_email"];
            [objects addObject:[txt_gratuityAmount.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
            [keys addObject:@"gratuity_percentage"];
        }
        NSDictionary *dict1,*dict2,*dict3;
          NSMutableDictionary *senderEditProfile=[[NSMutableDictionary alloc]initWithObjects:objects forKeys:keys];
      //  NSMutableDictionary *final=[[NSMutableDictionary alloc]init];
        if(establishmentId1!=NULL &&  workLocationId1!=NULL){
            dict1=[[NSDictionary alloc]initWithObjectsAndKeys:establishmentId1,@"e_id",workLocationId1,@"organization_id", nil];
            [senderEditProfile setValue:dict1 forKey:@"workLocation1"];
        }
        if(establishmentId2!=NULL && workLocationId2!=NULL){
            dict2=[[NSDictionary alloc]initWithObjectsAndKeys:establishmentId2,@"e_id",workLocationId2,@"organization_id", nil];
            [senderEditProfile setValue:dict2 forKey:@"workLocation2"];
        }
        if(establishmentId3!=NULL && workLocationId3!=NULL){
            dict3=[[NSDictionary alloc]initWithObjectsAndKeys:establishmentId3,@"e_id",workLocationId3,@"organization_id", nil];
            [senderEditProfile setValue:dict3 forKey:@"workLocation3"];
        }
       // [final setValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"userid"] forKey:@"service_providerId"];
      
        ASIFormDataRequest *_request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:URLSaveServiceProviderEditProfile]];
        __unsafe_unretained ASIFormDataRequest *request = _request;
        
        [request appendPostData:[[NSString stringWithFormat:@"%@",senderEditProfile] dataUsingEncoding:NSUTF8StringEncoding]];
        NSLog(@"%@",senderEditProfile);
        [request setCompletionBlock:^{
            NSMutableDictionary *root = [NSJSONSerialization JSONObjectWithData:[request responseData] options:0 error:nil];
            NSLog(@"EditProfile Root %@",root);
            [[NSUserDefaults standardUserDefaults] setValue:txt_firstName.text forKey:@"first_name"];
            [[NSUserDefaults standardUserDefaults] setValue:txt_lastName.text forKey:@"last_name"];
            if(!btn_EnableSecondLogin.isHidden){
            [[NSUserDefaults standardUserDefaults] setValue:(btn_EnableSecondLogin.isSelected?@"1":@"0") forKey:@"isSender"];
            if(btn_EnableSecondLogin.isSelected){
                btn_EnableSecondLogin.hidden=YES;
                lbl_SecondLogin.hidden=YES;
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
            NSError *Error=[request error];
            [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                            type:AJNotificationTypeRed
                                           title:Error.localizedDescription
                                 linedBackground:AJLinedBackgroundTypeDisabled
                                       hideAfter:GZAJNotificationDelay];
        }];
        [request startAsynchronous];
    }
}


#pragma mark - checkbox button method

- (IBAction)btnShareProfileAction:(id)sender {
    if(![btnShareProfile isSelected]){
        [btnShareProfile setSelected:YES];
    }
    else{
        [btnShareProfile setSelected:NO];
    }
}

#pragma mark - picker view method

- (void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component {
    NSLog(@"%d",row);
    if(pickerView==charityPicker){
    lbl_charitydisplay.text=[searchedName objectAtIndex:row];
    NSDictionary *dictionary=[dataArray objectAtIndex:row];
    charityId=[dictionary[@"charityId"] stringValue];
    NSLog(@"id is%@",charityId);
    charityName=@"";
    charityEmail=@"";
    btn_removeCharity.hidden=NO;
    }
    if(pickerView==establishPickerView){
        if(establishPickerView.tag==1){
            establsihTypeDataDictionary=[establishTypeDataArray objectAtIndex:row];
            firstlbl.text=establsihTypeDataDictionary[@"establishmentName"];
            establishmentId1=establsihTypeDataDictionary[@"establishmentId"];
            worklocation_lbl.text=organizationString;
            workLocationId1=NULL;
        }
        if(establishPickerView.tag==2){
            establsihTypeDataDictionary=[establishTypeDataArray objectAtIndex:row];
            lbl1.text=establsihTypeDataDictionary[@"establishmentName"];
            establishmentId2=establsihTypeDataDictionary[@"establishmentId"];
            worklocation_lbl1.text=organizationString;
            workLocationId2=NULL;
        }

        if(establishPickerView.tag==3){
            establsihTypeDataDictionary=[establishTypeDataArray objectAtIndex:row];
            lbl2.text=establsihTypeDataDictionary[@"establishmentName"];
            establishmentId3=establsihTypeDataDictionary[@"establishmentId"];
            worklocation_lbl2.text=organizationString;
            workLocationId3=NULL;
        }

    }
}

// tell the picker how many rows are available for a given component
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if(pickerView==charityPicker){
    return [searchedName count];
    }
    if(pickerView==establishPickerView){
        NSLog(@"return");
        return [establishTypeDataArray count];
    }
    return 1;
}



// tell the picker how many components it will have
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    UILabel* tView = (UILabel*)view;
    if (!tView){
        tView = [[UILabel alloc] init];
         tView.font=[UIFont fontWithName:@"Garamond" size:15.0f];
      }
    // Fill the label text here
    if(pickerView==charityPicker){
    tView.text=[searchedName objectAtIndex:row];
   
    }
    if(pickerView==establishPickerView){
        establsihTypeDataDictionary=[establishTypeDataArray objectAtIndex:row];
        tView.text=establsihTypeDataDictionary[@"establishmentName"];
    }
    NSLog(@"=======)%@",tView.text);
    [tView setLineBreakMode:NSLineBreakByCharWrapping];
    [tView setNumberOfLines:0];
    return tView;
}


// tell the picker the title for a given component
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *title;
    title=@"The Grand Bhagvati  S G Highway";
    
    return title;
}

// tell the picker the width of each row for a given component
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    int sectionWidth = 300;
    
    return sectionWidth;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    
    NSString *text =@"hello";
    //   NSLog(@"%@ %@",str.text,text);
    
    CGSize constraintSize = CGSizeMake(320.0f, MAXFLOAT);  // Make changes in width as per your label requirement.
    
    CGRect textRect = [text boundingRectWithSize:constraintSize
                                         options:NSStringDrawingUsesLineFragmentOrigin
                                      attributes:@{NSFontAttributeName:[UIFont fontWithName:@"Avenir" size:17]}
                                         context:nil];
    CGSize size = textRect.size;
    NSLog(@"textSize :: %f",size.height);
    
    
    return  size.height;
}

-(void)requestForCharityList{
    ASIFormDataRequest *_request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:URLCharityList]];
    __unsafe_unretained ASIFormDataRequest *request = _request;
    [request setDelegate:self];
    [request setCompletionBlock:^{
        NSDictionary *root=[NSJSONSerialization JSONObjectWithData:[request responseData] options:0 error:nil];
        //  isData=@"yes";//[root valueForKey:@"isData"];
        NSLog(@"charity root..%@",root);
        if([root[@"isError"] boolValue]==1){
            
        }
        else{
            dataArray=[[NSMutableArray alloc]init];
            dataArray=root[@"data"];
            NSMutableDictionary *object=[[NSMutableDictionary alloc]init];
            searchedName=[[NSMutableArray alloc]init];
            for(int i=0;i<[dataArray count];i++){
                object=[dataArray objectAtIndex:i];
                [searchedName addObject:object[@"charityName"]];
            }
        }
        
        NSLog(@"searched name%@",searchedName);
        [charityPicker reloadAllComponents];
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

-(void)charityLabelTap:(UIGestureRecognizer *)sender{
    [self requestForCharityList];
    view_charity.layer.borderColor=[[UIColor grayColor] CGColor];
    datePicker.hidden=YES;
    charityPicker.hidden=NO;
    saveButton.userInteractionEnabled=NO;
    UIToolbar *toolBar=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
	UIBarButtonItem *barButtonDone = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                      style:UIBarButtonItemStyleBordered target:self action:@selector(doneAction:)];
    barButtonDone.tag=6;
    UIBarButtonItem *barButtonOther = [[UIBarButtonItem alloc] initWithTitle:@"Other"
                                                                       style:UIBarButtonItemStyleBordered target:self action:@selector(otherAction:)];
    barButtonOther.tag=5;
    UIBarButtonItem *flexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    flexible.width=200;
    toolBar.items = [[NSArray alloc] initWithObjects:barButtonDone,flexible,barButtonOther,nil];
    toolBar.translucent=NO;
    toolBar.barTintColor=RGB(155, 130, 110);
    [subview addSubview:toolBar];
    [UIView animateWithDuration:0.25 delay:0.0 options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         // self.view.frame=CGRectMake(0, -30, 320, 200);
                         subview.frame=CGRectMake(0, 240, 320, 180);
                         [scroller scrollRectToVisible:CGRectMake(0, 30, scroller.frame.size.width, scroller.frame.size.height) animated:YES];
                     }
                     completion:^(BOOL finished){
                         if(finished)  {NSLog(@"Finished end !!!!!");
                         }
                     }];
    [txt_firstName resignFirstResponder];
    [txt_lastName resignFirstResponder];
    [txt_zipcode resignFirstResponder];
    [txt_contactNo resignFirstResponder];
    [txt_address resignFirstResponder];
    [txt_gratuityAmount resignFirstResponder];
}

-(IBAction)otherAction:(id)sender{
    CharityDetailViewController *CDVC=[[CharityDetailViewController alloc]init ];//WithNibName:@"CharityDetailViewController" bundle:nil];
    [UIView animateWithDuration:0.25 delay:0.0 options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         // self.view.frame=CGRectMake(0, -30, 320, 200);
                         subview.frame=CGRectMake(0, 640, 320, 180);
                        }
                     completion:^(BOOL finished){
                         if(finished)  {NSLog(@"Finished end !!!!!");
                             saveButton.userInteractionEnabled=YES;
                             CDVC.delegate=self;
                             [self.navigationController pushViewController:CDVC animated:YES];
                         }
                     }];
    
    
}

-(void)charityName:(NSString *)name mail:(NSString *)Email{
    charityName=name;
    lbl_charitydisplay.text=name;
    charityEmail=Email;
    charityId=@"";
    btn_removeCharity.hidden=NO;
}

- (IBAction)btn_help:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Help"
                                                    message:@"Enter Amount Of Percentage To Donate To Selected Charity."
                                                   delegate:self
                                          cancelButtonTitle:@"Ok"
                                          otherButtonTitles:nil];
    alert.tag=1;
    [alert show];
}

- (IBAction)enableSecondLoginAction:(id)sender {
    if(![btn_EnableSecondLogin isSelected]){
        [btn_EnableSecondLogin setSelected:YES];
    }
    else{
        [btn_EnableSecondLogin setSelected:NO];
    }
}

- (IBAction)removeCharityAction:(id)sender {
    lbl_charitydisplay.text=@"Add Charity";
    txt_gratuityAmount.text=@"";
    charityId=@"";
    charityEmail=@"";
    charityName=@"";
    btn_removeCharity.hidden=YES;
    
}
-(void)establishSave:(NSString *)flag{}

#pragma mark-Delegate Method from WorkDetailViewController
-(void)organizationInfo:(NSString *) organization_id name:(NSString *)name tag:(int )tag{
    if(tag==1){
        worklocation_lbl.text=name;
        workLocationId1=organization_id;
    }
    else if(tag==2){
        worklocation_lbl1.text=name;
        workLocationId2=organization_id;
    }
    else if (tag==3) {
        worklocation_lbl2.text=name;
        workLocationId3=organization_id;
    }
}

-(void)workInfo:(NSString *) organization_id name:(NSString *)name tag:(int )tag{
    NSLog(@"helloooooo");
    NSLog(@"%@ %@ %d",organization_id,name,tag);
    if(tag==1){
        worklocation_lbl.text=name;
        workLocationId1=organization_id;
    }
    else if(tag==2){
        worklocation_lbl1.text=name;
        workLocationId2=organization_id;
    }
    else if (tag==3) {
        worklocation_lbl2.text=name;
        workLocationId3=organization_id;
    }
}

@end
