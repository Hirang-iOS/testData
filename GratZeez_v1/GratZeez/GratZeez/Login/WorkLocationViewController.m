//
//  WorkLocationViewController.m
//  GratZeez
//
//  Created by cloudZon Infosoft on 14/11/13.
//  Copyright (c) 2013 cloudZon Infosoft. All rights reserved.
//

#import "WorkLocationViewController.h"
@interface WorkLocationViewController ()

@end

@implementation WorkLocationViewController
@synthesize txtAddress,txtCity,txtWebSite,txtLandMark,txtOrganization,txtZipCode,txtState,txtTelePhone,stateArray,stateTempArray,stateLbl,cityLbl,zipLbl,establishId,lblTag,btn_preview,isFromEditProfile,workTolbar2;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [txtAddress resignFirstResponder];
    [txtCity resignFirstResponder];
    [txtLandMark resignFirstResponder];
    [txtOrganization resignFirstResponder];
    [txtTelePhone resignFirstResponder];
    [txtWebSite resignFirstResponder];
    [txtZipCode resignFirstResponder];
    [UIView animateWithDuration:0.25 delay:0.0 options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         //  self.view.frame=CGRectMake(0, 0, 320, 200);
                         subview.frame=CGRectMake(0, 640, 320, 250);
                         self.view.frame=CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height);
                         
                     }
                     completion:^(BOOL finished){
                         if(finished)  {NSLog(@"Finished end !!!!!");}
                     }];
}
-(IBAction)doneAction:(id)sender{
    NSLog(@"tagg%d",[sender tag]);
    if([sender tag]==1){
        statePicker.hidden=YES;
        cityPicker.hidden=YES;
    [UIView animateWithDuration:0.25 delay:0.0 options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         //  self.view.frame=CGRectMake(0, 0, 320, 200);
                         subview.frame=CGRectMake(0, 640, 320, 250);
                         toolBar1.hidden=YES;
                 
                     }
                     completion:^(BOOL finished){
                         if(finished)  {NSLog(@"Finished end !!!!!");}
                     }];
        cityLbl.text=@"Select City*";
        ASIFormDataRequest *_request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:URLGetCity]];
        __unsafe_unretained ASIFormDataRequest *request = _request;
        [request setDelegate:self];
        NSDictionary *locationListDictionary=[[NSDictionary alloc]initWithObjectsAndKeys:stateId,@"state_id", nil];
        NSLog(@"dict%@",locationListDictionary);
        [request appendPostData:[[NSString stringWithFormat:@"%@",locationListDictionary] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [request setCompletionBlock:^{
            NSDictionary *root = [NSJSONSerialization JSONObjectWithData:request.responseData options:0 error:nil];
            NSLog(@"Worklocatio root %@",root);
            cityArray=root[@"cityList"];
            if([cityArray count]==1){
                NSArray *cityTemp=[cityArray objectAtIndex:0];
                cityLbl.text=[cityTemp objectAtIndex:1];
                cityId=[cityTemp objectAtIndex:0];
            }
            NSLog(@"%@",cityArray);
            //  WorkLocationViewController *wvc=[[WorkLocationViewController alloc]init];
            // wvc.stateArray=root[@"statelist"];
            //[self.navigationController pushViewController:wvc animated:YES];
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

    }
    if([sender tag]==2){
        statePicker.hidden=YES;
        cityPicker.hidden=YES;
        toolBar1.hidden=YES;
        ASIFormDataRequest *_request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:URLGetZipCode]];
        __unsafe_unretained ASIFormDataRequest *request = _request;
        [request setDelegate:self];
        NSDictionary *locationListDictionary=[[NSDictionary alloc]initWithObjectsAndKeys:cityId,@"city_id", nil];
        NSLog(@"dict%@",locationListDictionary);
        [request appendPostData:[[NSString stringWithFormat:@"%@",locationListDictionary] dataUsingEncoding:NSUTF8StringEncoding]];

        // NSDictionary *locationListDictionary=[[NSDictionary alloc]initWithObjectsAndKeys:@"YES",@"request_for_organizationList", nil];
        //[request appendPostData:[[NSString stringWithFormat:@"%@",locationListDictionary] dataUsingEncoding:NSUTF8StringEncoding]];
        //NSLog(@"dict:%@",locationListDictionary);
        [request setCompletionBlock:^{
            NSDictionary *root = [NSJSONSerialization JSONObjectWithData:request.responseData options:0 error:nil];
            NSLog(@"Worklocatio root %@",root);
            zipCodeArray=root[@"zipcodeList"];
            zipTempArray=[[NSMutableArray alloc]init];
            zipArray=[[NSMutableArray alloc]init];
            zipTempArray=[zipCodeArray objectAtIndex:0];
            minZipCode=[[zipTempArray objectAtIndex:1] integerValue];
            maxZipCode=[[zipTempArray  objectAtIndex:2] integerValue];
            if(maxZipCode!=0){
            NSLog(@"%d %d",minZipCode,maxZipCode);
            for(int i=minZipCode;i<=maxZipCode;i++){
                NSString *zip=[NSString stringWithFormat:@"%d",i];
                NSLog(@"%@",zip);
                [zipArray addObject:zip];
            }}
            else{
                [zipArray addObject:[NSString stringWithFormat:@"%d",minZipCode]];
            }
          //  WorkLocationViewController *wvc=[[WorkLocationViewController alloc]init];
           // wvc.stateArray=root[@"statelist"];
            //[self.navigationController pushViewController:wvc animated:YES];
        }];
        [request setFailedBlock:^{
            NSError *error = [request error];
            [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                            type:AJNotificationTypeRed
                                           title:error.localizedDescription
                                 linedBackground:AJLinedBackgroundTypeDisabled
                                       hideAfter:GZAJNotificationDelay];
        }];
     //   [request startAsynchronous];
        [UIView animateWithDuration:0.25 delay:0.0 options: UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             //  self.view.frame=CGRectMake(0, 0, 320, 200);
                             subview.frame=CGRectMake(0, 640, 320, 250);
                             //                         CGRect f1;
                             //                         f1=self.view.frame;
                             //                         f1.origin.y=f1.origin.y+100;
                             //  self.view.frame=f1;
                         }
                         completion:^(BOOL finished){
                             if(finished)  {NSLog(@"Finished end !!!!!");}
                         }];

    }
    if([sender tag]==3){
        statePicker.hidden=YES;
        cityPicker.hidden=YES;
        [UIView animateWithDuration:0.25 delay:0.0 options: UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             //  self.view.frame=CGRectMake(0, 0, 320, 200);
                             subview.frame=CGRectMake(0, 640, 320, 250);
                             //                         CGRect f1;
                             //                         f1=self.view.frame;
                             //                         f1.origin.y=f1.origin.y+100;
                             //  self.view.frame=f1;
                         }
                         completion:^(BOOL finished){
                             if(finished)  {NSLog(@"Finished end !!!!!");}
                         }];
}
}
-(void)labelTap:(UIGestureRecognizer *)sender{
    [txtAddress resignFirstResponder];
    if(sender.view.tag==1){
        stateLbl.layer.borderWidth=0;
        statePicker.hidden=NO;
        cityPicker.hidden=YES;
        UIBarButtonItem *barButtonDone = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                          style:UIBarButtonItemStyleBordered target:self action:@selector(doneAction:)];
        barButtonDone.tag=1;
        toolBar1.items = [[NSArray alloc] initWithObjects:barButtonDone,nil];
        toolBar1.hidden=NO;
        barButtonDone.tintColor=[UIColor blackColor];
        [UIView animateWithDuration:0.25 delay:0.0 options: UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             // self.view.frame=CGRectMake(0, -30, 320, 200);
                             subview.frame=CGRectMake(0, 280, 320, 250);
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
    if(sender.view.tag==2){
        if(stateId ==NULL || [cityArray count]==0){
            [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                            type:AJNotificationTypeRed
                                           title:@"Select state first"
                                 linedBackground:AJLinedBackgroundTypeDisabled
                                       hideAfter:GZAJNotificationDelay];
            return ;
        }
        cityLbl.layer.borderWidth=0;
        statePicker.hidden=YES;
        cityPicker.hidden=NO;
        toolBar1.hidden=NO;
        UIBarButtonItem *barButtonDone = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                          style:UIBarButtonItemStyleBordered target:self action:@selector(doneAction:)];
        barButtonDone.tag=2;
        toolBar1.items = [[NSArray alloc] initWithObjects:barButtonDone,nil];
        barButtonDone.tintColor=[UIColor blackColor];
        [cityPicker reloadAllComponents];
        [UIView animateWithDuration:0.25 delay:0.0 options: UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             // self.view.frame=CGRectMake(0, -30, 320, 200);
                             subview.frame=CGRectMake(0, 280, 320, 250);
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
    if(sender.view.tag==3){
        if(stateId==NULL || cityId==NULL){
            [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                            type:AJNotificationTypeRed
                                           title:@"Select state & city first"
                                 linedBackground:AJLinedBackgroundTypeDisabled
                                       hideAfter:GZAJNotificationDelay];
            return ;
        }
        NSLog(@"zipcode picker");
        statePicker.hidden=YES;
        cityPicker.hidden=YES;
        toolBar1.hidden=NO;
        UIBarButtonItem *barButtonDone = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                          style:UIBarButtonItemStyleBordered target:self action:@selector(doneAction:)];
        barButtonDone.tag=3;
        toolBar1.items = [[NSArray alloc] initWithObjects:barButtonDone,nil];
        barButtonDone.tintColor=[UIColor blackColor];
        [UIView animateWithDuration:0.25 delay:0.0 options: UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             // self.view.frame=CGRectMake(0, -30, 320, 200);
                             subview.frame=CGRectMake(0, 280, 320, 250);
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
    [txtOrganization resignFirstResponder];
    [txtLandMark resignFirstResponder];
    [txtAddress resignFirstResponder];
    [txtZipCode resignFirstResponder];
    [txtWebSite resignFirstResponder];
    [txtTelePhone resignFirstResponder];
    [UIView animateWithDuration:0.25 delay:0.0 options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         // self.view.frame=CGRectMake(0, -30, 320, 200);
                        // subview.frame=CGRectMake(0, 640, 320, 180);
                         //                             CGRect f1;
                         //                             f1=self.view.frame;
                         //                             f1.origin.y=f1.origin.y-100;
                         // self.view.frame=f1;
                         // v1.backgroundColor=[UIColor blackColor];
                         self.view.frame=CGRectMake(0, 64, 320, self.view.frame.size.height);
                     }
                     completion:^(BOOL finished){
                         if(finished)  {NSLog(@"Finished end !!!!!");}
                     }];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    stateTempArray=[[NSMutableArray alloc]init];
    NSArray *tempArray;
    textflag=0;
    for(int i=0;i<[stateArray count];i++){
        tempArray=[stateArray objectAtIndex:i];
        [stateTempArray addObject:[tempArray objectAtIndex:1]];
    }
    NSLog(@"%d",[stateTempArray count]);
    NSLog(@"%@",stateArray);
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"background_half"]];
    subview=[[UIView alloc]initWithFrame:CGRectMake(0, 640, 320, 250)];
    self.title=@"WorkLocation Details";
    [self.view setUserInteractionEnabled:YES];
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])self.edgesForExtendedLayout = UIRectEdgeNone;
    UIBarButtonItem *btnHelp = [[UIBarButtonItem alloc] initWithTitle:@"Help" style:UIBarButtonItemStylePlain target:self action:@selector(btnHelpAction:)];
    self.navigationItem.rightBarButtonItem=btnHelp;
    originalCenter=self.view.center;
    //NSLog(@"%d",[stateArray count]);
    statePicker=[[UIPickerView alloc]initWithFrame:CGRectMake(0, 0, 320, 220)];
    statePicker.delegate = self;
    statePicker.dataSource=self;
    statePicker.backgroundColor=RGB(210, 200, 191);
    statePicker.showsSelectionIndicator = YES;
    cityPicker=[[UIPickerView alloc]initWithFrame:CGRectMake(0, 0, 320, 220)];
    cityPicker.delegate = self;
    cityPicker.dataSource=self;
    cityPicker.backgroundColor=RGB(210, 200, 191);
    cityPicker.showsSelectionIndicator = YES;
    [subview addSubview:statePicker];
    [subview addSubview:cityPicker];
    toolBar1= [[UIToolbar alloc] initWithFrame:CGRectMake(0,00,320,40)];
    //[toolBar1 setBarStyle:UIBarStyleBlackOpaque];
    toolBar1.translucent=NO;
    toolBar1.barTintColor=RGB(155, 130, 110);
    [subview addSubview:toolBar1];
    stateLbl.text=@"Select State*";
    stateLbl.font=[UIFont fontWithName:GZFont size:15.0f];
    stateLbl.userInteractionEnabled=YES;
