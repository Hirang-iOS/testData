//
//  ServiceProviderProfileViewController.m
//  GratZeez
//
//  Created by cloudZon Infosoft on 09/11/13.
//  Copyright (c) 2013 cloudZon Infosoft. All rights reserved.
//

#import "ServiceProviderProfileViewController.h"
#import "RadioButtonView.h"
#import "WorkLocationDetailsViewController.h"
@interface ServiceProviderProfileViewController ()

@end

@implementation ServiceProviderProfileViewController
@synthesize btnShareProfile,btnAgreeTerm,gratuityStr,paymentStr,proImage,uploadImgButton,lbl_charityname,txt_gratuity,txtgratuity,lblFundTransfer,lbl_agreeterms,lbl_sharerating,lblReceiveGratuity,saveImageButton,view_scroll,view_agreeterms_continue,isWorkLocationEntered,btn_cancel;
@synthesize completeProServiceToolbar;
WorkLocationViewController *workVC;
WorkLocationDetailsViewController *workDetailVC;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
//    if(MyAppDelegate.isiPhone5){
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    }
//    else{
//    self = [super initWithNibName:@"ServiceProviderProfileViewController4S" bundle:[NSBundle mainBundle]];
//    }if (self) {
//        // Custom initialization
//    }
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    //[self requestForCharityList];
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
   
    self.title = @"Complete Profile";
   
    [self requestForEstablishType:^(BOOL result) {
        if (result){
            [establishPicker reloadAllComponents];
        }
    }];
    
    [self.view setUserInteractionEnabled:YES];
    view_scroll.contentSize=CGSizeMake(320, 900);
    self.navigationController.navigationBar.translucent = YES;
    NSArray *ver = [[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."];
    NSLog(@"ver is%@",ver);

       view_scroll.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"complete_profile_bg"]];
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])self.edgesForExtendedLayout = UIRectEdgeNone;
   

      NSArray *option=@ [@"Cash",@"Donation to charity",@"Both"];
    if(MyAppDelegate.isiPhone5){
        gratuityGroup =[[RadioButtonView alloc]initWithFrame:CGRectMake(5, 200, 320, 40) andOptions:option andColumns:3];
        gratuityGroup.delegate=self;
        option=@[@"Credit Card/PayPal",@"Bank Acc"];
        paymentGroup=[[RadioButtonView alloc]initWithPayPalFrame:CGRectMake(5, 74, 320, 40) andOptions:option andColumns:2 tag:0];
      //  paymentGroup=[[RadioButtonView alloc]initWithFrame:CGRectMake(5, 353, 320, 40) andOptions:option andColumns:3];
    }
    else{
        gratuityGroup =[[RadioButtonView alloc]initWithFrame:CGRectMake(5, 175, 320, 40) andOptions:option andColumns:3];
        option=@[@"Credit Card/PayPal",@"Bank Acc",];
        paymentGroup=[[RadioButtonView alloc]initWithPayPalFrame:CGRectMake(5, 310, 320, 40) andOptions:option andColumns:2 tag:0];
    }
    [view_scroll addSubview:gratuityGroup];
	[gratuityGroup setSelected:0];
	//[group clearAll];
	//[group removeButtonAtIndex:2];
    
    NSMutableAttributedString *receiveGratuity = [[NSMutableAttributedString alloc] initWithString:@"Receive Gratuity as:"];
    [receiveGratuity addAttribute:(NSString*)kCTUnderlineStyleAttributeName
                      value:[NSNumber numberWithInt:kCTUnderlineStyleSingle]
                      range:(NSRange){0,[receiveGratuity length]}];
    self.lblReceiveGratuity.attributedText = receiveGratuity;
    self.lblReceiveGratuity.textColor = [UIColor blackColor];
    
    NSMutableAttributedString *fundString = [[NSMutableAttributedString alloc] initWithString:@"Fund Transfer Method:"];
    [fundString addAttribute:(NSString*)kCTUnderlineStyleAttributeName
                            value:[NSNumber numberWithInt:kCTUnderlineStyleSingle]
                            range:(NSRange){0,[fundString length]}];
    self.lblFundTransfer.attributedText = fundString;
    self.lblFundTransfer.textColor = [UIColor blackColor];
    
    uploadImgButton.hidden=NO;
    saveImageButton.hidden=YES;
    [ratingView addSubview:paymentGroup];
    [paymentGroup setPayPalSelected:0];
    NSString *urlString=[ImageURL stringByAppendingPathComponent:[[NSUserDefaults standardUserDefaults] valueForKey:@"profile-picture"]];
    //imgData=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]];
    proImage.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]]];
    proImage.backgroundColor=[UIColor clearColor];
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"UserLogedInType"] intValue] != LoginTypeFacebook){
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTapped:)];
        proImage.userInteractionEnabled = YES;
        [proImage addGestureRecognizer:tap];
      
        uploadImgButton.layer.borderWidth=0.3;
        uploadImgButton.layer.cornerRadius=3.0;
        uploadImgButton.layer.masksToBounds=YES;
        saveImageButton.layer.borderWidth=0.3;
        saveImageButton.layer.cornerRadius=3.0;
        saveImageButton.layer.masksToBounds=YES;
        uploadImgButton.hidden=NO;
        saveImageButton.hidden=YES;
        uploadImgButton.titleLabel.font=[UIFont fontWithName:GZFont size:15];
        saveImageButton.titleLabel.font=[UIFont fontWithName:GZFont size:15];
    }
    else{
        uploadImgButton.hidden=YES;
        saveImageButton.hidden=YES;
    }
    proImage.layer.borderWidth=0.5;
    proImage.layer.cornerRadius=3.0;
    proImage.layer.masksToBounds=YES;
    UIBarButtonItem *btnHelp = [[UIBarButtonItem alloc] initWithTitle:@"Help" style:UIBarButtonItemStylePlain target:self action:@selector(btnHelpAction:)];
    self.navigationItem.rightBarButtonItem=btnHelp;
    
    [btnHelp setTitleTextAttributes:textAttributes forState:UIControlStateNormal];
    [self.view addSubview:picker_view];
    //txtGratuity.userInteractionEnabled=NO;
    // Do any additional setup after loading the view from its nib.
    
    lbl_charityname.font=[UIFont systemFontOfSize:14.0f];
    lbl_charityname.opaque=NO;
    lbl_charityname.textAlignment = NSTextAlignmentLeft;
    lbl_charityname.userInteractionEnabled=YES;
    
    
    //pickerview
    subview=[[UIView alloc]initWithFrame:CGRectMake(0, 640, 320, 200)];
