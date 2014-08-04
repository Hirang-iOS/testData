//
//  SearchedProfileViewController.m
//  GratZeez
//
//  Created by cloudZon Infosoft on 30/10/13.
//  Copyright (c) 2013 cloudZon Infosoft. All rights reserved.
//

#import "SearchedProfileViewController.h"
#import "AppDelegate.h"
#import "Constant.h"
@interface SearchedProfileViewController ()

@end

@implementation SearchedProfileViewController
@synthesize proImg,lblusername,lblFirst_name,lblLast_name,lblNumber,lblEstablishment,cellId,txtAmount,txtComment,isFavorite,btn_favorite,lbl_favorite,lbl_gratuity,lbl_rate,lbl_amount_to_charity,txt_invoice,txt_sendPercentage,view_invoice,view_rate,view_btn;
@synthesize searchedToolbar,lbl_count,amountToCharity,individualRate;
double amountOfGratZeez;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{

    
        NSLog(@"@@@@@@@@@@@@@@@@@@@@");
        self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
//    else{
//        self = [super initWithNibName:@"SearchedProfileViewController4s" bundle:[NSBundle mainBundle]];
//    }
    if (self) {
        // Custom initialization
    }

    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    confirmAlert = [[UIAlertView alloc] initWithTitle:@"Confirm"
                                                           message:@"Are you really want to send gratuity to this User?"
                                                          delegate:self
                                                 cancelButtonTitle:@"No"
                                                 otherButtonTitles:@"Yes", nil];
 
    self.view.backgroundColor=RGB(210, 200, 191);
    [[UIBarButtonItem appearance] setTitleTextAttributes:textAttributesTabBar forState:UIControlStateNormal];
    NSLog(@"profile Array====>%@",MyAppDelegate.searchResultArray);
    NSLog(@"%d",cellId);

    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])self.edgesForExtendedLayout = UIRectEdgeNone;
    self.edgesForExtendedLayout=UIRectEdgeNone;
    NSArray *tmpresultArray=[MyAppDelegate.searchResultArray objectAtIndex:cellId];
    lblusername.text=[tmpresultArray objectAtIndex:0];//[tmpdictionary valueForKey:@"email"];
    lblusername.font=[UIFont fontWithName:GZFont size:16];
    lbl_count.font=[UIFont fontWithName:GZFont size:10];
    NSLog(@"user%@",lblusername.text);
    if([tmpresultArray objectAtIndex:2]==[NSNull null]){
        lblFirst_name.text=@"";
    }
    else{
        lblFirst_name.text=[[tmpresultArray objectAtIndex:2] stringByAppendingFormat:@"  %@",[tmpresultArray objectAtIndex:3]];}//[tmpdictionary valueForKey:@"firstName"];
    NSLog(@"first%@",lblFirst_name.text);
    if([[tmpresultArray objectAtIndex:1] integerValue]==0){
        lblNumber.text=@"";
    }
    else{
    lblNumber.text=[NSString stringWithFormat:@"%@",[tmpresultArray objectAtIndex:1]];//[tmpdictionary valueForKey:@"contactNumber"];
    NSLog(@"number%@",lblNumber.text);
    }
    lblEstablishment.text=[NSString stringWithFormat:@"Working In: %@",[tmpresultArray objectAtIndex:9]];

        NSString *urlString=[ImageURL stringByAppendingPathComponent:[tmpresultArray objectAtIndex:6]];

        proImg.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]]];
   
    UILabel *txtViewLabel=[[UILabel alloc]initWithFrame:CGRectMake(5, 5, 120, 50)];
    txtViewLabel.text=@"Tap Here To Comment";
    txtViewLabel.textColor=[UIColor grayColor];
    [txtview addSubview:txtViewLabel];
    proImg.layer.cornerRadius=3.0;
    proImg.layer.masksToBounds=YES;
    proImg.layer.borderWidth=0.5;
    [txtComment setUserInteractionEnabled:YES];
    mainViewCenter=self.view.center;
    if(MyAppDelegate.isiPhone5){
    rateView = [[DYRateView alloc] initWithFrame:CGRectMake(40, 20, 150, 60)
                                                    fullStar:[UIImage imageNamed:@"StarFull@2x.png"]
                                                   emptyStar:[UIImage imageNamed:@"StarEmpty@2x.png"]];
    }
    else{
    rateView = [[DYRateView alloc] initWithFrame:CGRectMake(40, 265, 120, 20)
                                                        fullStar:[UIImage imageNamed:@"StarFullLarge.png"]
                                                       emptyStar:[UIImage imageNamed:@"StarEmptyLarge.png"]];
    }
    rateView.padding = 2;
    rateView.rate =[individualRate doubleValue];
    NSLog(@"rate%f",rateView.rate);
    rateView.alignment = RateViewAlignmentLeft;
    rateView.editable = YES;
    rateView.delegate = self;
    [view_rate addSubview:rateView];
    
    serviceProviderUserid=[tmpresultArray objectAtIndex:4];
    organizationId=[tmpresultArray objectAtIndex:8];
    NSLog(@"serv%@",serviceProviderUserid);// original 5
    
    view_rate.backgroundColor=[UIColor clearColor];
    view_btn.backgroundColor=[UIColor clearColor];
    self.title=@"Service Provider";
    UIBarButtonItem *btnHelp = [[UIBarButtonItem alloc] initWithTitle:@"Help" style:UIBarButtonItemStylePlain target:self action:@selector(btnHelpAction:)];
    self.navigationItem.rightBarButtonItem=btnHelp;
    if(isFavorite==1){
        btn_favorite.hidden=YES;
        lbl_favorite.hidden=YES;
    }
    lbl_favorite.textColor=RGB(130, 100, 75);

    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];

    lbl_rate.font=[UIFont fontWithName:GZFont size:16.0f];
    lbl_favorite.font=[UIFont fontWithName:GZFont size:16.0f];
    lbl_gratuity.font=[UIFont fontWithName:GZFont size:14.0f];
    lblEstablishment.font=[UIFont fontWithName:GZFont size:16.0f];
    lblFirst_name.font=[UIFont fontWithName:GZFont size:16.0f];
    lblNumber.font=[UIFont fontWithName:GZFont size:16.0f];
    txtAmount.font=[UIFont fontWithName:GZFont size:13.0f];
    txtComment.font=[UIFont fontWithName:GZFont size:15.0f];
    txtComment.layer.borderWidth=0.5;
    txtComment.layer.borderColor=[[UIColor clearColor] CGColor];
    txtComment.layer.cornerRadius=3;
    txtComment.layer.masksToBounds=YES;
    if(amountToCharity==0){
        lbl_amount_to_charity.hidden=YES;
//        lbl_amount_to_charity.text=@"None of gratity will be given to charity";
    }
    else{
        lbl_amount_to_charity.hidden=NO;
        lbl_amount_to_charity.text=[NSString stringWithFormat:@"%d %% of gratuity will be given to charity",amountToCharity];
    }
    
    //Computation of gratuity and its view
    txt_invoice.hidden=YES;
    txt_sendPercentage.hidden=YES;
    view_invoice.backgroundColor=[UIColor clearColor];
 
    [txt_sendPercentage addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [txtAmount addTarget:self action:@selector(textAmountChange:) forControlEvents:UIControlEventEditingChanged];
    [txt_invoice addTarget:self action:@selector(textInvoiceChange:) forControlEvents:UIControlEventEditingChanged];
   // NSLog(@"%f %f %f",self.view.frame.origin.x,self.view.frame.origin.y,self.view.frame.size.height);
    
    searchedToolbar.frame=CGRectMake(0, 524, 320, 44);
    [self.view addSubview:searchedToolbar];
    UIButton *backBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 36, 21)];
    [backBtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    UIBarButtonItem *btnitem=[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    searchedToolbar.items=@[btnitem];
    [searchedToolbar setBackgroundImage:toolBarImage forToolbarPosition:UIBarPositionBottom barMetrics:UIBarMetricsDefault];
    [self addLeftMenuButtonWithImage:[UIImage imageNamed:@"menu_icon"]];
    [self addrightMenuButtonWithImage:[UIImage imageNamed:@"help"]];
    
    UISwipeGestureRecognizer *rightRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(backAction:)];
    rightRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [rightRecognizer setNumberOfTouchesRequired:1];
    [self.view addGestureRecognizer:rightRecognizer];
    
    /*
     searchResult =     (
     (
     hiteshp,
     9876890989,
     Hitesh,
     Patel,
     3,
     "4.333333333333333",
     "3.png",
     1,
     52,
     hp,
     10
     ),
     (
     hiteshp,
     9876890989,
     Hitesh,
     Patel,
     3,
     "4.333333333333333",
     "3.png",
     1,
     19,
     "The Fern",
     10
     )
     */
    _gratzeezPercentageLabel.hidden=YES;
    _gratzeezPercentageLabel.font=[UIFont fontWithName:GZFont size:13];
    // proImg.layer.cornerRadius=proImg.frame.size.height/2;
}
-(void)viewDidAppear:(BOOL)animated{
     NSLog(@"%f %f %f",self.view.frame.origin.x,self.view.frame.origin.y,self.view.frame.size.height);
}
-(IBAction)backAction:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
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

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    BOOL t=txtAmount.isEditing;
    NSLog(@"is edting %d",t);
    if(t){
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        if(newLength>6){
            return NO;
        }
    NSCharacterSet *nonNumberSet = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789."] invertedSet];
        return ([string stringByTrimmingCharactersInSet:nonNumberSet].length > 0) || [string isEqualToString:@""];
    }
    if(textField==txt_sendPercentage){
        if([textField.text integerValue]>100){
            NSString *text=textField.text;
            NSString *newString = [text substringToIndex:[text length]-1];
            textField.text=newString;
            return NO;
        }
        
        NSCharacterSet *nonNumberSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
        if([string rangeOfCharacterFromSet:nonNumberSet].location != NSNotFound){
            return ([string stringByTrimmingCharactersInSet:nonNumberSet].length > 0) || [string isEqualToString:@""];
        }
        return 1;
    }
    if(textField==txt_invoice){
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        if(newLength>6){
            return NO;
        }
        
        NSCharacterSet *nonNumberSet = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789."] invertedSet];
        if([string rangeOfCharacterFromSet:nonNumberSet].location != NSNotFound){
            return ([string stringByTrimmingCharactersInSet:nonNumberSet].length > 0) || [string isEqualToString:@""];
        }
        return 1;
    }
    else
        return 1;
    
    
}
-(void)textInvoiceChange:(id)sender{
    _gratzeezPercentageLabel.hidden=NO;
    if([[txt_sendPercentage.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0){
        return;
    }
    else{
        double mul=[txt_invoice.text doubleValue]*[txt_sendPercentage.text integerValue];
        NSString *str=[NSString stringWithFormat:@"%.2f",mul/100];
        amountOfGratZeez=[str doubleValue]*5/100;
        _gratzeezPercentageLabel.text=[NSString stringWithFormat:@"%0.2f will be deducted from your account",amountOfGratZeez+[str doubleValue]];
        _gratzeezPercentageLabel.font=[UIFont fontWithName:GZFont size:14];
        CGSize constraintSize = CGSizeMake(100, MAXFLOAT);  // Make changes in width as per your label requirement.
        
        CGRect textRect = [str boundingRectWithSize:constraintSize
                                            options:NSStringDrawingUsesLineFragmentOrigin
                                         attributes:@{NSFontAttributeName:[UIFont fontWithName:GZFont size:15]}
                                            context:nil];
        CGSize size = textRect.size;
        NSLog(@"mul %f",size.width);
        NSLog(@"string===>%@",str);
        txtAmount.text=[NSString stringWithFormat:@"%.2f",mul/100];
    }
}
-(void)textAmountChange:(id)sender{
    _gratzeezPercentageLabel.hidden=NO;
        amountOfGratZeez=[txtAmount.text doubleValue]*5/100;
    _gratzeezPercentageLabel.text=[NSString stringWithFormat:@"%0.2f will be deducted from your account",amountOfGratZeez+[txtAmount.text doubleValue]];
    _gratzeezPercentageLabel.font=[UIFont fontWithName:GZFont size:14];
    
}
- (void)textViewDidChange:(UITextView *)textView{

    if(textView==txtComment){
        NSLog(@"length%d",[textView.text length]);
        int i=[textView.text length];
        lbl_count.text=[NSString stringWithFormat:@"%d",100-i];
    }
}
-(IBAction)textFieldDidChange:(id)sender{
        _gratzeezPercentageLabel.hidden=NO;
//    double amountOfGratZeez=[txtAmount.text doubleValue]*5/100;
//    _gratzeezPercentageLabel.text=[NSString stringWithFormat:@"%0.2f will be deducted from your account",amountOfGratZeez+[txtAmount.text doubleValue]];
//    _gratzeezPercentageLabel.font=[UIFont fontWithName:GZFont size:14];
    if([txt_sendPercentage.text integerValue]>100){
    NSString *text=txt_sendPercentage.text;
    NSString *newString = [text substringToIndex:[text length]-1];
    txt_sendPercentage.text=newString;
        return;
    }
        double mul=[txt_invoice.text doubleValue]*[txt_sendPercentage.text integerValue];
NSString *str=[NSString stringWithFormat:@"%.2f",mul/100];
    amountOfGratZeez=[str doubleValue]*5/100;
    _gratzeezPercentageLabel.text=[NSString stringWithFormat:@"%0.2f will be deducted from your account",amountOfGratZeez+[str doubleValue]];
    _gratzeezPercentageLabel.font=[UIFont fontWithName:GZFont size:14];
    CGSize constraintSize = CGSizeMake(100, MAXFLOAT);  // Make changes in width as per your label requirement.
    
    CGRect textRect = [str boundingRectWithSize:constraintSize
                                         options:NSStringDrawingUsesLineFragmentOrigin
                                      attributes:@{NSFontAttributeName:[UIFont fontWithName:GZFont size:15]}
                                         context:nil];
    CGSize size = textRect.size;
        NSLog(@"mul %f",size.width);
    NSLog(@"string===>%@",str);
    txtAmount.text=[NSString stringWithFormat:@"%.2f",mul/100];
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text  isEqualToString:@"\n"]) {
        [txtComment resignFirstResponder];
        return NO;
    }
    if (textView==txtComment) {
        NSUInteger newLength = [textView.text length] + [text length] - range.length;
        return (newLength > 100) ? NO : YES;
    }
    return YES;
}

