//
//  InviteFriendsViewController.m
//  New Handshake
//
//  Created by Mehul Prabtani on 7/9/13.
//  Copyright (c) 2013 Mehul Prabtani. All rights reserved.
//

#import "InviteFriendsViewController.h"
//#import "COPeoplePickerViewController.h"

#define COSynth(x) @synthesize x = x##_;

#define HINT_Email @"abc@xyz.com;"
#define Hint_Message @"Message Text"

@interface InviteFriendsViewController ()

@end


@implementation InviteFriendsViewController

@synthesize invite_points,inviteuserToolbar;

UITextField *txtInvitationGratuity;
UITextView *txtEmail;
UITextView *txtMessage;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])self.edgesForExtendedLayout = UIRectEdgeNone;
//    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:appDelegate.SettingsBG]]];
    [self setTitle:@"Invite New User"];
[[UIBarButtonItem appearance] setTitleTextAttributes:textAttributesTabBar forState:UIControlStateNormal];
    UIButton *btnCancel =  [UIButton buttonWithType:UIButtonTypeSystem];
    //[btnCancel setTitle:@"Cancel" forState:UIControlStateNormal];
   // btnCancel.titleLabel.font = [UIFont fontWithName:GZFont size:12.0f];
//    [btnCancel setBackgroundImage:[UIImage imageNamed:@"settings-cancel-plain.png"] forState:UIControlStateNormal];
    [btnCancel addTarget:self action:@selector(btnCancelAction) forControlEvents:UIControlEventTouchUpInside];
    [btnCancel setFrame:CGRectMake(0, 0, 55, 29)];
    NSMutableAttributedString *cancelstr = [[NSMutableAttributedString alloc] initWithString:@"Cancel"];
    [cancelstr addAttribute:NSForegroundColorAttributeName  value:[UIColor whiteColor] range:(NSRange){0,[cancelstr length]}];
    [cancelstr addAttribute:NSFontAttributeName value:[UIFont fontWithName:GZFont size:17.0f] range:(NSRange){0,[cancelstr length]}];
    [btnCancel setAttributedTitle:cancelstr forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btnCancel];

    CALayer *layer = table.layer;
    layer.shadowOffset = CGSizeMake(1, 1);
    layer.shadowColor = [[UIColor blackColor] CGColor];
    layer.shadowRadius = 1.0f;
    layer.shadowOpacity = 0.20f;
    layer.shadowPath = [[UIBezierPath bezierPathWithRect:layer.bounds] CGPath];
    UIBarButtonItem *btnHelp = [[UIBarButtonItem alloc] initWithTitle:@"Help" style:UIBarButtonItemStylePlain target:self action:@selector(btnHelpAction:)];
    self.navigationItem.rightBarButtonItem=btnHelp;
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"background_half"]];
   // NSDictionary* textAttributes = [NSDictionary dictionaryWithObject: [UIColor whiteColor]
     //                                                          forKey: NSForegroundColorAttributeName];
    [btnHelp setTitleTextAttributes:textAttributesTabBar forState:UIControlStateNormal];
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    table.backgroundColor=RGB(210, 200, 191);
    table.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    table.separatorColor=[UIColor whiteColor];
    [table setSeparatorInset:UIEdgeInsetsZero];
    
    inviteuserToolbar.frame=CGRectMake(0, 524, 320, 44);
    [self.view addSubview:inviteuserToolbar];
    UIButton *backBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 36, 21)];
    [backBtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    UIBarButtonItem *btnitem=[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    inviteuserToolbar.items=@[btnitem];
    [inviteuserToolbar setBackgroundImage:toolBarImage forToolbarPosition:UIBarPositionBottom barMetrics:UIBarMetricsDefault];
    [self addLeftMenuButtonWithImage:[UIImage imageNamed:@"menu_icon"]];
    [self addrightMenuButtonWithImage:[UIImage imageNamed:@"help"]];
    UISwipeGestureRecognizer *gesture=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(rightSwipe:)];
    gesture.direction=UISwipeGestureRecognizerDirectionRight;
    gesture.numberOfTouchesRequired=1;
    self.view.gestureRecognizers=@[gesture];
}
-(void)rightSwipe:(UISwipeGestureRecognizer*)getsureRecognizer{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [txtEmail resignFirstResponder];
    [txtInvitationGratuity resignFirstResponder];
    [txtMessage resignFirstResponder];
}
-(void)viewDidAppear:(BOOL)animated{
    NSLog(@"%f %f",self.view.frame.origin.y,self.view.frame.size.height);
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
        titleView.font = [UIFont fontWithName:@"Garamond 3 SC" size:19.0];
        titleView.textColor = [UIColor whiteColor];
        self.navigationItem.titleView = titleView;
    }
    titleView.text = title;
    [titleView sizeToFit];
}