//    toolBar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,0,320,40)];
//    toolBar.translucent=NO;
//    UIBarButtonItem *barButtonDone = [[UIBarButtonItem alloc] initWithTitle:@"Done"
//                                                                      style:UIBarButtonItemStyleBordered target:self action:@selector(doneAction:)];
//    UIBarButtonItem *barButtonOther = [[UIBarButtonItem alloc] initWithTitle:@"Other"
//                                                                               style:UIBarButtonItemStyleBordered target:self action:@selector(otherAction:)];
//    UIBarButtonItem *flexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
//    flexible.width=200;
//    toolBar.items = [[NSArray alloc] initWithObjects:barButtonDone,flexible,barButtonOther,nil];
//    toolBar.barTintColor=RGB(155, 130, 110);
//    barButtonDone.tintColor=[UIColor redColor];
//    barButtonOther.tintColor=[UIColor redColor];
    charityPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 40, 320, 185)];
    charityPicker.delegate = self;
    charityPicker.dataSource=self;
    charityPicker.showsSelectionIndicator = YES;
    charityPicker.backgroundColor=RGB(210, 200, 191);
    [subview addSubview:charityPicker];
    //[subview addSubview:toolBar];
    [self.view  addSubview:subview];
    subview.hidden=YES;
    UITapGestureRecognizer *tapGesture =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelTap)];
    [lbl_charityname addGestureRecognizer:tapGesture];
    lbl_charityname.userInteractionEnabled=NO;
    txt_gratuity.userInteractionEnabled=NO;

    
    lbl_sharerating.font=[UIFont fontWithName:GZFont size:16.0f];
    lbl_agreeterms.font=[UIFont fontWithName:GZFont size:16.0f];
    lbl_charityname.font=[UIFont fontWithName:GZFont size:16.0f];
    lblFundTransfer.font=[UIFont fontWithName:GZFont size:16.0f];
    lblReceiveGratuity.font=[UIFont fontWithName:GZFont size:16.0f];
    txtgratuity.font=[UIFont fontWithName:GZFont size:13.0f];
    txtgratuity.textColor=[UIColor whiteColor];
    usernameLabel.font=[UIFont fontWithName:GZFont size:16.0f];
    isWorkLocationEntered=@"NO";
    charityBoxView.backgroundColor=[UIColor clearColor];
    charityView.backgroundColor=[UIColor clearColor];
    ratingView.backgroundColor=[UIColor clearColor];
    [[UIBarButtonItem appearance] setTitleTextAttributes:textAttributesTabBar forState:UIControlStateNormal];
   // self.navigationController.navigationBar.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"top_bar"]];
    
    
    
    //Wrok Info
    
    view_agreeterms_continue.backgroundColor=[UIColor clearColor];
    
    number_of_textfields = 1;
    space_between_textfield = 5.0;
    frame_y=140;
    height_of_component=30;
    width_of_lbl=180;
    
    establishPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 40, 320, 185)];
    establishPicker.delegate = self;
    establishPicker.backgroundColor=RGB(210, 200, 191);
    establishPicker.showsSelectionIndicator = YES;
    [subview addSubview:establishPicker];
    establishPicker.hidden=YES;
    lblEstablishment.userInteractionEnabled = YES;
    // ary=[[NSMutableArray alloc]initWithObjects:@"hello",@"hi",@"good morning",@"good night",@"good afternoon", nil];
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
    [rm1 setImage:[UIImage imageNamed:@"minus_white"] forState:UIControlStateNormal];
    //[rm1 setTitle:@"remove" forState:UIControlStateNormal];
    [rm1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    rm1.tag=1;
    
    
    // txt2=[[UITextField alloc]init];
    rm2=[UIButton buttonWithType:UIButtonTypeCustom];
    [rm2 addTarget:self action:@selector(removetxt:) forControlEvents:UIControlEventTouchUpInside];
    [rm2 setImage:[UIImage imageNamed:@"minus_white"] forState:UIControlStateNormal];
    //[rm2 setTitle:@"remove" forState:UIControlStateNormal];
    [rm2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    rm2.tag=2;
    
    
    
    
    btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"plus_white"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(addtxtfld:) forControlEvents:UIControlEventTouchUpInside];
    btn.frame=CGRectMake(30,worklocation_lbl.frame.origin.y+height_of_component+space_between_textfield, 50, 24);
    view_agreeterms_continue.frame=CGRectMake(0, btn.frame.origin.y+30, 320, 94);
    frame_y=worklocation_lbl.frame.origin.y;
    
    [ratingView addSubview:firstlbl];
    [ratingView addSubview:worklocation_lbl];
    [ratingView addSubview:btn];
    
    UITapGestureRecognizer *tapGesture_1 =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(establishLabelTap:)];
    [firstlbl addGestureRecognizer:tapGesture_1];
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
    
    [txt_gratuity addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    lbl_workInfo.font=[UIFont fontWithName:GZFont size:16];
    btn_cancel.hidden=YES;
    
    completeProServiceToolbar.frame=CGRectMake(0,524, 320, 44);
    [self.view addSubview:completeProServiceToolbar];
    [completeProServiceToolbar setBackgroundImage:toolBarImage forToolbarPosition:UIBarPositionBottom barMetrics:UIBarMetricsDefault];
    [self addLeftMenuButtonWithImage:[UIImage imageNamed:@"menu_icon"]];
    [self addrightMenuButtonWithImage:[UIImage imageNamed:@"help"]];
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureCaptured:)];
    [view_scroll addGestureRecognizer:singleTap];
    
}
-(void)singleTapGestureCaptured:(id)sender{
    [UIView animateWithDuration:0.30 delay:0.05 options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         // self.view.frame=CGRectMake(0, -30, 320, 200);
                         subview.hidden=NO;
                         subview.frame=CGRectMake(0,640, 320, subview.frame.size.height);
                         //[view_scroll   scrollRectToVisible:CGRectMake(0, 140, view_scroll.frame.size.width, view_scroll.frame.size.height) animated:YES];
                     }
                     completion:^(BOOL finished){
                         if(finished)  {NSLog(@"Finished end !!!!!");
                         }
                     }];
}
-(void)viewDidAppear:(BOOL)animated{
    NSLog(@"%f %f",self.view.frame.origin.y,self.view.frame.size.height);
}