//    stateLbl.layer.borderWidth=1.0;
//    stateLbl.layer.borderColor=[[UIColor grayColor]CGColor];
//    [stateLbl.layer setCornerRadius:3];
//    [stateLbl.layer setMasksToBounds:NO];
    stateLbl.textAlignment = NSTextAlignmentCenter;
    stateLbl.tag=1;
    tapGesture =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelTap:)];
    [stateLbl addGestureRecognizer:tapGesture];
    cityLbl.text=@"Select City*";
    cityLbl.font=[UIFont fontWithName:GZFont size:15.0f];
    cityLbl.userInteractionEnabled=YES;
//    cityLbl.layer.borderWidth=1.0;
//    cityLbl.layer.borderColor=[[UIColor grayColor]CGColor];
//    [cityLbl.layer setCornerRadius:3];
//    [cityLbl.layer setMasksToBounds:NO];
    cityLbl.textAlignment = NSTextAlignmentCenter;
    cityLbl.tag=2;
    UITapGestureRecognizer *tapGesture1 =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelTap:)];
    [cityLbl addGestureRecognizer:tapGesture1];
    zipLbl.text=@"Select ZipCode";
    zipLbl.font=[UIFont fontWithName:GZFont size:15.0f];
    zipLbl.userInteractionEnabled=YES;