/*- (void)textFieldDidBeginEditing:(UITextField *)textField{
    BOOL t=txtComment.isEditing;
    if(!MyAppDelegate.isiPhone5){
    if(t)
    {
        self.view.center=CGPointMake(mainViewCenter.x, mainViewCenter.y-80);
    }}
    if(MyAppDelegate.isiPhone5){
        if(t){
            self.view.center=CGPointMake(mainViewCenter.x, mainViewCenter.y-100);
        }
    }
}
*/

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if(textField==txtAmount){
        txt_invoice.hidden=YES;
        txt_invoice.text=@"";
        txt_sendPercentage.text=@"";
        txt_sendPercentage.hidden=YES;
        txtAmount.text=@"";
        [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            view_invoice.frame=CGRectMake(133, 182, 55, 32);


        } completion:^(BOOL finished){
            if(finished){
             btn_calculateGratuity.hidden=NO;
            }
        }];
       
    }
    }
- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    if(textField==txt_invoice){
        txt_invoice.text=[NSString stringWithFormat:@"%0.2f",[txt_invoice.text doubleValue]];
    }
    if ([txtAmount.text length]==0) {
        _gratzeezPercentageLabel.hidden=YES;
    }
    }

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [txtAmount resignFirstResponder];
    [txtComment resignFirstResponder];
    if(textField==txt_invoice){
        [txt_invoice resignFirstResponder];
        [txt_sendPercentage becomeFirstResponder];
    }
    if(textField==txt_sendPercentage){
        [txt_sendPercentage resignFirstResponder];
    }
    return YES;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [txtAmount resignFirstResponder];
    [txtComment resignFirstResponder];
    [txt_sendPercentage resignFirstResponder];
    [txt_invoice resignFirstResponder];
    [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.view.frame=CGRectMake(0,64, self.view.frame.size.width, self.view.frame.size.height);
    } completion:^(BOOL finished){
        if(finished){
            NSLog(@"finished");
        }
    }];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)rateView:(DYRateView *)rateView changedToNewRate:(NSNumber *)rate {
        //self.rateLabel.text = [NSString stringWithFormat:@"Rate: %d", rate.intValue];
    NSLog(@"rating is%d",rate.intValue);
    rateString=[NSString stringWithFormat:@"%f",rate.floatValue];
}