- (void)btnCancelAction {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (IBAction)btnSendInviteAction:(id)sender {
    NSLog(@"btnSendInviteAction");
    NSString *strEmail = txtEmail.text;
	NSString *txtBody = txtMessage.text;
	strEmail = [[strEmail componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] componentsJoinedByString:@""];
	txtBody = [[txtBody componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] componentsJoinedByString:@""];
	
	
	if([txtEmail.text isEqualToString:HINT_Email] || [strEmail length] <= 0) {
        [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                        type:AJNotificationTypeRed
                                       title:@"Email cannot be blank"
                             linedBackground:AJLinedBackgroundTypeDisabled
                                   hideAfter:GZAJNotificationDelay];
	}
    else if([txtMessage.text isEqualToString:Hint_Message] || [txtBody length] <= 0) {
        [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                        type:AJNotificationTypeRed
                                       title:@"Message cannot be blank"
                             linedBackground:AJLinedBackgroundTypeDisabled
                                   hideAfter:GZAJNotificationDelay];
	}
    else {
        
		BOOL isValidEmailIds=YES;
		txtEmail.text = [[txtEmail.text componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]] componentsJoinedByString:@""];
		NSArray *listEmail = [txtEmail.text componentsSeparatedByString:@";"];
		for (int i=0; i<[listEmail count]; i++) {
			NSString *Email = [listEmail objectAtIndex:i];
			NSArray *listEmailFinal = [Email componentsSeparatedByString:@","];
			for (int j=0; j<[listEmailFinal count]; j++) {
				NSString *EmailFinal = [listEmailFinal objectAtIndex:j];
				EmailFinal = [EmailFinal stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
				if (![self emailvalidity:EmailFinal])
					isValidEmailIds=NO;
			}
		}
		
		if (!isValidEmailIds) {
            [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                            type:AJNotificationTypeRed
                                           title:@"Please enter valid email address"
                                 linedBackground:AJLinedBackgroundTypeDisabled
                                       hideAfter:GZAJNotificationDelay];
		}
        else {
			
            ASIFormDataRequest *_request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:URLInviteNewUser]];
            __unsafe_unretained ASIFormDataRequest *request = _request;
            NSArray *objects,*keys;
            if([[txtInvitationGratuity.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]>0){
                objects=[[NSArray alloc]initWithObjects:txtEmail.text,txtMessage.text,txtInvitationGratuity.text,[[NSUserDefaults standardUserDefaults] valueForKey:@"userid"], nil];
                keys=[[NSArray alloc]initWithObjects:@"email",@"message",@"gratuity",@"sender_id", nil];
            }
            else{
                objects=[[NSArray alloc]initWithObjects:txtEmail.text,txtMessage.text,[[NSUserDefaults standardUserDefaults] valueForKey:@"userid"], nil];
                keys=[[NSArray alloc]initWithObjects:@"email",@"message",@"sender_id", nil];
            }
           // NSArray *objects=[[NSArray alloc]initWithObjects:txtEmail.text,txtMessage.text, nil];
            //NSArray *keys=[[NSArray alloc]initWithObjects:@"email",@"message", nil];
            NSDictionary *emailDictionary=[[NSDictionary alloc]initWithObjects:objects forKeys:keys];
            [request appendPostData:[[NSString stringWithFormat:@"%@",emailDictionary] dataUsingEncoding:NSUTF8StringEncoding]];
            NSLog(@"EmailDictionary: %@",emailDictionary);
            //[request setPostValue:txtEmail.text forKey:@"email"];
            //[request setPostValue:txtMessage.text forKey:@"text"];
            
            [request setCompletionBlock:^{
                NSDictionary *root = [NSJSONSerialization JSONObjectWithData:[request responseData] options:0 error:nil];
                NSLog(@"URLInviteFriends ROOT: %@",root);
                if([root valueForKey:@"isError"] != [NSNull null]){
                    if([[root valueForKey:@"isError"] boolValue]==0){
                        [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                                        type:AJNotificationTypeBlue
                                                       title:[root objectForKey:@"message"]
                                             linedBackground:AJLinedBackgroundTypeDisabled
                                                   hideAfter:GZAJNotificationDelay];
                        [self.navigationController popToRootViewControllerAnimated:YES];
                    }
                    else{
                        [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                                        type:AJNotificationTypeRed
                                                       title:[root objectForKey:@"message"]
                                             linedBackground:AJLinedBackgroundTypeDisabled
                                                   hideAfter:GZAJNotificationDelay];
                    }
                }
                else{
                    [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                                    type:AJNotificationTypeRed
                                                   title:@"Server Error"
                                         linedBackground:AJLinedBackgroundTypeDisabled
                                               hideAfter:GZAJNotificationDelay];
                }
          
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

}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==0) {
        return 3;
    }
    return 0;
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row==0 || indexPath.row==2) {
        return 44.0f;
    }
    else if (indexPath.row==1) {
        return 120.0f;
    }
    return 0.0f;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            static NSString *CellIdentifier = @"Cell";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
                txtEmail = [[UITextView alloc] init];
				if (MyAppDelegate.isIpad) {
					txtEmail.frame = CGRectMake(155, 10, 540, 30);
				} else {
					txtEmail.frame = CGRectMake(100, 0, 180, 44);
				}
                
                txtEmail.text = HINT_Email;
                txtEmail.textColor = [UIColor grayColor];
                txtEmail.delegate = self;
                
				txtEmail.backgroundColor = [UIColor clearColor];
				txtEmail.autocorrectionType = UITextAutocorrectionTypeNo; // no auto correction support
				txtEmail.autocapitalizationType = UITextAutocapitalizationTypeNone; // no auto capitalization support
				txtEmail.keyboardAppearance = UIKeyboardAppearanceAlert;
				txtEmail.textAlignment = GZTextAlignmentLeft;
				txtEmail.returnKeyType = UIReturnKeyDefault;
                txtEmail.font = [UIFont fontWithName:GZFont size:12.0];
				txtEmail.tag = indexPath.row;
				txtEmail.keyboardType = UIKeyboardTypeDefault;
                
				[txtEmail sendSubviewToBack:cell];
                
                UIButton *addContactButton = [UIButton buttonWithType:UIButtonTypeCustom];
                addContactButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin;
                [addContactButton setImage:[UIImage imageNamed:@"plus"] forState:UIControlStateNormal];
                [addContactButton addTarget:self action:@selector(addContact:) forControlEvents:UIControlEventTouchUpInside];
                addContactButton.frame = CGRectMake(270, 7, 30, 30);
                [cell addSubview:addContactButton];
                [cell addSubview:txtEmail];
                
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.font = [UIFont fontWithName:GZFont size:14.0f];
            cell.textLabel.text = @"Emails:";
            cell.backgroundColor=RGB(210, 200, 191);
            return cell;
        }
        else if (indexPath.row==1) {
            static NSString *CellIdentifier = @"CellUsername";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
                txtMessage = [[UITextView alloc] init];
                if (MyAppDelegate.isIpad) {
                    txtMessage.frame = CGRectMake(155, 10, 540, 30);
                } else {
                    txtMessage.frame = CGRectMake(90, 0, 230, 120);
                }
                txtMessage.text = @"Hey \n\nI was recommended this cool App";
                txtMessage.textColor = [UIColor grayColor];
                txtMessage.delegate = self;
                
                txtMessage.backgroundColor = [UIColor clearColor];
                txtMessage.autocorrectionType = UITextAutocorrectionTypeNo; // no auto correction support
                txtMessage.autocapitalizationType = UITextAutocapitalizationTypeNone; // no auto capitalization support
                txtMessage.keyboardAppearance = UIKeyboardAppearanceAlert;
                txtMessage.textAlignment = GZTextAlignmentLeft;
                txtMessage.returnKeyType = UIReturnKeyDefault;
                txtMessage.font = [UIFont fontWithName:GZFont size:12.0];
                txtMessage.tag = indexPath.row;
                txtMessage.keyboardType = UIKeyboardTypeDefault;
                
                [cell addSubview:txtMessage];
            }
            
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor=RGB(210, 200, 191);
            UILabel *lblMessage = [[UILabel alloc] init];
            lblMessage.numberOfLines = 10;
            lblMessage.backgroundColor = [UIColor clearColor];
            lblMessage.text = @"Message:";
            lblMessage.font = [UIFont fontWithName:GZFont size:14.0];
            lblMessage.frame = CGRectMake(10,5,100,30);
            [cell addSubview:lblMessage];
            
            return cell;
        }
        else if (indexPath.row==2) {
            static NSString *CellIdentifier = @"CellInvitationGratuity";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
                
                txtInvitationGratuity = [[UITextField alloc] init];
                if (MyAppDelegate.isIpad) {
                    txtInvitationGratuity.frame = CGRectMake(155, 10, 540, 30);
                } else {
                    txtInvitationGratuity.frame = CGRectMake(220, 10, 80, 30);
                }
                
                txtInvitationGratuity.adjustsFontSizeToFitWidth = YES;
                txtInvitationGratuity.textColor = [UIColor blackColor];
                txtInvitationGratuity.delegate = self;
                
                //txtInvitationGratuity.background=[UIImage imageNamed:@"dollar_box"];
                txtInvitationGratuity.backgroundColor=RGB(196, 179, 169);
                txtInvitationGratuity.autocorrectionType = UITextAutocorrectionTypeNo; // no auto correction support
                txtInvitationGratuity.autocapitalizationType = UITextAutocapitalizationTypeWords; // no auto capitalization support
                txtInvitationGratuity.keyboardAppearance = UIKeyboardAppearanceAlert;
                txtInvitationGratuity.textAlignment = GZTextAlignmentLeft;
                txtInvitationGratuity.clearButtonMode = UITextFieldViewModeWhileEditing; // no clear 'x' button to the right
                txtInvitationGratuity.returnKeyType = UIReturnKeyNext;
                txtInvitationGratuity.font = [UIFont fontWithName:GZFont size:12.0];
                txtInvitationGratuity.enabled=YES;
                txtInvitationGratuity.placeholder=@"$";
                txtInvitationGratuity.tag = indexPath.row;
                txtInvitationGratuity.tintColor=[UIColor blackColor];
                txtInvitationGratuity.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
                txtInvitationGratuity.borderStyle=UITextBorderStyleNone;
                txtInvitationGratuity.keyboardType = UIKeyboardTypeNumberPad;
                //txtInvitationGratuity.inputAccessoryView = keybordtoolbar;
                
                [cell addSubview:txtInvitationGratuity];
            }
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.textLabel.font = [UIFont fontWithName:GZFont size:16.0];
            cell.textLabel.numberOfLines = 10;
            cell.textLabel.text = @"Send Gratuity with Invite";
            cell.textLabel.textColor=[UIColor whiteColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor=RGB(131, 99, 74);
            return cell;
        }
    }
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *v=[[UIView alloc]init];
    v.backgroundColor=RGB(131, 99, 74);
    return v;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            
