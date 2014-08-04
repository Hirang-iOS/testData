//
//  ForgetPasswordController.m
//  GratZeez
//
//  Created by cloudZon Infosoft on 15/11/13.
//  Copyright (c) 2013 cloudZon Infosoft. All rights reserved.
//

#import "ForgetPasswordController.h"

@interface ForgetPasswordController ()

@end

@implementation ForgetPasswordController

UITextField *txtUserName;
UITextField *txtEmailID;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"Forget Password";
    //[tableview setUserInteractionEnabled:YES];
    self.view.backgroundColor=RGB(210, 200, 191);
    tableview.backgroundColor=RGB(210, 200, 191);
	//UIBarButtonItem *btnSubmit = [[UIBarButtonItem alloc] initWithTitle:@"Submit" style:UIBarButtonItemStylePlain target:self action:@selector(btnSubmitAction:)];
	//navItem.rightBarButtonItem = btnSubmit;
    
    UIButton *btnCancel =  [UIButton buttonWithType:UIButtonTypeSystem]; //UIButtonTypeCustom for image button
  //  [btnCancel setTitle:@"Cancel" forState:UIControlStateNormal];
    //btnCancel.titleLabel.font = [UIFont fontWithName:GZFont size:12.0f];
    //    [btnCancel setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [btnCancel addTarget:self action:@selector(btnCancelAction) forControlEvents:UIControlEventTouchUpInside];
    [btnCancel setFrame:CGRectMake(0, 0, 55, 29)];
    NSMutableAttributedString *cancelButton = [[NSMutableAttributedString alloc] initWithString:@"Cancel"];
    [cancelButton addAttribute:NSForegroundColorAttributeName  value:[UIColor whiteColor] range:(NSRange){0,[cancelButton length]}];

    [cancelButton addAttribute:NSFontAttributeName value:[UIFont fontWithName:GZFont size:17.0f] range:(NSRange){0,[cancelButton length]}];
    [btnCancel setAttributedTitle:cancelButton forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btnCancel];
    
    UIButton *btnSave =  [UIButton buttonWithType:UIButtonTypeSystem]; //UIButtonTypeCustom for image button
   // [btnSave setTitle:@"Save" forState:UIControlStateNormal];
    //btnSave.titleLabel.font = [UIFont fontWithName:GZFont size:12.0f];
    //    [btnSave setImage:[UIImage imageNamed:@"save.png"] forState:UIControlStateNormal];
    [btnSave addTarget:self action:@selector(btnSubmitAction:) forControlEvents:UIControlEventTouchUpInside];
    [btnSave setFrame:CGRectMake(0, 0, 55, 29)];
    NSMutableAttributedString *saveButton = [[NSMutableAttributedString alloc] initWithString:@"Done"];
    [saveButton addAttribute:NSForegroundColorAttributeName  value:[UIColor whiteColor] range:(NSRange){0,[saveButton length]}];
    
    [saveButton addAttribute:NSFontAttributeName value:[UIFont fontWithName:GZFont size:17.0f] range:(NSRange){0,[saveButton length]}];
    [btnSave setAttributedTitle:saveButton forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btnSave];
    NSArray *ver = [[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."];
    if ([[ver objectAtIndex:0] intValue] >= 7) {
        self.navigationController.navigationBar.barTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"top_bar"]];
        self.navigationController.navigationBar.translucent = NO;
    } else {
        self.navigationController.navigationBar.barTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"top_bar"]];
    }
    [[UIBarButtonItem appearance] setTitleTextAttributes:textAttributesTabBar forState:UIControlStateNormal];
}
/*-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"tableview touched");
    [txtUserName resignFirstResponder];
    [txtEmailID resignFirstResponder];
} */
- (void)setTitle:(NSString *)title {
    //    [super setTitle:title];
    UILabel *titleView = (UILabel *)self.navigationItem.titleView;
    if (!titleView) {
        titleView = [[UILabel alloc] initWithFrame:CGRectZero];
        titleView.backgroundColor = [UIColor clearColor];
        titleView.font = [UIFont fontWithName:GZFont size:18.0];
        titleView.textColor = [UIColor whiteColor];
        self.navigationItem.titleView = titleView;
    }
    titleView.text = title;
    [titleView sizeToFit];
}