-(void)viewDidDisappear:(BOOL)animated{
    txtAmount.text=@"";
    txt_invoice.text=@"";
    txt_sendPercentage.text=@"";
    txtComment.text=@"Tap Here To Comment";
    //individualRate=0;
    rateString=@"";
    _gratzeezPercentageLabel.hidden=YES;
    NSLog(@"searchedProfile did disappear.");
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    if(textView==txtComment){
        if([textView.text isEqualToString:@"Tap Here To Comment"]){
        textView.text=@"";
        }
        if(!MyAppDelegate.isiPhone5)
        
            {
                self.view.center=CGPointMake(mainViewCenter.x, mainViewCenter.y-80);
            }
        if(MyAppDelegate.isiPhone5)
            {
               // self.view.center=CGPointMake(mainViewCenter.x, mainViewCenter.y-100);
                [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    self.view.frame=CGRectMake(0, -40, self.view.frame.size.width, self.view.frame.size.height);
                } completion:^(BOOL finished){
                    if(finished){
                        NSLog(@"finished");
                    }
                }];
            }
        
    }
}
- (void)textViewDidEndEditing:(UITextView *)textView{
    if(textView==txtComment){
        if([[txtComment.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]<=0){
            txtComment.text=@"Tap Here To Comment";
            lbl_count.text=@"100";
            
        }
        [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.view.frame=CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height);
        } completion:^(BOOL finished){
            if(finished){
                NSLog(@"finished");
            }
        }];    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    

}
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if(buttonIndex==1){
        [self requestsend:TRUE];
    }
}