#pragma mark-work info method

-(IBAction)addtxtfld:(id)sender{
    NSLog(@"method called");
    if(number_of_textfields==1){
        [view_scroll scrollRectToVisible:CGRectMake(0, 80, view_scroll.frame.size.width, view_scroll.frame.size.height) animated:YES];
    }
    if(number_of_textfields==2){
        [view_scroll scrollRectToVisible:CGRectMake(0, 140, view_scroll.frame.size.width, view_scroll.frame.size.height) animated:YES];
    }
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
           view_agreeterms_continue.frame=CGRectMake(0, btn.frame.origin.y+30, 320, 94);
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
        view_agreeterms_continue.frame=CGRectMake(0, btn.frame.origin.y+30, 320, 94);
            number_of_textfields -=1;
            frame_y=worklocation_lbl.frame.origin.y;
            NSLog(@"%d",number_of_textfields);
        }
        
    }
    if([sender tag]==2){
        
        if(number_of_textfields==2){
            NSLog(@"tag 2 fld 2");
            btn.frame=CGRectMake(30, worklocation_lbl.frame.origin.y+height_of_component+space_between_textfield, 50, height_of_component);
          view_agreeterms_continue.frame=CGRectMake(0, btn.frame.origin.y+30, 320, 94);
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
          view_agreeterms_continue.frame=CGRectMake(0, btn.frame.origin.y+30, 320, 94);
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
    subview.frame=CGRectMake(0, 640, 320, 200);
    subview.hidden=YES;
}

-(void)showEstablishSecond{
    NSLog(@"creating secondestablish");
    NSLog(@"frame of second from est %f",frame_y);
    frame_y=worklocation_lbl.frame.origin.y;
    lbl1.frame=CGRectMake(30, frame_y+height_of_component+space_between_textfield, width_of_lbl, height_of_component);
    worklocation_lbl1.frame=CGRectMake(30, lbl1.frame.origin.y+height_of_component+space_between_textfield, width_of_lbl, height_of_component);
    rm1.frame=CGRectMake(220,worklocation_lbl1.frame.origin.y, 70, 30);
    number_of_textfields++;
    
    [ratingView  addSubview:rm1];
    [ratingView addSubview:lbl1];
    [ratingView addSubview:worklocation_lbl1];
    CGRect frame1 = [btn frame];
    frame1.origin.y = worklocation_lbl1.frame.origin.y+height_of_component+space_between_textfield;
    frame1.origin.x=30;
    [btn setFrame:frame1];
   view_agreeterms_continue.frame=CGRectMake(0, btn.frame.origin.y+30, 320, 94);
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
        
        [ratingView  addSubview:rm2];
        [ratingView addSubview:lbl2];
        [ratingView addSubview:worklocation_lbl2];
        
        //move down the button
        CGRect frame1 = [btn frame];
        frame1.origin.y = worklocation_lbl2.frame.origin.y+height_of_component+space_between_textfield;
        frame1.origin.x=30;
        [btn setFrame:frame1];
        view_agreeterms_continue.frame=CGRectMake(0, btn.frame.origin.y+30, 320, 94);
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
                [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
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
                    workVC.isFromEditProfile=0;
                    [self.navigationController pushViewController:workVC animated:YES];
                }];
                [request setFailedBlock:^{
                    NSError *error = [request error];
                    [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
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
                workDetailVC.isFromEditProfile_WorkDetail=0;
                workDetailVC.workDetailArray=root[@"OrganizationList"];
                
                [self.navigationController pushViewController:workDetailVC animated:YES];
            }
        }];
        [request startAsynchronous];
    }
}



