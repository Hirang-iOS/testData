//
//  EstablishmentViewController.m
//  GratZeez
//
//  Created by cloudZon Infosoft on 05/12/13.
//  Copyright (c) 2013 cloudZon Infosoft. All rights reserved.
//

#import "EstablishmentViewController.h"

@interface EstablishmentViewController ()

@end

@implementation EstablishmentViewController
@synthesize myPickerView,pickerDataArray,myPickerView1,myPickerView2,firstlbl,worklocation_lbl,lbl1,worklocation_lbl1,lbl2,worklocation_lbl2,exsitingWorkArray,isFromEditProfile_EVC;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    //self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"background5"]];
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

-(void)labelTap{
    NSLog(@"label tapped===>");
    myPickerView1.hidden=YES;
    myPickerView2.hidden=YES;
    myPickerView.hidden=NO;
    UIBarButtonItem *barButtonDone = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                      style:UIBarButtonItemStyleBordered target:self action:@selector(doneAction:)];
    toolBar.items = [[NSArray alloc] initWithObjects:barButtonDone,nil];
    barButtonDone.tintColor=[UIColor blackColor];
    barButtonDone.tag=1;
    if(isFromEditProfile_EVC==TRUE){
        [UIView animateWithDuration:0.25 delay:0.0 options: UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             // self.view.frame=CGRectMake(0, -30, 320, 200);
                             SubView.frame=CGRectMake(0, 300, 320, 180);
                             CGRect f1;
                             f1=self.view.frame;
                             f1.origin.y=f1.origin.y-100;
                             // self.view.frame=f1;
                             // v1.backgroundColor=[UIColor blackColor];
                             [self.view bringSubviewToFront:SubView];
                             //[self.view bringSubviewToFront:myToolBar];
                         }
                         completion:^(BOOL finished){
                             if(finished)  {NSLog(@"Finished end !!!!!");}
                         }];
    }
    else{
    [UIView animateWithDuration:0.25 delay:0.0 options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         // self.view.frame=CGRectMake(0, -30, 320, 200);
                         SubView.frame=CGRectMake(0, 360, 320, 180);
                         CGRect f1;
                         f1=self.view.frame;
                         f1.origin.y=f1.origin.y-100;
                           [self.view bringSubviewToFront:SubView];
                        // self.view.frame=f1;
                         // v1.backgroundColor=[UIColor blackColor];
                     }
                     completion:^(BOOL finished){
                         if(finished)  {NSLog(@"Finished end !!!!!");}
                     }];
    }
}
-(void)labelTap1{
    NSLog(@"label tapped");
    myPickerView.hidden=YES;
    myPickerView2.hidden=YES;
    myPickerView1.hidden=NO;
    UIBarButtonItem *barButtonDone = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                      style:UIBarButtonItemStyleBordered target:self action:@selector(doneAction:)];
    toolBar.items = [[NSArray alloc] initWithObjects:barButtonDone,nil];
    barButtonDone.tintColor=[UIColor blackColor];
    barButtonDone.tag=2;
    if(isFromEditProfile_EVC==TRUE){
        [UIView animateWithDuration:0.25 delay:0.0 options: UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             // self.view.frame=CGRectMake(0, -30, 320, 200);
                             SubView.frame=CGRectMake(0, 300, 320, 180);
                             CGRect f1;
                             f1=self.view.frame;
                             f1.origin.y=f1.origin.y-100;
                             [self.view bringSubviewToFront:SubView];
                                                           // self.view.frame=f1;
                             // v1.backgroundColor=[UIColor blackColor];
                         }
                         completion:^(BOOL finished){
                             if(finished)  {NSLog(@"Finished end !!!!!");}
                         }];
    }
    else{
        [UIView animateWithDuration:0.25 delay:0.0 options: UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             // self.view.frame=CGRectMake(0, -30, 320, 200);
                             SubView.frame=CGRectMake(0, 360, 320, 180);
                             CGRect f1;
                             f1=self.view.frame;
                             f1.origin.y=f1.origin.y-100;
                             [self.view bringSubviewToFront:SubView];
                                                        // self.view.frame=f1;
                             // v1.backgroundColor=[UIColor blackColor];
                         }
                         completion:^(BOOL finished){
                             if(finished)  {NSLog(@"Finished end !!!!!");}
                         }];
    }
}
-(void)labelTap2{
    myPickerView.hidden=YES;
    myPickerView2.hidden=NO;
    myPickerView1.hidden=YES;
    UIBarButtonItem *barButtonDone = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                      style:UIBarButtonItemStyleBordered target:self action:@selector(doneAction:)];
    toolBar.items = [[NSArray alloc] initWithObjects:barButtonDone,nil];
    barButtonDone.tintColor=[UIColor blackColor];
    barButtonDone.tag=3;
    if(isFromEditProfile_EVC==TRUE){
        [UIView animateWithDuration:0.25 delay:0.0 options: UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             // self.view.frame=CGRectMake(0, -30, 320, 200);
                             SubView.frame=CGRectMake(0, 300, 320, 180);
                             CGRect f1;
                             f1=self.view.frame;
                             f1.origin.y=f1.origin.y-100;
                             [self.view bringSubviewToFront:SubView];
                                                        // self.view.frame=f1;
                             // v1.backgroundColor=[UIColor blackColor];
                         }
                         completion:^(BOOL finished){
                             if(finished)  {NSLog(@"Finished end !!!!!");}
                         }];
    }
    else{
        [UIView animateWithDuration:0.25 delay:0.0 options: UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             // self.view.frame=CGRectMake(0, -30, 320, 200);
                             SubView.frame=CGRectMake(0, 360, 320, 180);
                             CGRect f1;
                             f1=self.view.frame;
                             f1.origin.y=f1.origin.y-100;
                             [self.view bringSubviewToFront:SubView];
                                                           // self.view.frame=f1;
                             // v1.backgroundColor=[UIColor blackColor];
                         }
                         completion:^(BOOL finished){
                             if(finished)  {NSLog(@"Finished end !!!!!");}
                         }];
    }
}
-(void)WorkLocation_lbl_tap:(UIGestureRecognizer *)sender{
    if(sender.view.tag==2 && establishmentId1==NULL){
        [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                        type:AJNotificationTypeRed
                                       title:@"First Select EstablishmentType"
                             linedBackground:AJLinedBackgroundTypeDisabled
                                   hideAfter:GZAJNotificationDelay];
        return;
    }
    else if(sender.view.tag==4 && establishmentId2==NULL){
        [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                        type:AJNotificationTypeRed
                                       title:@"First Select EstablishmentType"
                             linedBackground:AJLinedBackgroundTypeDisabled
                                   hideAfter:GZAJNotificationDelay];
        return;
    }
    else if(sender.view.tag==6 && establishmentId3==NULL){
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
        if(sender.view.tag==2){
            organizationDictionary=[[NSDictionary alloc]initWithObjectsAndKeys:establishmentId1,@"e_id", nil];
        }
        else if(sender.view.tag==4){
            organizationDictionary=[[NSDictionary alloc]initWithObjectsAndKeys:establishmentId2,@"e_id", nil];
        }
        else if(sender.view.tag==6){
            organizationDictionary=[[NSDictionary alloc]initWithObjectsAndKeys:establishmentId3,@"e_id", nil];
        }
    [request appendPostData:[[NSString stringWithFormat:@"%@",organizationDictionary] dataUsingEncoding:NSUTF8StringEncoding]];
    NSLog(@"dict:%@",organizationDictionary);
    [request setCompletionBlock:^{
        NSDictionary *root = [NSJSONSerialization JSONObjectWithData:request.responseData options:0 error:nil];
        NSLog(@"Worklocatio root %@",root);
        if([root[@"isError"]boolValue]==1){
            workVC=[[WorkLocationViewController alloc]initWithNibName:@"WorkLocationViewController" bundle:nil];
            if(sender.view.tag==2){
               // NSLog(@"====>",establishmentId1);
                workVC.establishId=establishmentId1;
            }
            else if(sender.view.tag==4){
                workVC.establishId=establishmentId2;
            }
            else if(sender.view.tag==6){
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
                workVC.isFromEditProfile=isFromEditProfile_EVC;
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
             workDetailVc=[[WorkLocationDetailsViewController alloc]initWithNibName:@"WorkLocationDetailsViewController" bundle:nil];
            if(sender.view.tag==2){
                // NSLog(@"====>",establishmentId1);
                workDetailVc.establishId=establishmentId1;
            }
            else if(sender.view.tag==4){
                workDetailVc.establishId=establishmentId2;
            }
            else if(sender.view.tag==6){
                workDetailVc.establishId=establishmentId3;
            }
        workDetailVc.delegate=self;
        workDetailVc.lblTag=sender.view.tag;
        workDetailVc.isFromEditProfile_WorkDetail=isFromEditProfile_EVC;
        workDetailVc.workDetailArray=root[@"OrganizationList"];
            
    [self.navigationController pushViewController:workDetailVc animated:YES];
        }
    }];
       // NSMutableArray *ary1=[[NSMutableArray alloc]init];
        //[ary1 addObject:[workDetailVc.workDetailArray objectAtIndex:0]];
        //NSLog(@"ary%@",ary1);
   
  /*
    ASIFormDataRequest *_request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:URLGetState]];
    __unsafe_unretained ASIFormDataRequest *request = _request;
    [request setDelegate:self];
   // NSDictionary *locationListDictionary=[[NSDictionary alloc]initWithObjectsAndKeys:@"YES",@"request_for_organizationList", nil];
    //[request appendPostData:[[NSString stringWithFormat:@"%@",locationListDictionary] dataUsingEncoding:NSUTF8StringEncoding]];
    //NSLog(@"dict:%@",locationListDictionary);
    [request setCompletionBlock:^{
        NSDictionary *root = [NSJSONSerialization JSONObjectWithData:request.responseData options:0 error:nil];
        NSLog(@"Worklocatio root %@",root);
        WorkLocationViewController *wvc=[[WorkLocationViewController alloc]init];
        wvc.stateArray=root[@"stateList"];
        [self.navigationController pushViewController:wvc animated:YES];
    }];
    [request setFailedBlock:^{
        NSError *error = [request error];
        [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                        type:AJNotificationTypeRed
                                       title:error.localizedDescription
                             linedBackground:AJLinedBackgroundTypeDisabled
                                   hideAfter:GZAJNotificationDelay];
    }]; */
    [request startAsynchronous];
    }
 //   WorkLocationViewController *wvc=[[WorkLocationViewController alloc]init];
    
    
   // [self.navigationController pushViewController:wvc animated:YES];
}

-(void)organizationInfo:(NSString *) organization_id name:(NSString *)name tag:(int )tag{
    
    if(tag==2){
        worklocation_lbl.text=name;
        workLocationId1=organization_id;
    }
    else if(tag==4){
        worklocation_lbl1.text=name;
        workLocationId2=organization_id;
    }
    else if (tag==6) {
        worklocation_lbl2.text=name;
        workLocationId3=organization_id;
    }
    
}

-(IBAction)doneAction:(id)sender{
    myPickerView2.hidden=NO;
    myPickerView1.hidden=NO;
    myPickerView.hidden=NO;
    [UIView animateWithDuration:0.25 delay:0.0 options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         //  self.view.frame=CGRectMake(0, 0, 320, 200);
                         SubView.frame=CGRectMake(0, 640, 320, 180);
                         CGRect f1;
                         f1=self.view.frame;
                         f1.origin.y=f1.origin.y+100;
                         
                       //  self.view.frame=f1;
                     }
                     completion:^(BOOL finished){
                         if(finished)  {NSLog(@"Finished end !!!!!");}
                     }];
    
}