-(void)sendGratuityRequest{
    NSLog(@"Here");
    ASIFormDataRequest *_request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:URLRatingGratutiyComment]];
    __unsafe_unretained ASIFormDataRequest *request = _request;
    NSMutableArray *object=[[NSMutableArray alloc]init];
    NSMutableArray *key=[[NSMutableArray alloc]init];
    if([[txtAmount.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]>0){
        [object addObject:txtAmount.text];
        [key addObject:@"gratuityAmount"];
    }
    if(rateString !=NULL){
        [object addObject:rateString];
        [key addObject:@"rating"];
    }
    if(![txtComment.text isEqualToString:@"Tap Here To Comment" ] && [txtComment.text length]<=100){
        [object addObject:txtComment.text];
        [key addObject:@"comments"];
    }
    if([object count]==0){
        return;
    }
    [object addObject:[[NSUserDefaults standardUserDefaults] valueForKey:@"userid"]];
    [key addObject:@"senderId"];
    [object addObject:serviceProviderUserid];
    [key addObject:@"serviceProviderId"];
    [object addObject:organizationId];
    [key addObject:@"organizationId"];
    NSDictionary *ratingDictionary=[[NSDictionary alloc]initWithObjects:object forKeys:key];
    NSError *error;
    NSData *sendData=[NSJSONSerialization dataWithJSONObject:ratingDictionary options:NSJSONWritingPrettyPrinted error:&error];
    [request addRequestHeader:ContentType value:ContentTypeValue];
    [request appendPostData:sendData];
    NSLog(@"%@",ratingDictionary);
    [request setCompletionBlock:^{
        NSDictionary *root = [NSJSONSerialization JSONObjectWithData:[request responseData] options:0 error:nil];
        NSLog(@"Rate root%@",root);
        if([root[@"isError"] boolValue]==1){
            [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                            type:AJNotificationTypeRed
                                           title:[root objectForKey:@"message"]
                                 linedBackground:AJLinedBackgroundTypeDisabled
                                       hideAfter:GZAJNotificationDelay];
            return ;
        }
        [self.navigationController popToRootViewControllerAnimated:YES];
        [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                        type:AJNotificationTypeBlue
                                       title:[root objectForKey:@"message"]
                             linedBackground:AJLinedBackgroundTypeDisabled
                                   hideAfter:GZAJNotificationDelay];
    }];
    [request setFailedBlock:^{
        NSError *error = [request error];
        [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                        type:AJNotificationTypeRed
                                       title:error.localizedDescription
                             linedBackground:AJLinedBackgroundTypeDisabled
                                   hideAfter:GZAJNotificationDelay];
        return ;
    }];
    [request startAsynchronous];
}
-(void)requestsend:(BOOL )confirm{
    if(confirm){
        ASIFormDataRequest *_request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:URLRatingGratutiyComment]];
        __unsafe_unretained ASIFormDataRequest *request = _request;
        NSMutableArray *object=[[NSMutableArray alloc]init];
        NSMutableArray *key=[[NSMutableArray alloc]init];
        if([[txtAmount.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]>0){
            [object addObject:txtAmount.text];
            [key addObject:@"gratuityAmount"];
        }
        if(rateString !=NULL){
            [object addObject:rateString];
            [key addObject:@"rating"];
        }
        if(![txtComment.text isEqualToString:@"Tap Here To Comment" ] && [txtComment.text length]<=100){
            [object addObject:txtComment.text];
            [key addObject:@"comments"];
        }
        if([[txt_invoice.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]>0){
            [object addObject:txt_invoice.text];
            [key addObject:@"invoiceAmount"];
        }
        if([[txt_sendPercentage.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]>0){
            [object addObject:txt_sendPercentage.text];
            [key addObject:@"invoicePercentage"];
        }

        [object addObject:[[NSUserDefaults standardUserDefaults] valueForKey:@"userid"]];
        [key addObject:@"senderId"];
        [object addObject:serviceProviderUserid];
        [key addObject:@"serviceProviderId"];
        [object addObject:organizationId];
        [key addObject:@"organizationId"];
        
        [object addObject:[NSString stringWithFormat:@"%0.2f",amountOfGratZeez]];
        [key addObject:@"amountToGratZeez"];
        NSDictionary *ratingDictionary=[[NSDictionary alloc]initWithObjects:object forKeys:key];
        NSError *error;
        NSData *sendData=[NSJSONSerialization dataWithJSONObject:ratingDictionary options:NSJSONWritingPrettyPrinted error:&error];
        [request addRequestHeader:ContentType value:ContentTypeValue];
        [request appendPostData:sendData];
        NSLog(@"sent%@",ratingDictionary);
        [request setCompletionBlock:^{
            NSDictionary *root = [NSJSONSerialization JSONObjectWithData:[request responseData] options:0 error:nil];
            NSLog(@"Rate root%@",root);
            if([root[@"isError"] boolValue]==1){
                [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                                type:AJNotificationTypeRed
                                               title:[root objectForKey:@"message"]
                                     linedBackground:AJLinedBackgroundTypeDisabled
                                           hideAfter:GZAJNotificationDelay];
                return ;
            }
            if([root[@"isError"] boolValue]==0){
                InvoiceViewController *invoiceVC=[[InvoiceViewController alloc]initWithNibName:@"InvoiceViewController" bundle:nil];
                invoiceVC.receiverName=lblFirst_name.text;
                invoiceVC.gratuity=[NSString stringWithFormat:@"%0.2f",[txtAmount.text doubleValue]];
                invoiceVC.amountPaid=[NSString stringWithFormat:@"%0.2f",amountOfGratZeez+[txtAmount.text doubleValue]];
                [self.navigationController pushViewController:invoiceVC animated:YES];
            }
            //[self.navigationController popToRootViewControllerAnimated:YES];
            [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                            type:AJNotificationTypeBlue
                                           title:[root objectForKey:@"message"]
                                 linedBackground:AJLinedBackgroundTypeDisabled
                                       hideAfter:GZAJNotificationDelay];
        }];
        [request setFailedBlock:^{
            NSError *error = [request error];
            [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                            type:AJNotificationTypeRed
                                           title:error.localizedDescription
                                 linedBackground:AJLinedBackgroundTypeDisabled
                                       hideAfter:GZAJNotificationDelay];
            return ;
        }];
        [request startAsynchronous];
    }
}

- (IBAction)calculateGratuityAction:(id)sender {
    btn_calculateGratuity.hidden=YES;
    txtAmount.text=@"";
    [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        view_invoice.frame=CGRectMake(248, 182, 55, 32);
    } completion:^(BOOL finished){
        if(finished){
            txt_invoice.hidden=NO;
            txt_sendPercentage.hidden=NO;
        }
    }];
    [txtAmount resignFirstResponder];
    [txtComment resignFirstResponder];
}