//            COPeoplePickerViewController *picker = [COPeoplePickerViewController new];
//            [picker setDelegate:self];
//            picker.displayedProperties = [NSArray arrayWithObject:[NSNumber numberWithInteger:kABPersonEmailProperty]];
//            [self.navigationController pushViewController:picker animated:YES];

        }
    }
}
- (void)addContact:(id)sender {
    ABPeoplePickerNavigationController *picker = [ABPeoplePickerNavigationController new];
    picker.peoplePickerDelegate = self;
    
//    UIColor *tintColor = self.navigationController.navigationBar.tintColor;
//    if (tintColor != nil) picker.navigationBar.tintColor = tintColor;
    
    [self presentViewController:picker animated:YES completion:^{
    }];
}

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person {
    return YES;
}
- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier {
//    ABMutableMultiValueRef multi = ABRecordCopyValue(person, kABPersonEmailProperty);
//    NSString *email = CFBridgingRelease(ABMultiValueCopyValueAtIndex(multi, identifier));
//    CFRelease(multi);

//    if ([txtEmail.text length]>0 && ![txtEmail.text isEqualToString:HINT_Email]) {
//        txtEmail.textColor = [UIColor blackColor];
//        txtEmail.text = [NSString stringWithFormat:@"%@;%@",txtEmail.text,email];
//    } else {
//        txtEmail.textColor = [UIColor blackColor];
//        txtEmail.text = [NSString stringWithFormat:@"%@",email];
//        
//   }
//    
//    [self dismissViewControllerAnimated:YES completion:^{
//        
//    }];
//    
//    return NO;
    
//    ABMultiValueRef  emails = ABRecordCopyValue(person, kABPersonEmailProperty);
//    NSString *emailId = (NSString *)CFBridgingRelease(ABMultiValueCopyValueAtIndex(emails, 0));//0 for "Home Email" and 1 for "Work Email".
//    NSLog(@"Email:: %@",emailId);
    ABMultiValueRef emails = ABRecordCopyValue(person, kABPersonEmailProperty);
    
    //6
    NSUInteger j = 0;
    NSString *h,*w;
    for (j = 0; j < ABMultiValueGetCount(emails); j++) {
        NSString *email = (__bridge_transfer NSString *)ABMultiValueCopyValueAtIndex(emails, j);
        if (j == 0) {
           h = email;
          //  NSLog(@"person.homeEmail = %@ ", e);
        }
        else if (j==1) w = email;
    }
    NSLog(@"person.homeEmail = %@ %@", w,h);
    if([h length]==0 && [w length]==0){
        txtEmail.text=@"";
        NSLog(@"break");
    }
    else if ([h length]!=0 && [w length]==0){
        txtEmail.text=h;
    }
    else if ([w length]!=0 && [h length]==0){
        txtEmail.text=w;
    }
   else if([h isEqualToString:w]){
        txtEmail.text=h;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
    return NO;
}
- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker {
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    //	NSUInteger newLength = [textView.text length] + [text length] - range.length;
//	if ([text isEqualToString: @"\n"]) {
//		[textView resignFirstResponder];
//		return NO;
//	}
	return YES;
}
- (void)textViewDidBeginEditing:(UITextView *)textView {
    UIButton *btnDone =  [UIButton buttonWithType:UIButtonTypeSystem];
    //[btnDone setTitle:@"Done" forState:UIControlStateNormal];
    //btnDone.titleLabel.font = [UIFont fontWithName:GZFont size:12.0f];
//    [btnDone setBackgroundImage:[UIImage imageNamed:@"settings-cancel-plain.png"] forState:UIControlStateNormal];
    [btnDone addTarget:self action:@selector(btnDoneAction:) forControlEvents:UIControlEventTouchUpInside];
    [btnDone setFrame:CGRectMake(0, 0, 55, 30)];
    NSMutableAttributedString *cancelstr = [[NSMutableAttributedString alloc] initWithString:@"Done"];
    [cancelstr addAttribute:NSForegroundColorAttributeName  value:[UIColor whiteColor] range:(NSRange){0,[cancelstr length]}];
    [cancelstr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Garamond 3 SC" size:17.0f] range:(NSRange){0,[cancelstr length]}];
    [btnDone setAttributedTitle:cancelstr forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btnDone];
    
	if (textView==txtEmail) {
		if ([txtEmail.text isEqualToString:HINT_Email])txtEmail.text = @"";
        txtEmail.textColor = [UIColor blackColor];
	}
    else if (textView==txtMessage) {
		if ([txtMessage.text isEqualToString:Hint_Message])txtMessage.text =@"";
        txtMessage.textColor = [UIColor blackColor];
    }
    
    
    
//	textView.autocapitalizationType = UITextAutocapitalizationTypeWords;
}
- (void)textViewDidEndEditing:(UITextView *)textView {
	if (textView==txtEmail) {
		if ([txtEmail.text length]<=0)txtEmail.text = HINT_Email;
        txtEmail.textColor = [UIColor grayColor];
	}
    else if (textView==txtMessage) {
		if ([txtMessage.text length]<=0)txtMessage.text = Hint_Message;
        txtMessage.textColor = [UIColor grayColor];
    }
    
    
}



- (void)textFieldDidBeginEditing:(UITextField *)textField {
    UIButton *btnDone =  [UIButton buttonWithType:UIButtonTypeSystem];
//    [btnDone setTitle:@"Done" forState:UIControlStateNormal];
//    btnDone.titleLabel.font = [UIFont fontWithName:GZFont size:12.0f];
    NSMutableAttributedString *cancelstr = [[NSMutableAttributedString alloc] initWithString:@"Done"];
    [cancelstr addAttribute:NSForegroundColorAttributeName  value:[UIColor whiteColor] range:(NSRange){0,[cancelstr length]}];
    [cancelstr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Garamond 3 SC" size:17.0f] range:(NSRange){0,[cancelstr length]}];
    [btnDone setAttributedTitle:cancelstr forState:UIControlStateNormal];
    //    [btnDone setBackgroundImage:[UIImage imageNamed:@"settings-cancel-plain.png"] forState:UIControlStateNormal];
    [btnDone addTarget:self action:@selector(btnDoneAction:) forControlEvents:UIControlEventTouchUpInside];
    [btnDone setFrame:CGRectMake(0, 0, 55, 29)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btnDone];
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
	
	//	return (newLength > 3) ? NO : YES;
   /* if (textField==txtInvitationGratuity && newLength>5) {
        NSCharacterSet *nonNumberSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
        if([string rangeOfCharacterFromSet:nonNumberSet].location != NSNotFound){
            [string stringByTrimmingCharactersInSet:nonNumberSet];}
       // [txtInvitationGratuity.text stringByReplacingOccurrencesOfString:nonNumberSet withString:@""];
        return NO;
    } */
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    if(textField==txtInvitationGratuity){
        if(newLength>5){
            return NO;
        }
        
        NSCharacterSet *nonNumberSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
        if([string rangeOfCharacterFromSet:nonNumberSet].location != NSNotFound){
            return ([string stringByTrimmingCharactersInSet:nonNumberSet].length > 0) || [string isEqualToString:@""];
        }
        
    }
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    return YES;
}



- (BOOL)emailvalidity:(NSString *)emailString {
	NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
	NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
	return [emailTest evaluateWithObject:emailString];
}

- (void)btnDoneAction:(id)sender {
    self.navigationItem.rightBarButtonItem = nil;
    [txtEmail resignFirstResponder];
    [txtMessage resignFirstResponder];
    [txtInvitationGratuity resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end