#pragma mark-pickerview methods
-(void)establishLabelTap:(UIGestureRecognizer *)sender{
    charityPicker.hidden=YES;
    establishPicker.hidden=NO;
    UIToolbar *toolbar=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
    UIBarButtonItem *barButtonDone = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(doneAction:)];
    toolbar.items = [[NSArray alloc] initWithObjects:barButtonDone,nil];
    toolbar.translucent=NO;
    toolbar.barTintColor=RGB(155, 130, 110);
    [subview addSubview:toolbar];
    if(sender.view.tag==1){
        firstlbl.layer.borderColor=[[UIColor grayColor] CGColor];
        worklocation_lbl.layer.borderColor=[[UIColor grayColor] CGColor];
        barButtonDone.tag=1;
        establishPicker.tag=1;
        if(pickerDisplayindex1!=0){
        pickerRow=pickerDisplayindex1;
        }
        else{
            pickerRow=0;
        }
        [UIView animateWithDuration:0.30 delay:0.05 options: UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             // self.view.frame=CGRectMake(0, -30, 320, 200);
                             subview.hidden=NO;
                             subview.frame=CGRectMake(0, 244, 320, subview.frame.size.height);
                             [view_scroll   scrollRectToVisible:CGRectMake(0, 140, view_scroll.frame.size.width, view_scroll.frame.size.height) animated:YES];
                         }
                         completion:^(BOOL finished){
                             if(finished)  {NSLog(@"Finished end !!!!!");
                             }
                         }];
  /*      [self requestForEstablishType:^(BOOL result) {
            if (result) {
        [UIView animateWithDuration:0.30 delay:0.05 options: UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             // self.view.frame=CGRectMake(0, -30, 320, 200);
                             subview.hidden=NO;
                             subview.frame=CGRectMake(0, 244, 320, subview.frame.size.height);
                             [view_scroll   scrollRectToVisible:CGRectMake(0, 140, view_scroll.frame.size.width, view_scroll.frame.size.height) animated:YES];
                         }
                         completion:^(BOOL finished){
                             if(finished)  {NSLog(@"Finished end !!!!!");
                             }
                         }];
            }
        }]; */
         }
    if(sender.view.tag==2){
        lbl1.layer.borderColor=[[UIColor grayColor] CGColor];
        worklocation_lbl1.layer.borderColor=[[UIColor grayColor] CGColor];
        barButtonDone.tag=2;
        establishPicker.tag=2;
        if(pickerDisplayindex2!=0){
            pickerRow=pickerDisplayindex2;
        }
        else{
            pickerRow=0;
        }
        [UIView animateWithDuration:0.30 delay:0.05 options: UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             // self.view.frame=CGRectMake(0, -30, 320, 200);
                             subview.hidden=NO;
                             subview.frame=CGRectMake(0, 244, 320, subview.frame.size.height);
                             
                             [view_scroll scrollRectToVisible:CGRectMake(0, 220, view_scroll.frame.size.width, view_scroll.frame.size.height) animated:YES];
                         }
                         completion:^(BOOL finished){
                             if(finished)  {NSLog(@"Finished end !!!!!");
                             }
                         }];
    /*    [self requestForEstablishType:^(BOOL result) {
            if (result) {
        [UIView animateWithDuration:0.30 delay:0.05 options: UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             // self.view.frame=CGRectMake(0, -30, 320, 200);
                             subview.hidden=NO;
                             subview.frame=CGRectMake(0, 244, 320, subview.frame.size.height);
                             
                             [view_scroll scrollRectToVisible:CGRectMake(0, 220, view_scroll.frame.size.width, view_scroll.frame.size.height) animated:YES];
                         }
                         completion:^(BOOL finished){
                             if(finished)  {NSLog(@"Finished end !!!!!");
                             }
                         }];
            }
        }]; */
    }
    if(sender.view.tag==3){
        lbl2.layer.borderColor=[[UIColor grayColor] CGColor];
        worklocation_lbl2.layer.borderColor=[[UIColor grayColor] CGColor];
        barButtonDone.tag=3;
        establishPicker.tag=3;
        if(pickerDisplayindex3!=0){
            pickerRow=pickerDisplayindex3;
        }
        else{
            pickerRow=0;
        }
        [UIView animateWithDuration:0.30 delay:0.05 options: UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             // self.view.frame=CGRectMake(0, -30, 320, 200);
                             subview.frame=CGRectMake(0, 244, 320, subview.frame.size.height);
                             subview.hidden=NO;
                             [view_scroll scrollRectToVisible:CGRectMake(0, 265, view_scroll.frame.size.width, view_scroll.frame.size.height) animated:YES];
                         }
                         completion:^(BOOL finished){
                             if(finished)  {NSLog(@"Finished end !!!!!");
                             }
                         }];
   /*     [self requestForEstablishType:^(BOOL result) {
            if (result) {
        [UIView animateWithDuration:0.30 delay:0.05 options: UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             // self.view.frame=CGRectMake(0, -30, 320, 200);
                             subview.frame=CGRectMake(0, 244, 320, subview.frame.size.height);
                             subview.hidden=NO;
                             [view_scroll scrollRectToVisible:CGRectMake(0, 265, view_scroll.frame.size.width, view_scroll.frame.size.height) animated:YES];
                         }
                         completion:^(BOOL finished){
                             if(finished)  {NSLog(@"Finished end !!!!!");
                             }
                         }];
    }
        }]; */
    }
}

