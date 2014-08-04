//
//  ChangePasswordViewController.m
//  GratZeez
//
//  Created by cloudZon Infosoft on 18/10/13.
//  Copyright (c) 2013 cloudZon Infosoft. All rights reserved.
//

#import "ChangePasswordViewController.h"

@interface ChangePasswordViewController ()

@end

@implementation ChangePasswordViewController
@synthesize changePassToolbar;
UITextField *txtOldPassword;
UITextField *txtNewPassword;
UITextField *txtCnfPassword;
UIButton *btnSubmit;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [txtCnfPassword resignFirstResponder];
    [txtNewPassword resignFirstResponder];
    [txtOldPassword resignFirstResponder];
}
- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"Change Password";
    NSLog(@"%f %f %f %f",self.view.frame.origin.x,self.view.frame.origin.y,self.view.frame.size.width,self.view.frame.size.height);
    
	
    self.edgesForExtendedLayout=UIRectEdgeNone;


    
    btnSubmit =  [UIButton buttonWithType:UIButtonTypeSystem]; //UIButtonTypeCustom for image button
    [btnSubmit setTitle:@"Save" forState:UIControlStateNormal];
    btnSubmit.titleLabel.font = [UIFont fontWithName:GZFont size:18.0f];
    [btnSubmit addTarget:self action:@selector(btnSubmitAction:) forControlEvents:UIControlEventTouchUpInside];
    [btnSubmit setFrame:CGRectMake(0, 0, 55, 29)];
    [btnSubmit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [[UIBarButtonItem appearance] setTitleTextAttributes:textAttributesTabBar forState:UIControlStateNormal];
    
    changePassToolbar.frame=CGRectMake(0,524, 320, 44);
    [self.view addSubview:changePassToolbar];
    UIButton *backBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 36, 21)];
    [backBtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    UIBarButtonItem *btnitem=[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    changePassToolbar.items=@[btnitem];
    [changePassToolbar setBackgroundImage:toolBarImage forToolbarPosition:UIBarPositionBottom barMetrics:UIBarMetricsDefault];
    NSLog(@"view%f %f tab%f %f",self.view.frame.size.height,self.view.frame.origin.y,changePassToolbar.frame.size.height,changePassToolbar.frame.origin.y);
    [self addLeftMenuButtonWithImage:[UIImage imageNamed:@"menu_icon"]];
    [self addrightMenuButtonWithImage:[UIImage imageNamed:@"help"]];
    UISwipeGestureRecognizer *rightRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(backAction:)];
    rightRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [rightRecognizer setNumberOfTouchesRequired:1];
    [self.view addGestureRecognizer:rightRecognizer];
    
}
-(void)viewDidAppear:(BOOL)animated{
    NSLog(@"view%f %f tab%f %f",self.view.frame.size.height,self.view.frame.origin.y,changePassToolbar.frame.size.height,changePassToolbar.frame.origin.y);
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

- (IBAction)backAction:(id)sender{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (IBAction)btnSubmitAction:(id)sender {
	if ([txtOldPassword.text length]<=0 || [txtNewPassword.text length]<=0 || [txtCnfPassword.text length]<=0) {
        [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                        type:AJNotificationTypeRed
                                       title:@"All fields are mandatory"
                             linedBackground:AJLinedBackgroundTypeAnimated
                                   hideAfter:GZAJNotificationDelay];
	}
    else if([txtNewPassword.text length]< 6 || [txtNewPassword.text length]>20) {
        [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                        type:AJNotificationTypeRed
                                       title:@"Password must be between 6 to 20 characters"
                             linedBackground:AJLinedBackgroundTypeAnimated
                                   hideAfter:GZAJNotificationDelay];
        
    }
    else if (![self isFoundSpecialCharacter:txtNewPassword.text]) {
        [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                        type:AJNotificationTypeRed
                                       title:@"Password must contain one special character."
                             linedBackground:AJLinedBackgroundTypeAnimated
                                   hideAfter:GZAJNotificationDelay];
    }
    else if (![txtNewPassword.text isEqualToString:txtCnfPassword.text]) {
        [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                        type:AJNotificationTypeRed
                                       title:@"Password does not match"
                             linedBackground:AJLinedBackgroundTypeAnimated
                                   hideAfter:GZAJNotificationDelay];
	}
    else {
        
        ASIFormDataRequest *_request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:URLChangePassword]];
        __unsafe_unretained ASIFormDataRequest *request = _request;
        
        [request setDelegate:self];
        
//        NSArray *objects = [NSArray arrayWithObjects:
//                            [[NSUserDefaults standardUserDefaults] objectForKey:@"userid"],
//                            [MyAppDelegate md5HexDigest:txtOldPassword.text],
//                            [MyAppDelegate md5HexDigest:txtNewPassword.text],nil];
        NSArray *objects = [NSArray arrayWithObjects:
                            [[NSUserDefaults standardUserDefaults] objectForKey:@"userid"],
                            txtOldPassword.text,
                            txtNewPassword.text,nil];
        
        NSArray *keys = [NSArray arrayWithObjects:
                         @"userid",
                         @"current_password",
                         @"new_password", nil];
        
        NSLog(@"--------------: %@",URLChangePassword);
        
        NSDictionary *changePasswordDictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
        [request appendPostData:[[NSString stringWithFormat:@"%@",changePasswordDictionary] dataUsingEncoding:NSUTF8StringEncoding]];
        NSLog(@"changePasswordDictionary: %@",changePasswordDictionary);

        
        [request setCompletionBlock:^{
            NSDictionary *root = [NSJSONSerialization JSONObjectWithData:request.responseData options:0 error:nil];
            NSLog(@"URLChangePassword: %@",root);
            if ([root objectForKey:@"isError"] != [NSNull null]) {
                if (![[root objectForKey:@"isError"] boolValue]) {
                    
                    [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                                    type:AJNotificationTypeBlue
                                                   title:[root objectForKey:@"message"]
                                         linedBackground:AJLinedBackgroundTypeDisabled
                                               hideAfter:GZAJNotificationDelay];
                    
                    [[NSUserDefaults standardUserDefaults] setValue:txtNewPassword.text forKey:@"password"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    
                    [self.navigationController popViewControllerAnimated:YES];
                    
                }
                else {
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


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    tableView.backgroundColor=RGB(198,181,171);
    tableView.separatorInset=UIEdgeInsetsZero;
	if (indexPath.section==0) {
		if (indexPath.row==0) {
			static NSString *CellIdentifier = @"CellOPassword";
			UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
			if (cell == nil) {
				cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
				cell.backgroundColor=RGB(210, 200, 191);
                txtOldPassword = [[UITextField alloc] init];
				if (MyAppDelegate.isIpad) {
					txtOldPassword.frame = CGRectMake(155, 10, 540, 30);
				} else {
					txtOldPassword.frame = CGRectMake(125, 10, 170, 30);
				}
				
				txtOldPassword.adjustsFontSizeToFitWidth = YES;
				txtOldPassword.textColor = [UIColor blackColor];
				txtOldPassword.delegate = self;
				
				txtOldPassword.backgroundColor = [UIColor clearColor];
				txtOldPassword.autocorrectionType = UITextAutocorrectionTypeNo; // no auto correction support
				txtOldPassword.autocapitalizationType = UITextAutocapitalizationTypeWords; // no auto capitalization support
				txtOldPassword.keyboardAppearance = UIKeyboardAppearanceAlert;
				txtOldPassword.textAlignment = GZTextAlignmentRight;
				txtOldPassword.clearButtonMode = UITextFieldViewModeWhileEditing; // no clear 'x' button to the right
				txtOldPassword.returnKeyType = UIReturnKeyNext;
				txtOldPassword.enabled=YES;
				txtOldPassword.placeholder=@"Current Password";
				txtOldPassword.tag = indexPath.row;
				txtOldPassword.text = @"";
                txtOldPassword.font = [UIFont fontWithName:GZFont size:12.0];
				txtOldPassword.secureTextEntry = YES;
				txtOldPassword.keyboardType = UIKeyboardTypeDefault;
				
				
				[cell addSubview:txtOldPassword];
			}
			cell.accessoryType = UITableViewCellAccessoryNone;
			cell.textLabel.numberOfLines = 10;
			cell.textLabel.text = @"Current*";
            cell.textLabel.font = [UIFont fontWithName:GZFont size:16.0];
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
			
			return cell;
		}
		else if (indexPath.row==1) {
			static NSString *CellIdentifier = @"CellNPassword";
			UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
			if (cell == nil) {
				cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
                cell.backgroundColor=RGB(210, 200, 191);
                txtNewPassword = [[UITextField alloc] init];
				if (MyAppDelegate.isIpad) {
					txtNewPassword.frame = CGRectMake(155, 10, 540, 30);
				} else {
					txtNewPassword.frame = CGRectMake(125, 10, 170, 30);
				}
				
				txtNewPassword.adjustsFontSizeToFitWidth = YES;
				txtNewPassword.textColor = [UIColor blackColor];
				txtNewPassword.delegate = self;
				
				txtNewPassword.backgroundColor = [UIColor clearColor];
				txtNewPassword.autocorrectionType = UITextAutocorrectionTypeNo; // no auto correction support
				txtNewPassword.autocapitalizationType = UITextAutocapitalizationTypeWords; // no auto capitalization support
				txtNewPassword.keyboardAppearance = UIKeyboardAppearanceAlert;
				txtNewPassword.textAlignment = GZTextAlignmentRight;
				txtNewPassword.clearButtonMode = UITextFieldViewModeWhileEditing; // no clear 'x' button to the right
				txtNewPassword.returnKeyType = UIReturnKeyNext;
				txtNewPassword.enabled=YES;
				txtNewPassword.placeholder=@"6-20 char. incl. one symbol";
				txtNewPassword.tag = indexPath.row;
				txtNewPassword.text = @"";
                txtNewPassword.font = [UIFont fontWithName:GZFont size:12.0];
				txtNewPassword.secureTextEntry = YES;
				txtNewPassword.keyboardType = UIKeyboardTypeDefault;
				
				[cell addSubview:txtNewPassword];
			}
			cell.accessoryType = UITableViewCellAccessoryNone;
			cell.textLabel.numberOfLines = 10;
			cell.textLabel.text = @"New*";
            cell.textLabel.font = [UIFont fontWithName:GZFont size:16.0];
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
			
			return cell;
		}
		else if (indexPath.row==2) {
			static NSString *CellIdentifier = @"CellCPassword";
			UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
			if (cell == nil) {
				cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
                cell.backgroundColor=RGB(210, 200, 191);
                txtCnfPassword = [[UITextField alloc] init];
				if (MyAppDelegate.isIpad) {
					txtCnfPassword.frame = CGRectMake(155, 10, 540, 30);
				} else {
					txtCnfPassword.frame = CGRectMake(125, 10, 170, 30);
				}
				
				txtCnfPassword.adjustsFontSizeToFitWidth = YES;
				txtCnfPassword.textColor = [UIColor blackColor];
				txtCnfPassword.delegate = self;
				
				txtCnfPassword.backgroundColor = [UIColor clearColor];
				txtCnfPassword.autocorrectionType = UITextAutocorrectionTypeNo; // no auto correction support
				txtCnfPassword.autocapitalizationType = UITextAutocapitalizationTypeWords; // no auto capitalization support
				txtCnfPassword.keyboardAppearance = UIKeyboardAppearanceAlert;
				txtCnfPassword.textAlignment = GZTextAlignmentRight;
				txtCnfPassword.clearButtonMode = UITextFieldViewModeWhileEditing; // no clear 'x' button to the right
				txtCnfPassword.returnKeyType = UIReturnKeyDone;
				txtCnfPassword.enabled=YES;
				txtCnfPassword.placeholder=@"Confirm Password";
				txtCnfPassword.tag = indexPath.row;
				txtCnfPassword.text = @"";
                txtCnfPassword.font = [UIFont fontWithName:GZFont size:12.0];
				txtCnfPassword.secureTextEntry = YES;
				txtCnfPassword.keyboardType = UIKeyboardTypeDefault;
				
				[cell addSubview:txtCnfPassword];
			}
			cell.accessoryType = UITableViewCellAccessoryNone;
			cell.textLabel.numberOfLines = 10;
			cell.textLabel.text = @"Confirm*";
            cell.textLabel.font = [UIFont fontWithName:GZFont size:16.0];
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
			
			return cell;
		}
	}
	return nil;
}


- (void)textFieldDidBeginEditing:(UITextField *)textField {
	NSIndexPath *indexPath = [self.tableView indexPathForCell:(UITableViewCell*)[textField superview]];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btnSubmit];
	[self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    if ([txtCnfPassword.text isEqualToString:@""] && [txtNewPassword.text isEqualToString:@""] && [txtOldPassword.text isEqualToString:@""]) {
        [self addrightMenuButtonWithImage:[UIImage imageNamed:@"help"]];
    }
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
	NSUInteger newLength = [textField.text length] + [string length] - range.length;
	//	return (newLength > 3) ? NO : YES;
	
	if (textField==txtOldPassword && newLength >20) {
		return NO;
	} else if (textField==txtNewPassword && newLength >20) {
		return NO;
	} else if (textField==txtCnfPassword && newLength >20) {
		return NO;
	}
	return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	
	int currentSection = [[self.tableView indexPathForCell:(UITableViewCell*)[textField superview]] section];
	
	NSInteger nextTag = textField.tag + 1;
	NSIndexPath *indexPath = [NSIndexPath indexPathForRow:nextTag inSection:currentSection];
	
	int returnType = [textField	returnKeyType];
	if (returnType==UIReturnKeyDone) {
		[textField resignFirstResponder];
		return YES;
	} else {
		[self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
		UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
		UIResponder *nextResponder = [cell viewWithTag:nextTag];
		
		if (nextResponder) {
			[nextResponder becomeFirstResponder];
		} else {
			[textField resignFirstResponder];
		}
		return YES;
	}
}

- (BOOL)isFoundSpecialCharacter:(NSString*)stringToValidate {
    NSCharacterSet * set = [[NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ0123456789"] invertedSet];
    if ([stringToValidate rangeOfCharacterFromSet:set].location != NSNotFound) {
        //string contains illegal characters
        return YES;
    } else {
        return NO;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)viewDidUnload {
    [super viewDidUnload];
}

@end