- (void)viewDidLoad
{
    
    number_of_textfields = 1;
    space_between_textfield = 10.0;
    frame_y=100;
    height_of_component=30;
    width_of_lbl=180;
    
    NSLog(@"called");
   // lblEstablishment.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"text_field"]];
   // lblEstablishment.opaque=YES;
    self.title=@"Work Information";
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];
    SubView=[[UIView alloc]initWithFrame:CGRectMake(0, 640, 320, 180)];
    myPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 40, 320, 185)];
    myPickerView.delegate = self;
    myPickerView.backgroundColor=RGB(210, 200, 191);
    myPickerView.showsSelectionIndicator = YES;
    [SubView addSubview:myPickerView];
    
    myPickerView1 = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 40, 320, 185)];
    myPickerView1.delegate = self;
    myPickerView1.showsSelectionIndicator = YES;
    myPickerView1.backgroundColor=RGB(210, 200, 191);
    [SubView addSubview:myPickerView1];
    
    myPickerView2 = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 40, 320, 185)];
    myPickerView2.delegate = self;
    myPickerView2.showsSelectionIndicator = YES;
    myPickerView2.backgroundColor=RGB(210, 200, 191);
    [SubView addSubview:myPickerView2];
    
  //  [self.view addSubview:myPickerView];
    toolBar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,20,320,40)];
   // [toolBar setBarStyle:UIBarStyleBlackOpaque];
    toolBar.translucent=NO;
   toolBar.barTintColor=RGB(155, 130, 110);
    [SubView addSubview:toolBar];

    lblEstablishment.userInteractionEnabled = YES;
       // ary=[[NSMutableArray alloc]initWithObjects:@"hello",@"hi",@"good morning",@"good night",@"good afternoon", nil];
    [self.view addSubview:SubView];

    //Adding label and textfiled
    
    
    
    lbl1 = [[UILabel alloc]init];
    lbl1.userInteractionEnabled=YES;
    lbl1.font=[UIFont fontWithName:GZFont size:16.0f];
    lbl1.text=@"Select EstablishmentType";
    lbl1.layer.borderWidth=1.0;
    lbl1.layer.borderColor=[[UIColor grayColor]CGColor];
    [lbl1.layer setCornerRadius:3];
    [lbl1.layer setMasksToBounds:YES];
    lbl1.textAlignment = NSTextAlignmentCenter;
    lbl1.backgroundColor=RGB(233, 228, 223);
    lbl1.tag=3;
    
    lbl2 = [[UILabel alloc]init];
    lbl2.userInteractionEnabled=YES;
    lbl2.font=[UIFont fontWithName:GZFont size:16.0f];
    lbl2.text=@"Select EstablishmentType";
    lbl2.layer.borderWidth=1.0;
    lbl2.layer.borderColor=[[UIColor grayColor]CGColor];
    [lbl2.layer setCornerRadius:3];
    [lbl2.layer setMasksToBounds:YES];
    lbl2.textAlignment = NSTextAlignmentCenter;
    lbl2.backgroundColor=RGB(233, 228, 223);
    lbl2.tag=5;
    
    firstlbl=[[UILabel alloc]init];
    firstlbl.frame=CGRectMake(30,frame_y,width_of_lbl,height_of_component);
    firstlbl.text=@"Select EstablishmentType";
    firstlbl.userInteractionEnabled=YES;
    firstlbl.layer.borderWidth=1.0;
    firstlbl.layer.borderColor=[[UIColor grayColor]CGColor];
    [firstlbl.layer setCornerRadius:3];
    [firstlbl.layer setMasksToBounds:YES];
    firstlbl.textAlignment = NSTextAlignmentCenter;
    firstlbl.tag=1;
    firstlbl.backgroundColor=RGB(233, 228, 223);
    firstlbl.font=[UIFont fontWithName:GZFont size:16.0f];
    
    worklocation_lbl1=[[UILabel alloc]init];
    worklocation_lbl1.text=@"Select Establishment";
    worklocation_lbl1.layer.borderWidth=1.0;
    worklocation_lbl1.layer.borderColor=[[UIColor grayColor]CGColor];
    [worklocation_lbl1.layer setCornerRadius:3];
    [worklocation_lbl1.layer setMasksToBounds:YES];
    worklocation_lbl1.textAlignment = NSTextAlignmentCenter;
    worklocation_lbl1.tag=4;
    worklocation_lbl1.backgroundColor=RGB(233, 228, 223);
    worklocation_lbl1.font=[UIFont fontWithName:GZFont size:16.0f];
    worklocation_lbl1.userInteractionEnabled=YES;
    
    worklocation_lbl2=[[UILabel alloc]init];
    worklocation_lbl2.text=@"Select Establishment";
    worklocation_lbl2.layer.borderWidth=1.0;
    worklocation_lbl2.layer.borderColor=[[UIColor grayColor]CGColor];
    [worklocation_lbl2.layer setCornerRadius:3];
    [worklocation_lbl2.layer setMasksToBounds:YES];
    worklocation_lbl2.textAlignment = NSTextAlignmentCenter;
    worklocation_lbl2.tag=6;
    worklocation_lbl2.backgroundColor=RGB(233, 228, 223);
    worklocation_lbl2.userInteractionEnabled=YES;
    worklocation_lbl2.font=[UIFont fontWithName:GZFont size:16.0f];
    
    worklocation_lbl=[[UILabel alloc]init];
    worklocation_lbl.font=[UIFont fontWithName:GZFont size:16.0f];
    worklocation_lbl.frame=CGRectMake(30, firstlbl.frame.origin.y+height_of_component+space_between_textfield, width_of_lbl, height_of_component);
    worklocation_lbl.text=@"Select Establishment";
    worklocation_lbl.layer.borderColor=[[UIColor grayColor] CGColor];
    worklocation_lbl.layer.borderWidth=1.0;
    [worklocation_lbl.layer setCornerRadius:3];
    [worklocation_lbl.layer setMasksToBounds:YES];
    worklocation_lbl.backgroundColor=RGB(233, 228, 223);
    worklocation_lbl.textAlignment = NSTextAlignmentCenter;
    worklocation_lbl.userInteractionEnabled=YES;
    worklocation_lbl.tag=2;
    
   
    
    rm1=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [rm1 addTarget:self action:@selector(removetxt:) forControlEvents:UIControlEventTouchUpInside];
    [rm1 setTitle:@"remove" forState:UIControlStateNormal];
    [rm1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    rm1.tag=1;
    

   // txt2=[[UITextField alloc]init];
    rm2=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [rm2 addTarget:self action:@selector(removetxt:) forControlEvents:UIControlEventTouchUpInside];
    [rm2 setTitle:@"remove" forState:UIControlStateNormal];
    [rm2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    rm2.tag=2;
    
    
   
   
    btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"plus"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(addtxtfld:) forControlEvents:UIControlEventTouchUpInside];
    btn.frame=CGRectMake(30,worklocation_lbl.frame.origin.y+height_of_component+space_between_textfield, 50, height_of_component);
   
    frame_y=worklocation_lbl.frame.origin.y;
    
    [self.view addSubview:firstlbl];
    [self.view addSubview:worklocation_lbl];
    [self.view addSubview:btn];
    
    UITapGestureRecognizer *tapGesture =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelTap)];
    [firstlbl addGestureRecognizer:tapGesture];
    UITapGestureRecognizer *tapGesture1 =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelTap1)];
    [lbl1 addGestureRecognizer:tapGesture1];
    UITapGestureRecognizer *tapGesture2 =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelTap2)];
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

    NSLog(@"exsiting detail %@",exsitingWorkArray);
    if([exsitingWorkArray count]!=0){
        NSArray *temp=[exsitingWorkArray objectAtIndex:0];
        firstlbl.text=[temp objectAtIndex:3];
        worklocation_lbl.text=[temp objectAtIndex:1];
        establishmentId1=[temp objectAtIndex:4];
        workLocationId1=[temp objectAtIndex:2];
        if([exsitingWorkArray count]==2){
            number_of_textfields=1;
            temp=[exsitingWorkArray objectAtIndex:1];
            lbl1.text=[temp objectAtIndex:3];
            worklocation_lbl1.text=[temp objectAtIndex:1];
            establishmentId2=[temp objectAtIndex:4];
            workLocationId2=[temp objectAtIndex:2];
            [self create_textfield];
        }
        if([exsitingWorkArray count]==3){
            number_of_textfields=1;
            temp=[exsitingWorkArray objectAtIndex:1];
            lbl1.text=[temp objectAtIndex:3];
            worklocation_lbl1.text=[temp objectAtIndex:1];
            establishmentId2=[temp objectAtIndex:4];
            workLocationId2=[temp objectAtIndex:2];
            [self create_textfield];
            
            temp=[exsitingWorkArray objectAtIndex:2];
            lbl2.text=[temp objectAtIndex:3];
            worklocation_lbl2.text=[temp objectAtIndex:1];
            establishmentId3=[temp objectAtIndex:4];
            workLocationId3=[temp objectAtIndex:2];
            [self create_textfield];
        }
    }
    
  [[UIBarButtonItem appearance] setTitleTextAttributes:textAttributesTabBar forState:UIControlStateNormal];
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated{

}