-(void)requestForEstablishType:(void (^)(BOOL result)) return_block{
            
            ASIFormDataRequest *_request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:URLEstablishmentList]];
            __unsafe_unretained ASIFormDataRequest *request = _request;
            [request setDelegate:self];
            
            
            
            [request setCompletionBlock:^{
                NSDictionary *root = [NSJSONSerialization JSONObjectWithData:request.responseData options:0 error:nil];
                NSLog(@"establishtype root %@",root);
                establishTypeDataArray=root[@"data"];
              //  [establishPicker reloadAllComponents];
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
         
-(void)labelTap{
    if([searchedName count]<=0){
        CharityDetailViewController *CharityVC=[[CharityDetailViewController alloc]init];
        CharityVC.delegate=self;
        [self.navigationController pushViewController:CharityVC animated:YES];
        return;
    }
    else{
        if(labeltapped==1){
            return;
        }
    NSLog(@"tapped");
    subview.hidden=NO;
    //CGRect frame;
        UIToolbar *toolbar=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
        UIBarButtonItem *barButtonDone = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(doneAction:)];
        UIBarButtonItem *barButtonOther = [[UIBarButtonItem alloc] initWithTitle:@"Other" style:UIBarButtonItemStyleBordered target:self action:@selector(otherAction:)];
        UIBarButtonItem *flexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        flexible.width=200;
        barButtonDone.tag=4;
        toolbar.items = [[NSArray alloc] initWithObjects:barButtonDone,flexible,barButtonOther,nil];
        toolbar.translucent=NO;
        toolbar.barTintColor=RGB(155, 130, 110);
        [subview addSubview:toolbar];
    charityPicker.hidden=NO;
    establishPicker.hidden=YES;
      [UIView animateWithDuration:0.25 delay:0.0 options: UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             // self.view.frame=CGRectMake(0, -30, 320, 200);
                             subview.frame=CGRectMake(0, 244, 320, subview.frame.size.height);
                             
                         }
                         completion:^(BOOL finished){
                             if(finished)  {NSLog(@"Finished end !!!!!");
                             }
                         }];
    labeltapped=1;
    }
}
-(IBAction)doneAction:(id)sender{

    subview.frame=CGRectMake(0, 640, 320, 200);
    subview.hidden=YES;
    if([sender tag]==1){
        [UIView animateWithDuration:0.30 delay:0.05 options: UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             // self.view.frame=CGRectMake(0, -30, 320, 200);
                            [view_scroll scrollRectToVisible:CGRectMake(0, 0, view_scroll.frame.size.width, view_scroll.frame.size.height) animated:YES];
                         }
                         completion:^(BOOL finished){
                             if(finished)  {NSLog(@"Finished end !!!!!");
                             }
                         }];
    }
    if([sender tag]==2){
        [UIView animateWithDuration:0.30 delay:0.05 options: UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             // self.view.frame=CGRectMake(0, -30, 320, 200);
                             [view_scroll scrollRectToVisible:CGRectMake(0, 80, view_scroll.frame.size.width, view_scroll.frame.size.height) animated:YES];
                         }
                         completion:^(BOOL finished){
                             if(finished)  {NSLog(@"Finished end !!!!!");
                             }
                         }];
    }
    if([sender tag]==3){
        [UIView animateWithDuration:0.30 delay:0.05 options: UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             // self.view.frame=CGRectMake(0, -30, 320, 200);
                             [view_scroll scrollRectToVisible:CGRectMake(0, 140, view_scroll.frame.size.width, view_scroll.frame.size.height) animated:YES];
                         }
                         completion:^(BOOL finished){
                             if(finished)  {NSLog(@"Finished end !!!!!");
                             }
                         }];
    }
    if([sender tag]==4){
        labeltapped=0;
    }
}
-(IBAction)otherAction:(id)sender{
    labeltapped=0;
    CharityDetailViewController *CharityVC=[[CharityDetailViewController alloc]init];
    CharityVC.delegate=self;
    [self.navigationController pushViewController:CharityVC animated:YES];
}