- (IBAction)sendGratuity:(id)sender {
//when there is gratuity
    if([[txtAmount.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]>0){
        if ([txtAmount.text doubleValue]==0){
            [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                            type:AJNotificationTypeRed
                                           title:@"Gratuity Amount should be greater than 0"
                                 linedBackground:AJLinedBackgroundTypeDisabled
                                       hideAfter:GZAJNotificationDelay];
            return;
        }
        [confirmAlert show];
    }
    //when there is no gratuity only comment or rate.
    else{
        [self sendGratuityRequest];
    }
}

- (IBAction)addFavoriteAction:(id)sender {
    ASIFormDataRequest *_request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:URLAddAsFavorite]];
    __unsafe_unretained ASIFormDataRequest *request = _request;
    NSDictionary *favoriteDictionary=[[NSDictionary alloc]initWithObjectsAndKeys:@"true",@"isFavorite",[[NSUserDefaults standardUserDefaults] valueForKey:@"userid"],@"sender_id",serviceProviderUserid,@"service_providerId", nil];
    [request appendPostData:[[NSString stringWithFormat:@"%@",favoriteDictionary] dataUsingEncoding:NSUTF8StringEncoding]];
    NSLog(@"sent%@",favoriteDictionary);
    [request setCompletionBlock:^{
        NSDictionary *root = [NSJSONSerialization JSONObjectWithData:[request responseData] options:0 error:nil];
        NSLog(@"Rate root%@",root);
     //   [self.navigationController popToRootViewControllerAnimated:YES];
        btn_favorite.hidden=YES;
        lbl_favorite.hidden=YES;
        [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                        type:AJNotificationTypeBlue
                                       title:[root objectForKey:@"message"]
                             linedBackground:AJLinedBackgroundTypeDisabled
                                   hideAfter:GZAJNotificationDelay];
    }];
    [request setFailedBlock:^{
        NSError *error = [request error];
        [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                        type:AJNotificationTypeRed
                                       title:error.localizedDescription
                             linedBackground:AJLinedBackgroundTypeDisabled
                                   hideAfter:GZAJNotificationDelay];
        return ;
    }];
   [request startAsynchronous];
}

@end