-(IBAction)addtxtfld:(id)sender{
    NSLog(@"method called");
    [self create_textfield];
    [self.view bringSubviewToFront:SubView];
    NSLog(@"created");
}
-(IBAction)removetxt:(id)sender{
    if([sender tag]==1){
            if(number_of_textfields==3){
            NSLog(@"tag 1 fld 3");
            lbl1.text=lbl2.text;
            worklocation_lbl1.text=worklocation_lbl2.text;
            lbl2.text=@"Select EstablishmentType";
            worklocation_lbl2.text=@"Select Establishment";
            btn.frame=CGRectMake(30, worklocation_lbl1.frame.origin.y+height_of_component+space_between_textfield, 50, height_of_component);
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
            lbl1.text=@"Select EstablishmentType";
            worklocation_lbl1.text=@"Select Establishment";
            establishmentId2=NULL;
            workLocationId2=NULL;
            btn.frame=CGRectMake(30, worklocation_lbl.frame.origin.y+height_of_component+space_between_textfield, 50, height_of_component);
            number_of_textfields -=1;
            frame_y=worklocation_lbl.frame.origin.y;
            NSLog(@"%d",number_of_textfields);
        }
        
    }
    if([sender tag]==2){
        
        if(number_of_textfields==2){
            NSLog(@"tag 2 fld 2");
            btn.frame=CGRectMake(30, worklocation_lbl.frame.origin.y+height_of_component+space_between_textfield, 50, height_of_component);
            
            number_of_textfields -=1;
            frame_y=worklocation_lbl.frame.origin.y;
            lbl1.text=@"Select EstablishmentType";
            worklocation_lbl1.text=@"Select Establishment";
            establishmentId2=NULL;
            workLocationId2=NULL;
        }
        if(number_of_textfields==3){
            NSLog(@"tag 2 fld 3");
            btn.frame=CGRectMake(30, worklocation_lbl1.frame.origin.y+height_of_component+space_between_textfield, 50, height_of_component);
            number_of_textfields -=1;
            lbl2.text=@"Select EstablishmentType";
            worklocation_lbl2.text=@"Select Establishment";
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
    
    [self.view  addSubview:rm1];
    [self.view addSubview:lbl1];
    [self.view addSubview:worklocation_lbl1];
    CGRect frame1 = [btn frame];
    frame1.origin.y = worklocation_lbl1.frame.origin.y+height_of_component+space_between_textfield;
    frame1.origin.x=30;
    [btn setFrame:frame1];
    frame_y=worklocation_lbl1.frame.origin.y;
}

-(BOOL)create_textfield {
    //check that the user can create it
    NSLog(@"called from outside");
    if(number_of_textfields == 1) {
        NSLog(@"creat");
        NSLog(@"framey second%f",frame_y);
//        lbl1.frame=CGRectMake(30, frame_y+height_of_component+space_between_textfield, width_of_lbl, height_of_component);
//        
//        worklocation_lbl1.frame=CGRectMake(30, lbl1.frame.origin.y+height_of_component+space_between_textfield, width_of_lbl, height_of_component);
//       
//      //  worklocation_lbl1.userInteractionEnabled=YES;
//        
//        
//        rm1.frame=CGRectMake(220,worklocation_lbl1.frame.origin.y, 70, 30);
        
        [self showEstablishSecond];
        
        
        //ubdate the number of textfields
        
//        number_of_textfields++;
//        
//        [self.view  addSubview:rm1];
//        [self.view addSubview:lbl1];
//        [self.view addSubview:worklocation_lbl1];

        //move down the button
        
        
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
        
        [self.view  addSubview:rm2];
        [self.view addSubview:lbl2];
        [self.view addSubview:worklocation_lbl2];
        
        //move down the button
        CGRect frame1 = [btn frame];
        frame1.origin.y = worklocation_lbl2.frame.origin.y+height_of_component+space_between_textfield;
        frame1.origin.x=30;
        [btn setFrame:frame1];
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

- (void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component {
    // Handle the selection
    NSLog(@"%d",row);
     NSArray *tempArray=[pickerDataArray objectAtIndex:row];
    if(pickerView==myPickerView1){
        lbl1.text=[tempArray objectAtIndex:1];
        establishmentId2=[[tempArray objectAtIndex:0] stringValue];
    }
    if(pickerView==myPickerView){
    firstlbl.text=[tempArray objectAtIndex:1];
    establishmentId1=[[tempArray objectAtIndex:0] stringValue];
    }
    if(pickerView==myPickerView2){
        lbl2.text=[tempArray objectAtIndex:1];
        establishmentId3=[[tempArray objectAtIndex:0] stringValue];
    }
}

// tell the picker how many rows are available for a given component
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [pickerDataArray count];
}

// tell the picker how many components it will have
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    UILabel* tView = (UILabel*)view;
    if (!tView){
        tView = [[UILabel alloc] init];
        // Setup label properties - frame, font, colors etc
        tView.font=[UIFont fontWithName:GZFont size:15.0f];
        //adjustsFontSizeToFitWidth property to YES
        // tView.adjustsFontSizeToFitWidth = YES;
    }
    // Fill the label text here
    NSArray *tempArray=[pickerDataArray objectAtIndex:row];
    tView.text=[tempArray objectAtIndex:1];
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveAction:(id)sender {
    NSLog(@"id====>%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"userid"]);
    if(number_of_textfields==3 && (establishmentId1 ==NULL || [worklocation_lbl.text isEqualToString:@"Select WorkLocation"] || establishmentId2 ==NULL || [worklocation_lbl1.text isEqualToString:@"Select WorkLocation"] || establishmentId3 ==NULL || [worklocation_lbl2.text isEqualToString:@"Select WorkLocation"])){
        
        [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                        type:AJNotificationTypeRed
                                       title:@"Enter All Details"
                             linedBackground:AJLinedBackgroundTypeDisabled
                                   hideAfter:GZAJNotificationDelay];
        return;
    }
    else if(number_of_textfields==2 && (establishmentId1 ==NULL || [worklocation_lbl.text isEqualToString:@"Select WorkLocation"] || establishmentId2 ==NULL || [worklocation_lbl1.text isEqualToString:@"Select WorkLocation"])){
        [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                        type:AJNotificationTypeRed
                                       title:@"Enter All Details"
                             linedBackground:AJLinedBackgroundTypeDisabled
                                   hideAfter:GZAJNotificationDelay];
        return;
    }
    else if(number_of_textfields==1 && (establishmentId1 ==NULL || [worklocation_lbl.text isEqualToString:@"Select WorkLocation"])){
        [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                        type:AJNotificationTypeRed
                                       title:@"Enter All Details"
                             linedBackground:AJLinedBackgroundTypeDisabled
                                   hideAfter:GZAJNotificationDelay];
        return;
    }
    else if ([workLocationId1 integerValue]==[workLocationId2 integerValue] || [workLocationId1 integerValue]==[workLocationId3 integerValue]){
        [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                        type:AJNotificationTypeRed
                                       title:@"Same Work Locations are not allow"
                             linedBackground:AJLinedBackgroundTypeDisabled
                                   hideAfter:GZAJNotificationDelay];
        return;
    }
    else if ( ![worklocation_lbl1.text isEqualToString:@"Select Establishment"] &&([workLocationId2 integerValue]==[workLocationId3 integerValue])){
        [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                        type:AJNotificationTypeRed
                                       title:@"Same Work Locations are not allow"
                             linedBackground:AJLinedBackgroundTypeDisabled
                                   hideAfter:GZAJNotificationDelay];
        return;
    }
    else{
    ASIFormDataRequest *_request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:URLSaveOrganization]];
    __unsafe_unretained ASIFormDataRequest *request = _request;
    [request setDelegate:self];
        NSDictionary *dict1,*dict2,*dict3;
        NSMutableDictionary *final=[[NSMutableDictionary alloc]init];
        if(establishmentId1!=NULL &&  workLocationId1!=NULL){
            dict1=[[NSDictionary alloc]initWithObjectsAndKeys:establishmentId1,@"e_id",workLocationId1,@"organization_id", nil];
            [final setValue:dict1 forKey:@"workLocation1"];
        }
        if(establishmentId2!=NULL && workLocationId2!=NULL){
            dict2=[[NSDictionary alloc]initWithObjectsAndKeys:establishmentId2,@"e_id",workLocationId2,@"organization_id", nil];
             [final setValue:dict2 forKey:@"workLocation2"];
        }
        if(establishmentId3!=NULL && workLocationId3!=NULL){
            dict3=[[NSDictionary alloc]initWithObjectsAndKeys:establishmentId3,@"e_id",workLocationId3,@"organization_id", nil];
             [final setValue:dict3 forKey:@"workLocation3"];
        }
        [final setValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"userid"] forKey:@"service_providerId"];

    NSLog(@"final %@",final);
 
    [request appendPostData:[[NSString stringWithFormat:@"%@",final] dataUsingEncoding:NSUTF8StringEncoding]];

    [request setCompletionBlock:^{
        NSDictionary *root = [NSJSONSerialization JSONObjectWithData:request.responseData options:0 error:nil];
        NSLog(@"%@",root);
        [AJNotificationView showNoticeInView:self.view
                                        type:AJNotificationTypeBlue
                                       title:root[@"message"]
                             linedBackground:AJLinedBackgroundTypeDisabled
                                   hideAfter:GZAJNotificationDelay];
        [_delegate establishSave:@"YES"];
        number_of_textfields=1;
        frame_y=100;
        [lbl1 removeFromSuperview];
        [worklocation_lbl1 removeFromSuperview];
        [rm1 removeFromSuperview];
        [lbl2 removeFromSuperview];
        [worklocation_lbl2 removeFromSuperview];
        [rm2 removeFromSuperview];
         btn.frame=CGRectMake(30, worklocation_lbl.frame.origin.y+height_of_component+space_between_textfield, 50, height_of_component);
        if(isFromEditProfile_EVC==TRUE){
            [self.navigationController popViewControllerAnimated:YES];
        }
        else{
        [self.navigationController popToRootViewControllerAnimated:YES];
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
    /*
     {
     "workLocation1": {
     "organization_id": 1,
     "establishment_id": 1
     },
     "workLocation2": {
     "organization_id": 2,
     "establishment_id": 2
     },
     "workLocation3": {
     "organization_id": 3,
     "establishment_id": 3
     },
     "service_providerId": 2
     }
     */
    
}

-(void)workInfo:(NSString *) organization_id name:(NSString *)name tag:(int )tag{
    NSLog(@"helloooooo");
    NSLog(@"%@ %@ %d",organization_id,name,tag);
    if(tag==2){
        worklocation_lbl.text=name;
        workLocationId1=organization_id;
    }
    else if(tag==4){
        worklocation_lbl1.text=name;
        workLocationId2=organization_id;
    }
    else if (tag==6) {
        worklocation_lbl2.text=name;
        workLocationId3=organization_id;
    }
}

@end