//    zipLbl.layer.borderWidth=1.0;
//    zipLbl.layer.borderColor=[[UIColor grayColor]CGColor];
//    [zipLbl.layer setCornerRadius:3];
//    [zipLbl.layer setMasksToBounds:NO];
    zipLbl.textAlignment = NSTextAlignmentCenter;
    zipLbl.tag=3;
    UITapGestureRecognizer *tapGesture2 =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelTap:)];
    [zipLbl addGestureRecognizer:tapGesture2];
    [self.view addSubview:subview];
    txtOrganization.font=[UIFont fontWithName:GZFont size:15.0f];
    txtLandMark.font=[UIFont fontWithName:GZFont size:15.0f];
    txtAddress.font=[UIFont fontWithName:GZFont size:15.0f];
    txtWebSite.font=[UIFont fontWithName:GZFont size:15.0f];
    txtTelePhone.font=[UIFont fontWithName:GZFont size:15.0f];
    txtZipCode.font=[UIFont fontWithName:GZFont size:15.0f];
    [[UIBarButtonItem appearance] setTitleTextAttributes:textAttributes forState:UIControlStateNormal];
    NSMutableAttributedString *preview = [[NSMutableAttributedString alloc] initWithString:@"Preview"];
    [preview addAttribute:NSForegroundColorAttributeName  value:[UIColor whiteColor] range:(NSRange){0,[preview length]}];
    
    [preview addAttribute:NSFontAttributeName value:[UIFont fontWithName:GZFont size:18.0f] range:(NSRange){0,[preview length]}];
    [btn_preview setAttributedTitle:preview forState:UIControlStateNormal];
    [[UIBarButtonItem appearance] setTitleTextAttributes:textAttributesTabBar forState:UIControlStateNormal];
    NSLog(@"%f %f %f %f",self.view.frame.origin.x,self.view.frame.origin.y,self.view.frame.size.width,self.view.frame.size.height);
    //stateLbl.backgroundColor=[UIColor  colorWithPatternImage:[UIImage imageNamed:@"text_field"]];
    // Do any additional setup after loading the view from its nib.
    
    workTolbar2.frame=CGRectMake(0, 524, 320, 44);
    [self.view addSubview:workTolbar2];
    UIButton *backBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 36, 21)];
    [backBtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    UIBarButtonItem *btnitem=[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    workTolbar2.items=@[btnitem];
    [workTolbar2 setBackgroundImage:toolBarImage forToolbarPosition:UIBarPositionBottom barMetrics:UIBarMetricsDefault];
    [self addLeftMenuButtonWithImage:[UIImage imageNamed:@"menu_icon"]];
    [self addrightMenuButtonWithImage:[UIImage imageNamed:@"help"]];
    UISwipeGestureRecognizer *rightRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(backAction:)];
    rightRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [rightRecognizer setNumberOfTouchesRequired:1];
    [self.view addGestureRecognizer:rightRecognizer];
}
-(IBAction)backAction:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
//    if(textField==txtZipCode){
//        if(textflag==1){
//            return;
//        }
//        [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{CGRect frame;
//            frame=self.view.frame;
//            NSLog(@"frame __ %f %f %f %f",frame.origin.x,frame.origin.y,frame.size.width,frame.size.height);
//           // frame.origin.y=frame.origin.y-130;
//            self.view.frame=CGRectMake(0, -66, 320, self.view.frame.size.height);
//            subview.frame=CGRectMake(0, 640, 320, 250);
//        } completion:^(BOOL finished){
//            if(finished){
//                NSLog(@"finished");
//                textflag=1;
//            }
//        }];
//    }
    if(textField==txtWebSite){
        if(self.view.frame.origin.y!=-66){
        [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            //frame.origin.y=frame.origin.y-130;
             self.view.frame=CGRectMake(0, -66, 320, self.view.frame.size.height);
            subview.frame=CGRectMake(0, 640, 320, 250);
        } completion:^(BOOL finished){
            if(finished){
                NSLog(@"finished");
                textflag=1;
            }
        }];
        }
    }
    if(textField==txtTelePhone){
        if(self.view.frame.origin.y!=-66){
            [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
                
            subview.frame=CGRectMake(0, 640, 320, 250);
           self.view.frame=CGRectMake(0, -66, 320, self.view.frame.size.height);
        } completion:^(BOOL finished){
            if(finished){
                NSLog(@"finished");
            }
        }];
        }
    }
    if(textField==txtAddress){
        txtAddress.layer.borderWidth=0;
        [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            subview.frame=CGRectMake(0, 640, 320, 250);
        } completion:^(BOOL finished){
            if(finished){
                NSLog(@"finished");
            }
        }];
    }
    if(textField==txtOrganization){
        txtOrganization.layer.borderWidth=0;
        [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            subview.frame=CGRectMake(0, 640, 320, 250);
        } completion:^(BOOL finished){
            if(finished){
                NSLog(@"finished");
            }
        }];
    }
    if(textField==txtLandMark){
        txtLandMark.layer.borderWidth=0;
        [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            subview.frame=CGRectMake(0, 640, 320, 250);
        } completion:^(BOOL finished){
            if(finished){
                NSLog(@"finished");
            }
        }];
    }
    if(txtZipCode){
        txtZipCode.layer.borderWidth=0;
        [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            subview.frame=CGRectMake(0, 640, 320, 250);
        } completion:^(BOOL finished){
            if(finished){
                NSLog(@"finished");
            }
        }];
    }
}
-(void)textFieldDidEndEditing:(UITextField *)textField{

    if(textField==txtWebSite){
//        if(textflag==1){
//            return;
//        }
//        [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{CGRect frame;
//            frame=self.view.frame;
//         //   frame.origin.y=frame.origin.y+130;
//            self.view.frame=CGRectMake(0, 64, 320, self.view.frame.size.height);
//        } completion:^(BOOL finished){
//            if(finished){
//                NSLog(@"finished");
//                //textflag=0;
//            }
//        }];
    }
//    if(textField==txtTelePhone){
//        [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{CGRect frame;
//            frame=self.view.frame;
//          //  frame.origin.y=frame.origin.y+130;
//        
//            self.view.frame=CGRectMake(0, 64, 320, self.view.frame.size.height);
//        } completion:^(BOOL finished){
//            if(finished){
//                NSLog(@"finished");
//                textflag=0;
//            }
//        }];
//    }
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
    [self presentViewController:helpNavController animated:YES completion:nil];}