- (void)btnCancelAction {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)btnSubmitAction:(id)sender {
    if ([txtUserName.text length]>0) {
        [self sendForgotAction];
    }
    else if ([txtEmailID.text length]>0) {
        if (![self emailvalidity:txtEmailID.text]) {
            [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                            type:AJNotificationTypeRed
                                           title:@"Invalid email address"
                                 linedBackground:AJLinedBackgroundTypeDisabled
                                       hideAfter:GZAJNotificationDelay];
        }
        else {
            [self sendForgotAction];
        }
    }
    else {
        [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                        type:AJNotificationTypeRed
                                       title:@"Username or Email required"
                             linedBackground:AJLinedBackgroundTypeDisabled
                                   hideAfter:GZAJNotificationDelay];
    }
}
- (void)sendForgotAction {
    
    ASIFormDataRequest *_request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:URLForgetID]];
    __unsafe_unretained ASIFormDataRequest *request = _request;
    //    NSMutableArray *object=[[NSMutableArray alloc]init];
    //    NSMutableArray  *key=[[NSMutableArray alloc]init];
    //    if([txtEmailID.text length]>0){
    //        [object addObject:txtEmailID.text];
    //        [key addObject:@"email"];
    //    }
    //    if([txtUserName.text length]>0){
    //        [object addObject:txtUserName.text];
    //        [key addObject:@"username"];
    //    }
    NSArray *object,*key;
    if([txtEmailID.text length]>0){
        object=[NSArray arrayWithObject:txtEmailID.text];
        key=[NSArray arrayWithObject:@"email"];
    }
    else if([txtUserName.text length]>0){
        object=[NSArray arrayWithObject:txtUserName.text];
        key=[NSArray arrayWithObject:@"user_name"];
    }
    //    NSArray *object=[NSArray arrayWithObjects:txtUserName.text,txtEmailID.text,nil];
    //    NSArray *key=[NSArray arrayWithObjects:@"username",@"email", nil];
    
    NSDictionary *forgetPasswordDictionary = [NSDictionary dictionaryWithObjects:object forKeys:key];
    [request appendPostData:[[NSString stringWithFormat:@"%@",forgetPasswordDictionary] dataUsingEncoding:NSUTF8StringEncoding]];
    NSLog(@"forgetPasswordDictionary: %@",forgetPasswordDictionary);
    
    
    [request setDelegate:self];
    [request setCompletionBlock:^{
        NSDictionary *root = [NSJSONSerialization JSONObjectWithData:request.responseData options:0 error:nil];
        NSLog(@"ROOT: %@",root);
        if ([root objectForKey:@"isError"] != [NSNull null]) {
            if (![[root objectForKey:@"isError"] boolValue]) {
                [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                                type:AJNotificationTypeBlue
                                               title:[root objectForKey:@"message"]
                                     linedBackground:AJLinedBackgroundTypeDisabled
                                           hideAfter:GZAJNotificationDelay];
                [self.navigationController popViewControllerAnimated:YES];
            } else {
                [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                                type:AJNotificationTypeRed
                                               title:[root objectForKey:@"message"]
                                     linedBackground:AJLinedBackgroundTypeDisabled
                                           hideAfter:GZAJNotificationDelay];
            }
        }
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

#pragma tableview

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.section==0) {
		static NSString *CellIdentifier = @"CellUsername";
		UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
		if (cell == nil) {
			cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
			cell.backgroundColor=RGB(210, 200, 191);
			txtUserName = [[UITextField alloc] init];
			if (MyAppDelegate.isIpad) {
				txtUserName.frame = CGRectMake(155, 10, 540, 30);
			} else {
				txtUserName.frame = CGRectMake(125, 10, 170, 30);
			}
			
			txtUserName.adjustsFontSizeToFitWidth = YES;
			txtUserName.textColor = [UIColor blackColor];
			txtUserName.delegate = self;
			
			txtUserName.backgroundColor = [UIColor clearColor];
			txtUserName.autocorrectionType = UITextAutocorrectionTypeNo; // no auto correction support
			txtUserName.autocapitalizationType = UITextAutocapitalizationTypeWords; // no auto capitalization support
			txtUserName.keyboardAppearance = UIKeyboardAppearanceAlert;
			txtUserName.textAlignment = GZTextAlignmentRight;
			txtUserName.clearButtonMode = UITextFieldViewModeWhileEditing; // no clear 'x' button to the right
			txtUserName.returnKeyType = UIReturnKeyDone;
			txtUserName.enabled=YES;
			txtUserName.placeholder=@"username";
			txtUserName.tag = indexPath.row;
			txtUserName.text = @"";
            txtUserName.font = [UIFont fontWithName:GZFont size:14.0];
			
			[cell addSubview:txtUserName];
		}
		cell.accessoryType = UITableViewCellAccessoryNone;
		cell.textLabel.numberOfLines = 10;
		cell.textLabel.text = @"Username";
        cell.textLabel.font = [UIFont fontWithName:GZFont size:16.0];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
		
		return cell;
	}
    else if (indexPath.section==1) {
		static NSString *CellIdentifier = @"CellLastName";
		UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		if (cell == nil) {
			cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
			cell.backgroundColor=RGB(210, 200, 191);
			txtEmailID = [[UITextField alloc] init];
			if (MyAppDelegate.isIpad) {
				txtEmailID.frame = CGRectMake(155, 10, 540, 30);
			} else {
				txtEmailID.frame = CGRectMake(125, 10, 170, 30);
			}
			
			txtEmailID.adjustsFontSizeToFitWidth = YES;
			txtEmailID.textColor = [UIColor blackColor];
			txtEmailID.delegate = self;
			
			txtEmailID.backgroundColor = [UIColor clearColor];
			txtEmailID.autocorrectionType = UITextAutocorrectionTypeNo; // no auto correction support
			txtEmailID.autocapitalizationType = UITextAutocapitalizationTypeWords; // no auto capitalization support
			txtEmailID.keyboardAppearance = UIKeyboardAppearanceAlert;
			txtEmailID.textAlignment = GZTextAlignmentRight;
			txtEmailID.clearButtonMode = UITextFieldViewModeWhileEditing; // no clear 'x' button to the right
			txtEmailID.returnKeyType = UIReturnKeyDone;
			txtEmailID.enabled=YES;
			txtEmailID.placeholder=@"example@email.com";
			txtEmailID.tag = indexPath.row;
			txtEmailID.text = @"";
			txtEmailID.keyboardType = UIKeyboardTypeEmailAddress;
			txtEmailID.font = [UIFont fontWithName:GZFont size:14.0];
            
			[cell addSubview:txtEmailID];
		}
		cell.accessoryType = UITableViewCellAccessoryNone;
		cell.textLabel.numberOfLines = 10;
		cell.textLabel.text = @"Email";
        cell.textLabel.font = [UIFont fontWithName:GZFont size:16.0];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		
		return cell;
	}
    return nil;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section==1) {
        return 40;
    }
    return 0;
}
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section==1) {
        UILabel *header = [[UILabel alloc] initWithFrame:[tableView frame]];
        header.backgroundColor = [UIColor clearColor];
        header.font = [UIFont fontWithName:GZFont size:16.0];
        header.lineBreakMode = GZLineBreakModeWordWrap;
        header.textAlignment = GZTextAlignmentCenter;
        header.numberOfLines = 10;
        header.textColor = [UIColor lightGrayColor]; //[UIColor colorWithRed:39/255.0 green:170/255.0 blue:225/255.0 alpha:1.0];
        header.text = @"or";
        return header;
    }
    return nil;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
	NSIndexPath *indexPath = [tableview indexPathForCell:(UITableViewCell*)[textField superview]];
	[tableview scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    if([txtUserName.text length]>0 ){
        [txtEmailID setUserInteractionEnabled:NO];
    }
    if([txtUserName.text length]<=0){
        [txtEmailID setUserInteractionEnabled:YES];
    }
    if([txtEmailID.text length]>0){
        [txtUserName setUserInteractionEnabled:NO];
    }
    if ([txtEmailID.text length]<=0) {
        [txtUserName setUserInteractionEnabled:YES];
    }
    if([txtUserName isEditing]){
        [txtEmailID setUserInteractionEnabled:NO];
    }
    else{
        [txtUserName setUserInteractionEnabled:NO];
    }
    //    if([txtUserName isEditing]){
    //        [txtEmailID setUserInteractionEnabled:NO];
    //    }
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    if ([txtUserName.text length]>0) {
        [txtEmailID setUserInteractionEnabled:NO];
    }
    if([txtUserName.text length]<=0){
        [txtEmailID setUserInteractionEnabled:YES];
    }if([txtEmailID.text length]>0){
        [txtUserName setUserInteractionEnabled:NO];
    }
    if ([txtEmailID.text length]<=0) {
        [txtUserName setUserInteractionEnabled:YES];
    }
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
	NSUInteger newLength = [textField.text length] + [string length] - range.length;
	//	return (newLength > 3) ? NO : YES;
	
	if (textField==txtUserName && newLength >20) {
		return NO;
	} else if (textField==txtEmailID && newLength >50) {
		return NO;
	}
	return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	
	int currentSection = [[tableview indexPathForCell:(UITableViewCell*)[textField superview]] section];
	
	NSInteger nextTag = textField.tag + 1;
	NSIndexPath *indexPath = [NSIndexPath indexPathForRow:nextTag inSection:currentSection];
	
	int returnType = [textField	returnKeyType];
	if (returnType==UIReturnKeyDone) {
		[textField resignFirstResponder];
		//[self performSelector:@selector(SubmitAction:)];
		return YES;
	} else {
		[tableview scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
		UITableViewCell *cell = [tableview cellForRowAtIndexPath:indexPath];
		UIResponder *nextResponder = [cell viewWithTag:nextTag];
		
		if (nextResponder) {
			[nextResponder becomeFirstResponder];
		} else {
			[textField resignFirstResponder];
		}
		return YES;
	}
}


- (BOOL)emailvalidity:(NSString *)emailString {
	
	NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
	NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
	
	return [emailTest evaluateWithObject:emailString];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