- (void )imageTapped:(UITapGestureRecognizer *) gestureRecognizer
{
    NSLog(@"image tapped");
    UIImagePickerController *imgPicker=[[UIImagePickerController alloc]init];
    imgPicker.delegate=self;
    [imgPicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [self presentViewController:imgPicker animated:YES completion:nil];
}

- (IBAction)showImagePicker:(id)sender {
    UIImagePickerController *imgPicker=[[UIImagePickerController alloc]init];
    imgPicker.delegate=self;
    [imgPicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [self presentViewController:imgPicker animated:YES completion:nil];
}




-(IBAction)btnHelpAction:(id)sender{
    [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                    type:AJNotificationTypeRed
                                   title:@"Coming Soon"
                         linedBackground:AJLinedBackgroundTypeDisabled
                               hideAfter:GZAJNotificationDelay];
    return ;
    HelpViewController *HVC=[[HelpViewController alloc]init];
    UINavigationController *helpNavController=[[UINavigationController alloc]initWithRootViewController:HVC];
    [self presentViewController:helpNavController animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    NSLog(@"%@",info);
    uploadImgButton.hidden=YES;
    saveImageButton.hidden=NO;
    proImage.image=[info valueForKey:@"UIImagePickerControllerOriginalImage"];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
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

-(void) buttonWasActivated:(int) buttonTag
{
    NSLog(@"from svc");
    if (buttonTag == 1){
        //[[NSUserDefaults standardUserDefaults] setValue:@"cash" forKey:@"paymentSelection"];
        lbl_charityname.userInteractionEnabled=NO;
        txt_gratuity.userInteractionEnabled=NO;
        charityView.hidden=YES;
        charityBoxView.hidden=YES;
        ratingView.frame=CGRectMake(0,212, 320, ratingView.frame.size.height);
        lbl_charityname.text=@"Select Charity";
        txt_gratuity.text=@"";
        subview.frame=CGRectMake(0, 640, 320, subview.frame.size.height);
        
    }
    else if(buttonTag==2)
    {
    //[[NSUserDefaults standardUserDefaults] setValue:@"donatetocharity" forKey:@"paymentSelection"];
       // charityPicker.hidden=NO;
        lbl_charityname.userInteractionEnabled=YES;
        txt_gratuity.userInteractionEnabled=NO;
        charityView.hidden=NO;
        charityBoxView.hidden=YES;
        ratingView.frame=CGRectMake(0,237, 320, ratingView.frame.size.height);
    }
    else if(buttonTag==3){
      //  [[NSUserDefaults standardUserDefaults] setValue:@"both" forKey:@"paymentSelection"];
        lbl_charityname.userInteractionEnabled=YES;
        txt_gratuity.userInteractionEnabled=YES;
        charityView.hidden=NO;
        charityBoxView.hidden=NO;
        ratingView.frame=CGRectMake(0,277, 320,ratingView.frame.size.height);
    }
    NSLog(@"rateframe:%f",ratingView.frame.origin.y);
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    usernameLabel.text=[NSString stringWithFormat:@"%@ %@",[[NSUserDefaults standardUserDefaults] valueForKey:@"first_name"],[[NSUserDefaults standardUserDefaults] valueForKey:@"last_name"]];
    [self requestForCharityList];
    WorkVC.delegate=self;
    subview.frame=CGRectMake(0, 640, 320, subview.frame.size.height);
}

- (IBAction)btnAgreeTermAction:(id)sender {
    if (![btnAgreeTerm isSelected]) {
        [btnAgreeTerm setSelected:YES];
    }else{
        [btnAgreeTerm setSelected:NO];
    }

}

- (IBAction)btnShareProfileAction:(id)sender {
    if(![btnShareProfile isSelected]){
        [btnShareProfile setSelected:YES];
    }
    else{
        [btnShareProfile setSelected:NO];
    }
}

-(void)charityName:(NSString *)name mail:(NSString *)Email{
    charityName=name;
    charityEmail=Email;
    NSLog(@"delegate method");
    lbl_charityname.text=name;
}

- (IBAction)btnContinueAction:(id)sender {
    NSMutableArray *objects=[[NSMutableArray alloc]init];
    NSMutableArray *keys=[[NSMutableArray alloc]init];
   
    NSLog(@" %@ %@",charityName,charityEmail);
    if(gratuityGroup.genderButtonIndex==1 || gratuityGroup.genderButtonIndex==0){
        gratuitySelection=@"cash";
    }
    else if(gratuityGroup.genderButtonIndex==2){
        gratuitySelection=@"donate to charity";
    }
    else if(gratuityGroup.genderButtonIndex==3){
        gratuitySelection=@"both";
    }
    if(paymentGroup.genderButtonIndex==1){
        receivePayment=@"bank_account";
    }
    else if(paymentGroup.genderButtonIndex==2 || paymentGroup.genderButtonIndex==0){
        receivePayment=@"paypal";
    }
    else if(paymentGroup.genderButtonIndex==3){
        receivePayment=@"Debit_card";
    }
    if(lbl_charityname.isUserInteractionEnabled && (charityId ==NULL && (charityEmail==NULL && charityName==NULL))){
        [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                        type:AJNotificationTypeRed
                                       title:@"Select Charity"
                             linedBackground:AJLinedBackgroundTypeDisabled
                                   hideAfter:GZAJNotificationDelay];
        return;
    }
    if(txt_gratuity.isUserInteractionEnabled && [[txt_gratuity.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]<=0){
        [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                        type:AJNotificationTypeRed
                                       title:@"Enter Percentage to donate"
                             linedBackground:AJLinedBackgroundTypeDisabled
                                   hideAfter:GZAJNotificationDelay];
        return;
    }
    
    if([gratuitySelection isEqualToString:@"donate to charity"]){
        [objects addObject:@"100"];
        [keys addObject:@"gratuityPercentage"];
        NSLog(@"amount added");
    }
    else if([gratuitySelection isEqualToString:@"both"]){
        [objects addObject:txt_gratuity.text];
        [keys addObject:@"gratuityPercentage"];
        NSLog(@"amount added both");
    }
    
    if([charityName isEqualToString:lbl_charityname.text] && ![gratuitySelection isEqualToString:@"cash"]){
        [objects addObject:charityName];
        [objects addObject:charityEmail];
        [keys addObject:@"charityName"];
        [keys addObject:@"charityEmail"];
        NSLog(@"name added");
    }
    else if(![gratuitySelection isEqualToString:@"cash"] && ![charityName isEqualToString:lbl_charityname.text]){
        [objects addObject:charityId];
        [keys addObject:@"charityId"];
    }
    [objects addObject:receivePayment];
    [keys addObject:@"receivePayment"];
    [objects addObject:[[NSUserDefaults standardUserDefaults] valueForKey:@"userid"]];
    [keys addObject:@"userId"];
    [objects addObject:(btnShareProfile.isSelected?@"true":@"false")];
    [keys addObject:@"isShareRate"];
    
     //temporary adding
        [objects addObject:[[[NSUserDefaults standardUserDefaults] valueForKey:@"isServiceProvider"] boolValue]?@"true":@"false"];
        [keys addObject:@"isServiceProvider"];
        [objects addObject:[[[NSUserDefaults standardUserDefaults] valueForKey:@"isSender"] boolValue]?@"true":@"false"];
        [keys addObject:@"isSender"];
    
    
    if(!btnAgreeTerm.isSelected){
        [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                        type:AJNotificationTypeRed
                                       title:@"You must agree to our Terms and Conditions"
                             linedBackground:AJLinedBackgroundTypeDisabled
                                   hideAfter:GZAJNotificationDelay];
        return;
    }
    if(number_of_textfields==3 && (establishmentId1 ==NULL || [worklocation_lbl.text isEqualToString:organizationString] || establishmentId2 ==NULL || [worklocation_lbl1.text isEqualToString:organizationString] || establishmentId3 ==NULL || [worklocation_lbl2.text isEqualToString:organizationString])){
        
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
        if(establishmentId1==NULL){
            firstlbl.layer.borderColor=[[UIColor redColor] CGColor];
            worklocation_lbl.layer.borderColor=[[UIColor redColor] CGColor];
        }
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
    }else{
    
    NSDictionary *dict1,*dict2,*dict3;
       
    NSMutableDictionary *serviceProviderProfileDict = [NSMutableDictionary dictionaryWithObjects:objects forKeys:keys];
        NSMutableArray *workInfoArray=[[NSMutableArray alloc]init];
    //  NSMutableDictionary *final=[[NSMutableDictionary alloc]init];
    if(establishmentId1!=NULL &&  workLocationId1!=NULL){
        dict1=[[NSDictionary alloc]initWithObjectsAndKeys:establishmentId1,@"establishmentId",workLocationId1,@"organizationId", nil];
        //[serviceProviderProfileDict setValue:dict1 forKey:@"workLocation1"];
        [workInfoArray addObject:dict1];
    }
    if(establishmentId2!=NULL && workLocationId2!=NULL){
        dict2=[[NSDictionary alloc]initWithObjectsAndKeys:establishmentId2,@"establishmentId",workLocationId2,@"organizationId", nil];
       //[serviceProviderProfileDict setValue:dict2 forKey:@"workLocation2"];
        [workInfoArray addObject:dict2];
        
    }
    if(establishmentId3!=NULL && workLocationId3!=NULL){
        dict3=[[NSDictionary alloc]initWithObjectsAndKeys:establishmentId3,@"establishmentId",workLocationId3,@"organizationId", nil];
       //[serviceProviderProfileDict setValue:dict3 forKey:@"workLocation3"];
        [workInfoArray addObject:dict3];
    }
        [serviceProviderProfileDict setObject:workInfoArray forKey:@"workLocation"];
   
    
    NSLog(@"----1> Dict: %@",serviceProviderProfileDict);
        NSError *error;
        NSData *completeProfileData=[NSJSONSerialization dataWithJSONObject:serviceProviderProfileDict options:NSJSONWritingPrettyPrinted error:&error];
        ASIFormDataRequest *_request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:URLServiceProviderInfo]];
        __unsafe_unretained ASIFormDataRequest *request = _request;
        [request setDelegate:self];
        [request addRequestHeader:ContentType value:ContentTypeValue];
    [request appendPostData:completeProfileData];
    [request setCompletionBlock:^{
    NSDictionary *root=[NSJSONSerialization JSONObjectWithData:[request responseData] options:0 error:nil];
        NSLog(@"complete profile root%@",root);
        if([root[@"isError"] boolValue]==1){
            [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                            type:AJNotificationTypeRed
                                           title:root[@"message"]
                                 linedBackground:AJLinedBackgroundTypeDisabled
                                       hideAfter:GZAJNotificationDelay];
            return ;
        }
        if([root count]==0){
            [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                            type:AJNotificationTypeRed
                                           title:@"Server Error"
                                 linedBackground:AJLinedBackgroundTypeDisabled
                                       hideAfter:GZAJNotificationDelay];
            return ;
        }
        [AJNotificationView showNoticeInView:self.view
                                        type:AJNotificationTypeBlue
                                       title:root[@"message"]
                             linedBackground:AJLinedBackgroundTypeDisabled
                                   hideAfter:GZAJNotificationDelay];
     //   ChoosenPaymentMethodViewController *CPVC=[[ChoosenPaymentMethodViewController alloc]initWithNibName:@"ChoosenPaymentMethodViewController" bundle:nil];
      // [self.navigationController pushViewController:CPVC animated:YES];
        UINavigationController *navigationController;
        GratuityViewController *gratuityVC = [[GratuityViewController alloc] initWithNibName:@"GratuityViewController" bundle:nil];
        navigationController = [[UINavigationController alloc] initWithRootViewController:gratuityVC ];
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"isServiceProviderProfileComplete"];
        MenuViewController *menuVC = [[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil];
        [[self sideMenuController ] enable];
        [[self sideMenuController ]  changeMenuViewController:menuVC closeMenu:YES];
        [[self sideMenuController ]changeContentViewController:navigationController closeMenu:YES];
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
    }

- (IBAction)cancelButtonAction:(id)sender {
    lbl_charityname.text=@"Select Charity";
    txt_gratuity.text=@"";
    charityEmail=NULL;
    charityId=NULL;
    charityName=NULL;
}

//Method to resize image before sending it to server
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

        saveImageButton.hidden=YES;
       NSDictionary *root=[NSJSONSerialization JSONObjectWithData:[request responseData] options:0 error:nil];
        NSLog(@"root===>%@",root);
        NSData *d=[Base64 decode:[root valueForKey:@"image"]];
        NSLog(@"newdata@@@@%@",d);
        
         [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@.png",[[NSUserDefaults standardUserDefaults] valueForKey:@"userid"]] forKey:@"profile-picture"];

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

- (void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component {
    // Handle the selection
    NSLog(@"%d",row);
    if(pickerView==charityPicker){
        lbl_charityname.text=[searchedName objectAtIndex:row];
        NSDictionary *dictionary=[dataArray objectAtIndex:row];
        charityId=[dictionary[@"charityId"] stringValue];
        NSLog(@"id is%@",charityId);
        charityName=@"";
        charityEmail=@"";
        btn_cancel.hidden=NO;
    }
    if(pickerView==establishPicker){
        if(establishPicker.tag==1){
            establsihTypeDataDictionary=[establishTypeDataArray objectAtIndex:row];
            firstlbl.text=establsihTypeDataDictionary[@"establishmentName"];
            establishmentId1=establsihTypeDataDictionary[@"establishmentId"];
            worklocation_lbl.text=organizationString;
            workLocationId1=NULL;
            pickerDisplayindex1=row;
        }
        if(establishPicker.tag==2){
            establsihTypeDataDictionary=[establishTypeDataArray objectAtIndex:row];
            lbl1.text=establsihTypeDataDictionary[@"establishmentName"];
            establishmentId2=establsihTypeDataDictionary[@"establishmentId"];
            worklocation_lbl1.text=organizationString;
            workLocationId2=NULL;
             pickerDisplayindex2=row;
        }
        
        if(establishPicker.tag==3){
            establsihTypeDataDictionary=[establishTypeDataArray objectAtIndex:row];
            lbl2.text=establsihTypeDataDictionary[@"establishmentName"];
            establishmentId3=establsihTypeDataDictionary[@"establishmentId"];
            worklocation_lbl2.text=organizationString;
            workLocationId3=NULL;
            pickerDisplayindex3=row;
        }
        
    }
}

// tell the picker how many rows are available for a given component
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if(pickerView==charityPicker){
    return [searchedName count];
    }
    if(pickerView==establishPicker){
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
    if(pickerView==charityPicker){
    tView.text=[searchedName objectAtIndex:row];
    }
    if(pickerView==establishPicker){
        if(pickerRow!=0){
        establsihTypeDataDictionary=[establishTypeDataArray objectAtIndex:row];
        tView.text=establsihTypeDataDictionary[@"establishmentName"];
        }
    else{
        NSLog(@"-->");
        establsihTypeDataDictionary=[establishTypeDataArray objectAtIndex:row];
        tView.text=establsihTypeDataDictionary[@"establishmentName"];
       
    }
    
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
//        if([[root valueForKey:@"charityList"] count]<=0){
//            CharityDetailViewController *charityVC=[[CharityDetailViewController alloc]init];
//            [self.navigationController pushViewController:charityVC animated:YES];
//        }
//        else{
//            ExsitingCharityViewController *charityVC=[[ExsitingCharityViewController alloc]init];
//            charityVC.dataDict=[[NSMutableDictionary alloc]initWithDictionary:root];
//            [self.navigationController pushViewController:charityVC animated:YES];
//        }
        //dataDict=[[NSMutableDictionary alloc]initWithDictionary:root];
        
        
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


-(IBAction)textFieldDidChange:(id)sender{
    if([txt_gratuity.text integerValue]>100){
        NSString *text=txt_gratuity.text;
        NSString *newString = [text substringToIndex:[text length]-1];
        txt_gratuity.text=newString;
        return;
    }
    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [txt_gratuity resignFirstResponder];
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSCharacterSet *nonNumberSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    return ([string stringByTrimmingCharactersInSet:nonNumberSet].length > 0) || [string isEqualToString:@""];
}



-(void)establishSave:(NSString *)flag{
    isWorkLocationEntered=flag;
}

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