//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
//    [txtZipCode resignFirstResponder];
//    [txtOrganization resignFirstResponder];
//    [txtState resignFirstResponder];
//    [txtAddress resignFirstResponder];
//    [txtCity resignFirstResponder];
//    [txtLandMark resignFirstResponder];
//    [txtWebSite resignFirstResponder];
//    [txtTelePhone resignFirstResponder];
//    if(textflag==1){
//        [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{CGRect frame;
//            frame=self.view.frame;
//            frame.origin.y=frame.origin.y+130;
//            self.view.frame=frame;
//        } completion:^(BOOL finished){
//            if(finished){
//                NSLog(@"finished");
//                textflag=0;
//            }
//        }];
//    }
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setTitle:(NSString *)title {
    UILabel *titleView = (UILabel *)self.navigationItem.titleView;
    if (!titleView) {
        titleView = [[UILabel alloc] initWithFrame:CGRectZero];
        titleView.backgroundColor = [UIColor clearColor];
        titleView.font = [UIFont fontWithName:@"Garamond 3 SC" size:18.0];
        titleView.textColor = [UIColor whiteColor];
        self.navigationItem.titleView = titleView;
    }
    titleView.text = title;
    [titleView sizeToFit];
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if(textField==txtOrganization){
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        if(newLength>30){
            return NO;
        }
    }
    if(textField==txtLandMark){
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        if(newLength>20){
            return NO;
        }
    }
    if(textField==txtAddress){
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        if(newLength>100){
            return NO;
        }
    }
    if(textField==txtWebSite){
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        if(newLength>40){
            return NO;
        }
    }
    if(textField==txtTelePhone){
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        if(newLength>15){
            return NO;
        }
        
        NSCharacterSet *nonNumberSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
        if([string rangeOfCharacterFromSet:nonNumberSet].location != NSNotFound){
            return ([string stringByTrimmingCharactersInSet:nonNumberSet].length > 0) || [string isEqualToString:@""];
        }
        
    }
    if(textField==txtZipCode){
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        if(newLength>5){
            return NO;
        }
        
        NSCharacterSet *nonNumberSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
        if([string rangeOfCharacterFromSet:nonNumberSet].location != NSNotFound){
            return ([string stringByTrimmingCharactersInSet:nonNumberSet].length > 0) || [string isEqualToString:@""];
        }
        
    }
    return 1;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if(textField==txtOrganization){
        [txtOrganization resignFirstResponder];
        [txtLandMark becomeFirstResponder];
    }
    else if (textField==txtLandMark) {
        [txtLandMark resignFirstResponder];
        [txtAddress becomeFirstResponder];
    }
    else if (textField==txtAddress) {
        [txtAddress resignFirstResponder];
        [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{CGRect frame;
            frame=self.view.frame;
            //   frame.origin.y=frame.origin.y+130;
            self.view.frame=CGRectMake(0, 64, 320, self.view.frame.size.height);
        } completion:^(BOOL finished){
            if(finished){
                NSLog(@"finished");
                //textflag=0;
            }
        }];
    }
    if (textField==txtZipCode) {
        [txtZipCode resignFirstResponder];
        [txtWebSite becomeFirstResponder];
    }
    else if (textField==txtWebSite) {
        [txtWebSite resignFirstResponder];
        [txtTelePhone becomeFirstResponder];
    }
    else if(textField==txtTelePhone){
        [txtTelePhone resignFirstResponder];
        if(textField==txtTelePhone){
                    [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{CGRect frame;
                        frame=self.view.frame;
                      //  frame.origin.y=frame.origin.y+130;
            
                        self.view.frame=CGRectMake(0, 64, 320, self.view.frame.size.height);
                    } completion:^(BOOL finished){
                        if(finished){
                            NSLog(@"finished");
                            textflag=0;
                        }
                    }];
                }
    }
    return YES;
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
- (void)sendLatLongRequestAction:(void(^)(BOOL result))return_block{
    //NSString *temp=[txtLandMark.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    landMark= [txtLandMark.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    address=[txtAddress.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] ;
    city=[txtCity.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    website=[txtWebSite.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    state=[txtState.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    zipcode=[txtZipCode.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    organization=[txtOrganization.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if([organization length]<=0 || [address length]<=0 || stateId==NULL || [website length]<=0 || [landMark length]<=0 || cityId==NULL  || [zipcode length]<=0){
        [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                        type:AJNotificationTypeRed
                                       title:@"All fields with * are mandatory"
                             linedBackground:AJLinedBackgroundTypeDisabled
                                   hideAfter:GZAJNotificationDelay];
        if([organization length]==0){
            [self chagneTextFieldStyle:txtOrganization];
        }
        if([address length]==0){
            [self chagneTextFieldStyle:txtAddress];
        }
        if([landMark length]==0){
            [self chagneTextFieldStyle:txtLandMark];
        }
        if([zipcode length]==0){
            [self chagneTextFieldStyle:txtZipCode];
        }
        if(stateId==NULL){
            stateLbl.layer.borderColor=[[UIColor redColor] CGColor];
            stateLbl.layer.borderWidth=1;
            stateLbl.layer.masksToBounds=YES;
            stateLbl.layer.cornerRadius=4.7;
//            stateLbl.layer.shadowOpacity = 0.2;
//            stateLbl.layer.shadowRadius = 0.0;
//            stateLbl.layer.shadowColor = [UIColor redColor].CGColor;
//            stateLbl.layer.shadowOffset = CGSizeMake(1.0, -0.5);
        }
        if(cityId==NULL){
            cityLbl.layer.borderColor=[[UIColor redColor] CGColor];
            cityLbl.layer.borderWidth=1;
            cityLbl.layer.masksToBounds=YES;
            cityLbl.layer.cornerRadius=4.7;
//            cityLbl.layer.shadowOpacity = 0.2;
//            cityLbl.layer.shadowRadius = 0.0;
//            cityLbl.layer.shadowColor = [UIColor redColor].CGColor;
//            cityLbl.layer.shadowOffset = CGSizeMake(1.0, -0.5);
        }
    }
    else if([zipcode length]>5){
        [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                        type:AJNotificationTypeRed
                                       title:@"ZipCode is not Valid"
                             linedBackground:AJLinedBackgroundTypeDisabled
                                   hideAfter:GZAJNotificationDelay];
        [self chagneTextFieldStyle:txtZipCode];
        return;
    }
    else if(![self zipcodevalidation:zipcode]){
        [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                        type:AJNotificationTypeRed
                                       title:@"ZipCode is not Valid"
                             linedBackground:AJLinedBackgroundTypeDisabled
                                   hideAfter:GZAJNotificationDelay];
        [self chagneTextFieldStyle:txtZipCode];
        return;
    }
    else{
  
        
    landMark= [[landMark stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] stringByReplacingOccurrencesOfString:@" " withString:@"+"];
   address=[[address stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] stringByReplacingOccurrencesOfString:@" " withString:@"+"];
   // city=[[city stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] stringByReplacingOccurrencesOfString:@" " withString:@"+"];
   website=[[website stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    state=[[state stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    zipcode=[[zipcode stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] stringByReplacingOccurrencesOfString:@" " withString:@"+"];

    NSString *addressString=[NSString stringWithFormat:@"%@+%@+%@+%@+USA+%@",landMark,address,cityLbl.text,stateLbl.text,zipcode];
        NSLog(@"address%@",addressString);
    ASIFormDataRequest *_request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/geocode/json?address=%@&sensor=true",addressString]]];
   // ASIFormDataRequest *_request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/geocode/json?address=%@&sensor=true",str]]];
    __unsafe_unretained ASIFormDataRequest *request = _request;
    [request setDelegate:self];
    [request startAsynchronous];
    [request setCompletionBlock:^{
        NSDictionary *root = [NSJSONSerialization JSONObjectWithData:request.responseData options:0 error:nil];
        NSLog(@"==> LAT Address ROOT: %@",root);
        if([root[@"results"] count]==0 || [root count]==0){
            [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                            type:AJNotificationTypeRed
                                           title:@"Address  not Found, Please Check."
                                 linedBackground:AJLinedBackgroundTypeDisabled
                                       hideAfter:GZAJNotificationDelay];
            return ;
        }
        
        NSArray *results           = root[@"results"];
        
        NSDictionary *result       = results[0];   // let's grab the first result
        
        //NSArray *addressComponents = result[@"address_components"];
        //NSString *formattedAddress = result[@"formatted_address"];
        NSDictionary *geometry     = result[@"geometry"];
        //NSNumber *partialMatch     = result[@"partial_match"];
        //NSArray *types             = result[@"types"];
        
        NSDictionary *location     = geometry[@"location"];
        NSString *latitudeString   = location[@"lat"];
        NSString *longitudeString  = location[@"lng"];
        NSLog(@"vivek%@",latitudeString);
        workCoordinate.latitude=[latitudeString floatValue];
        workCoordinate.longitude=[longitudeString floatValue];
        return_block(TRUE);
        //[_delegate latLongForLocation:[loc valueForKey:@"lat"] long:[loc valueForKey:@"lng"]];
    }];
        [request setFailedBlock:^{
            NSError *error = [request error];
            NSLog(@"Error: %@",error.localizedDescription);
            [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                            type:AJNotificationTypeRed
                                           title:error.localizedDescription
                                 linedBackground:AJLinedBackgroundTypeDisabled
                                       hideAfter:GZAJNotificationDelay];
            return_block(false);
        }];
    }
}

- (IBAction)continueAction:(id)sender {
    [self sendLatLongRequestAction:^(BOOL result){
        if(result){
            NSLog(@"lat %f,lng %f",workCoordinate.latitude,workCoordinate.longitude);
            NSString *latitude,*longitude;
            if(changeCoordinate.latitude !=0 && changeCoordinate.longitude !=0){
            latitude=[NSString stringWithFormat:@"%f",changeCoordinate.latitude];
            NSLog(@"===%@",latitude);
            longitude=[NSString stringWithFormat:@"%f",changeCoordinate.longitude];
            }
            else{
                latitude=[NSString stringWithFormat:@"%f",workCoordinate.latitude];
                longitude=[NSString stringWithFormat:@"%f",workCoordinate.longitude];
            }
            NSLog(@".....%@",txtTelePhone.text);
            NSString *contactString=txtTelePhone.text;
            NSLog(@"%@",contactString);
            NSLog(@"id===%@",establishId);
            NSDictionary *organizationDictionary=[[NSDictionary alloc]initWithObjectsAndKeys:txtOrganization.text,@"organization_name",stateId,@"state_id",cityId,@"city_id",txtLandMark.text,@"landMark",txtAddress.text,@"address",website,@"website",zipcode,@"zipcode",latitude,@"latitude",longitude,@"longitude",establishId,@"e_id",contactString,@"contact_number",[[NSUserDefaults standardUserDefaults] valueForKey:@"userid"],@"userid", nil];
            NSLog(@"final===>%@",organizationDictionary);
            //,workCoordinate.latitude,@"latitude",workCoordinate.longitude,@"longitude"
            ASIFormDataRequest *_request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:URLNewOrganization]];
            __unsafe_unretained ASIFormDataRequest *request = _request;
            [request appendPostData:[[NSString stringWithFormat:@"%@",organizationDictionary] dataUsingEncoding:NSUTF8StringEncoding]];
            
            [request setDelegate:self];
            [request setCompletionBlock:^{
                NSDictionary *root = [NSJSONSerialization JSONObjectWithData:request.responseData options:0 error:nil];
                NSLog(@"response%@",root);
                NSLog(@"From Edit %d",isFromEditProfile);
                NSArray *array = [self.navigationController viewControllers];
                NSLog(@"Navigation Array %@",array);
                [_delegate workInfo:root[@"organizationId"] name:txtOrganization.text tag:lblTag];
                NSLog(@"delegate%@",_delegate);
                NSLog(@"vivek");
                if(isFromEditProfile==TRUE){
                    NSLog(@"object %@",[array objectAtIndex:1]);
                     [self.navigationController popToViewController:[array objectAtIndex:1] animated:YES];
                }
                else{
                [self.navigationController popToViewController:[array objectAtIndex:0] animated:YES];
                }
                // [self dismissViewControllerAnimated:YES completion:nil];
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
        else{
            return;
        }
    }];
    
}


-(void)changeLatLong:(CLLocationCoordinate2D)coordinateChange flag:(int)flag{
    if(coordinateChange.latitude!=0 || coordinateChange.longitude!=0)
    {
        changeCoordinate=coordinateChange;
       // NSLog(@"====>%f",workCoordinate.latitude);
    }
    
}
- (IBAction)previewAction:(id)sender {
    [self sendLatLongRequestAction:^(BOOL result){
        if(result){
            MapViewController *MVC=[[MapViewController alloc]init];
            NSLog(@"===>%f",MVC.coordinate.latitude);
            if(changeCoordinate.latitude!=0 && changeCoordinate.longitude!=0){
                MVC.coordinate=changeCoordinate;
            }
            else{
            MVC.coordinate=workCoordinate;
            }
            MVC.city=self.cityLbl.text;
            MVC.landmark=txtLandMark.text;
            MVC.delegate=self;
            [self.navigationController pushViewController:MVC animated:YES];
        }
        else{
            return ;
        }
    }];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component {
    // Handle the selection
   // NSLog(@"%d",row);
    if(pickerView==statePicker){
    stateLbl.text=[stateTempArray objectAtIndex:row];
    NSArray *tempArray=[stateArray objectAtIndex:row];
    stateId=[[tempArray objectAtIndex:0] stringValue];
    }
    if(pickerView==cityPicker){
        NSArray *tempArray=[cityArray objectAtIndex:row];
        NSLog(@"temparray %@",tempArray);
        cityLbl.text=[tempArray objectAtIndex:1];
        cityId=[[tempArray objectAtIndex:0] stringValue];
    }
    
   
}

// tell the picker how many rows are available for a given component
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
   // NSUInteger numRows = 5;
    if(pickerView==statePicker){
    return [stateTempArray count];
    }
    if(pickerView==cityPicker){
        NSLog(@"count is%d",[cityArray count]);
        return [cityArray count];
    }
    return 0;
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
        tView.font=[UIFont fontWithName:@"Garamond" size:15.0f];
        //adjustsFontSizeToFitWidth property to YES
        // tView.adjustsFontSizeToFitWidth = YES;
    }
    // Fill the label text here
    if(pickerView==statePicker){
    tView.text=[stateTempArray objectAtIndex:row];
    }
    if(pickerView==cityPicker){
        NSArray *tempArray=[cityArray objectAtIndex:row];
        NSLog(@"temparray %@",tempArray);
        tView.text=[tempArray objectAtIndex:1];
    }
    tView.textAlignment=NSTextAlignmentCenter;
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
- (BOOL)zipcodevalidation:(NSString *)zipstring {
    
   // NSString *emailRegex = @"(^[0-9]{5}(-[0-9]{4})?$)";
    NSString *emailRegex=@"^\\d{5}(-\\d{4})?$";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:zipstring];
}


@end
