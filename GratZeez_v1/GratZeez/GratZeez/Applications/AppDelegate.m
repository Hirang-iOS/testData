//
//  AppDelegate.m
//  GratZeez
//
//  Created by cloudZon Infosoft on 14/10/13.
//  Copyright (c) 2013 cloudZon Infosoft. All rights reserved.
//
/*
#import "AppDelegate.h"

#import "LoginViewController.h"
//#import "RegistrationViewController.h"
#import "GratuityViewController.h"
#import "HistoryViewController.h"
//#import "MyAccountViewController.h"
#import "HelpViewController.h"
#import "PaymentViewController.h"
#import <CommonCrypto/CommonDigest.h>
#import "UIImageView+AFNetworking.h"
#import "ServiceProviderHistoryViewController.h"
#import "MyAccountView.h"
#import "MenuViewController.h"
#import "SideMenuController.h"
@implementation AppDelegate

@synthesize isUserSessionStart,work,EVC;
@synthesize tabBar,navBar1,navBar2,navBar3;
@synthesize session = _session;
UIView *tabBarBg;

LoginViewController *loginVC;
GratuityViewController *gratuityVC;
HistoryViewController *historyVC;
//MyAccountViewController *myaccountVC;
MyAccountView *myaccount;
ServiceProviderHistoryViewController *serviceProviderHistoryVC;

@synthesize isIpad,isiPhone5,loginDismiss,searchResultArray,locationData,imgData,isServiceProvider;

NSString *const FBSessionStateChangedNotification = @"cloudZon.GratZeez:FBSessionStateChangedNotification";



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSLog(@"launched without %@",launchOptions);
    isServiceProvider=FALSE;
    //loginVC = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
     navBar1 = [[UINavigationController alloc] init];
     navBar2 = [[UINavigationController alloc] init];
     navBar3 = [[UINavigationController alloc] init];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        if ([[UIScreen mainScreen] bounds].size.height==568) {
            //iPhone5
            isIpad=NO;
            isiPhone5 = YES;
        }
        else {
            //Other iPhone
            isIpad=NO;
            isiPhone5 = NO;
        }
    }
    else {
        //iPad
        isIpad=YES;
        isiPhone5 = NO;
    }

    //EstablishmentViewController *EVC=[[EstablishmentViewController alloc]initWithNibName:@"EstablishmentViewController" bundle:nil];
    //EVC=[[EstablishmentViewController alloc]initWithNibName:@"EstablishmentViewController" bundle:nil];
   // EVC=[[EstablishmentDetailViewController alloc]initWithNibName:@"EstablishmentDetailViewController" bundle:nil];

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    [self performSelector:@selector(LoadTabBar)];
    self.window.rootViewController = tabBar;
    [self.window makeKeyAndVisible];
    loginDismiss=0;
    [self performAppStartUp:^(BOOL result) {
        if (result) {
            isUserSessionStart = YES;
            if(loginDismiss==1){
                NSLog(@"logindissmiss with one called");
                if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"UserLogedInType"] intValue] == LoginTypeFacebook){
                    if([[[NSUserDefaults standardUserDefaults] valueForKey:@"is-profile-complete"] boolValue]==0){
                        UIAlertView *autoLoginAlert = [[UIAlertView alloc] initWithTitle:@"User Type"
                                                                        message:@"Are You Want To register As a Service Provider?"
                                                                       delegate:self
                                                              cancelButtonTitle:nil
                                                              otherButtonTitles:@"Yes",@"No", nil];
                        
                        [autoLoginAlert show];
                    }
                    else{
                        [loginVC dismissViewControllerAnimated:NO completion:nil];
                    }
                }
                if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"UserLogedInType"] intValue] == LoginTypeGZNative){
                [loginVC dismissViewControllerAnimated:NO completion:^{
                    if([[[NSUserDefaults standardUserDefaults] valueForKey:@"is-profile-complete"] boolValue]==0)
                    {
                       
                        [self CompleteProfile];}
                }];}
                loginDismiss=0;
            }
            else{
                NSLog(@"login dissmiss without called");
            [loginVC dismissViewControllerAnimated:YES completion:^{
                
            }];}
//            [requests LoadData:nil];
        }
        else {
            [self ClearLoginData];
            [self LoginRequired:nil];
        }
    }];

    
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1) {
        NSLog(@"IOS6");
    }
    else {
        NSLog(@"IOS7");
    }
    
    return YES;
}

#pragma alertview to check usertype for facbook login

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
   //for yes
    if(buttonIndex==0){
        NSLog(@"service provider");
        [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"service-provider"];
        [loginVC dismissViewControllerAnimated:NO completion:^{[self CompleteProfile];}];
        
    }
    //for no
    if (buttonIndex == 1) {
         NSLog(@" No service provider");
        [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"service-provider"];
        [loginVC dismissViewControllerAnimated:NO completion:^{[self CompleteProfile];}];
    }
  
}

- (NSString*)md5HexDigest:(NSString*)input {
    const char* str = [input UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, strlen(str), result);
    
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH*2];
    for(int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02x",result[i]];
    }
    return ret;
}


- (void)openSessionWithAllowLoginUI:(BOOL)allowLoginUI completionBlock:(void(^)(BOOL result))return_back {
    [FBSession openActiveSessionWithReadPermissions:[NSArray arrayWithObjects:@"email",@"basic_info",@"user_birthday",@"user_photos",nil]
                                       allowLoginUI:allowLoginUI
                                  completionHandler:^(FBSession *session, FBSessionState state, NSError *error) {
                                      if (state == FBSessionStateOpen && !error) {
                                          switch (state) {
                                              case FBSessionStateOpen: {
                                                  NSLog(@"FBSessionStateOpen");
                                                  if (FBSession.activeSession.isOpen) {
                                                      [[FBRequest requestForMe] startWithCompletionHandler:^(FBRequestConnection *connection,NSDictionary<FBGraphUser> *user,NSError *error) {
                                                          if (!error) {
                                                              [[NSUserDefaults standardUserDefaults] setValue:[user objectForKey:@"email"] forKey:@"username"];
                                                              [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:@"password"]; //[self md5HexDigest:@""]
                                                              [[NSUserDefaults standardUserDefaults] setObject:user forKey:@"FBUserLogedInProfileData"];
                                                              [[NSUserDefaults standardUserDefaults] synchronize];
                                                              
                                                              NSLog(@"FBUser: %@",user);
                                                              [[NSUserDefaults standardUserDefaults] setInteger:LoginTypeFacebook forKey:@"UserLogedInType"];
                                                              [[NSUserDefaults standardUserDefaults] synchronize];
                                                              
                                                              [self AutoSignIn:nil completionBlock:^(BOOL result) {
                                                                  if (result) {
                                                                      return_back(TRUE);
//                                                                      [loginVC dismissViewControllerAnimated:YES completion:^{
//                                                                          return_back(TRUE);
//                                                                      }];
                                                                  }
                                                              }];
                                                          }
                                                          else {
                                                              [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                                                                              type:AJNotificationTypeRed
                                                                                             title:error.localizedDescription
                                                                                   linedBackground:AJLinedBackgroundTypeDisabled
                                                                                         hideAfter:GZAJNotificationDelay];
                                                              
                                                              [self ClearLoginData];
                                                              
                                                              // Once the user has logged out, we want them to be looking at the root view.
                                                              [FBSession.activeSession closeAndClearTokenInformation];
                                                              
                                                              //Ask for Login
                                                              [self performSelector:@selector(LoginRequired:) withObject:nil afterDelay:0.5f];
                                                              return_back(FALSE);
                                                          }
                                                      }];
                                                  }
                                              }
                                                  break;
                                              case FBSessionStateClosed: {
                                                  NSLog(@"FBSessionStateClosed");
                                                  
                                                  //Change state of UserLogedInType if session is closed
                                                  [self ClearLoginData];
                                                  
                                                  // Once the user has logged out, we want them to be looking at the root view.
                                                  [FBSession.activeSession closeAndClearTokenInformation];
                                                  
                                                  if (error) {
                                                      [[[UIAlertView alloc] initWithTitle:@"Oops!"
                                                                                  message:@"Something is wrong!\nPlease relogin."
                                                                                 delegate:nil
                                                                        cancelButtonTitle:@"OK"
                                                                        otherButtonTitles:nil] show];
                                                      
                                                      //Ask for Login
                                                      [self performSelector:@selector(LoginRequired:) withObject:nil afterDelay:0.5f];
                                                  }
                                              }
                                                  break;
                                              case FBSessionStateClosedLoginFailed: {
                                                  NSLog(@"FBSessionStateClosedLoginFailed");
                                                  if (error) {
                                                      [[[UIAlertView alloc] initWithTitle:@"Oops!"
                                                                                  message:@"Something is wrong!\nPlease relogin."
                                                                                 delegate:nil
                                                                        cancelButtonTitle:@"OK"
                                                                        otherButtonTitles:nil] show];
                                                      
                                                      //Change state of UserLogedInType if session is closed
                                                      [self ClearLoginData];
                                                      
                                                      //Ask for Login
                                                      [self performSelector:@selector(LoginRequired:) withObject:nil afterDelay:0.5f];
                                                  }
                                              }
                                                  break;
                                              default:
                                                  break;
                                          }
                                      }
                                      [[NSNotificationCenter defaultCenter] postNotificationName:FBSessionStateChangedNotification object:session];
                                  }];
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    NSString *urlString=[url absoluteString];
    NSLog(@"string%@",urlString);
   //  loginVC = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
 NSRange r = [urlString rangeOfString:@"gratzeez" options:NSCaseInsensitiveSearch];
    
    if(r.location != NSNotFound){
        NSLog(@"founddddd");
        NSLog(@"gratzeez url %@",url);
        //NSString *str=[url valueForKey:@"email"];
        NSArray *query = [[url query] componentsSeparatedByString:@"&"];
        NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithCapacity:[query count]];
        for(NSString *parameter in query)
        {
            NSArray *kv = [parameter componentsSeparatedByString:@"="];
            [parameters setObject:[kv count] > 1 ? [[kv objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:NSISOLatin1StringEncoding] : [NSNull null]
                           forKey:[[kv objectAtIndex:0] stringByReplacingPercentEscapesUsingEncoding:NSISOLatin1StringEncoding]];
        }
        
        NSLog(@"Parameters: %@", parameters);
        
       // NSString *urlString=[url stringByAppendingPathComponent:[[NSUserDefaults standardUserDefaults] valueForKey:@"profile-picture"]];
       // NSLog(@"email is%@",newURL);
       [self.tabBar dismissViewControllerAnimated:NO completion:nil];
        RegistrationViewController *RegistrationVC=[[RegistrationViewController alloc] initWithNibName:@"RegistrationViewController" bundle:[NSBundle mainBundle]];
        
        NSLog(@"q = %@", [parameters objectForKey:@"email"]);
        //UINavigationController *navController=[[UINavigationController alloc]initWithRootViewController:RegistrationVC];
          RegistrationVC.fromBrowser=TRUE;
      [[[UIApplication sharedApplication]keyWindow].rootViewController presentViewController:RegistrationVC animated:NO completion:^{
             NSLog(@"txtemail %@ value%@",RegistrationVC.txtEmail,RegistrationVC.txtEmail.text);
           RegistrationVC.txtEmail.userInteractionEnabled=NO;
           RegistrationVC.txtEmail.text=[parameters objectForKey:@"email"];
           RegistrationVC.btnServiceProvider.hidden=YES;
   //        RegistrationVC.hideBackButton=TRUE;
           RegistrationVC.lbl_create.hidden=YES;
         
        }];
       
        //reg.txtUserName.text=@"vivek";
        // reg.navItem.leftItemsSupplementBackButton=YES;
       // navController.navigationItem.leftBarButtonItem=nil;
        return YES;

    }
    
    NSLog(@"received url %@",url);
    NSLog(@"application with url");
    return [FBAppCall handleOpenURL:url sourceApplication:sourceApplication withSession:self.session];
}
- (void)ClearLoginData {
    NSLog(@"ClearLoginData");
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"UserLogedInType"] intValue] == LoginTypeGZNative) {
        NSLog(@"Logout GratZeez");
//        dictLogedInUserData = nil;
    }
    else if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"UserLogedInType"] intValue] == LoginTypeFacebook) {
        NSLog(@"Logout Facebook");
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"FBUserLogedInProfileData"];
        
        [FBSession.activeSession closeAndClearTokenInformation];
    }
    isUserSessionStart = NO;
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userid"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"username"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"password"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"service-provider"];
    // [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"UserLogedInType"];
    [[NSUserDefaults standardUserDefaults] setInteger:LoginTypeGZNative forKey:@"UserLogedInType"];
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"UserProfileData"]; //Used after signup and incomplete profile
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}


- (void)performAppStartUp:(void(^)(BOOL result))return_block {
    NSLog(@"performAppStartUp");
    int UserLoginType = [[[NSUserDefaults standardUserDefaults] valueForKey:@"UserLogedInType"] intValue];
    if (UserLoginType == LoginTypeGZNative) {
        if (!([[NSUserDefaults standardUserDefaults] objectForKey:@"username"] &&
              [[NSUserDefaults standardUserDefaults] objectForKey:@"password"] )) {
            return_block(FALSE);
        }
        else {
            [self AutoSignIn:nil completionBlock:^(BOOL result) {
                return_block(result);
            }];
        }
    }
    else if (UserLoginType == LoginTypeFacebook) {
        [self openSessionWithAllowLoginUI:NO completionBlock:^(BOOL result) {
            if (result) {
                return_block(TRUE);
            } else {
                return_block(FALSE);
            }
        }];
    }
}
- (void)AutoSignIn:(id)sender completionBlock:(void (^)(BOOL result)) return_block {
    NSLog(@"AutoSignIn");
    ASIFormDataRequest *_request;
    //__unsafe_unretained ASIFormDataRequest *request = _request;

   // __unsafe_unretained ASIFormDataRequest *requestImage = _requestImage;
    
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"UserLogedInType"] intValue] == LoginTypeGZNative) {
        NSLog(@"AutoSignIn GratZeez Login");
       _request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:URLNativeLogin]];
        __unsafe_unretained ASIFormDataRequest *request = _request;
        //Condition to check mannual Login Call
        NSDictionary *tmpDict = (NSDictionary*)sender;
        if ([tmpDict count]>0) {
            NSArray *objects = [NSArray arrayWithObjects:[tmpDict objectForKey:@"username"],[tmpDict objectForKey:@"password"],nil];
            NSArray *keys = [NSArray arrayWithObjects:@"user_name", @"password", nil];
            NSDictionary *loginDictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
            NSLog(@"%@",loginDictionary);
            [request appendPostData:[[NSString stringWithFormat:@"%@",loginDictionary] dataUsingEncoding:NSUTF8StringEncoding]];
            [request startAsynchronous];
            [request setCompletionBlock:^{
                
                NSDictionary *root = [NSJSONSerialization JSONObjectWithData:[request responseData] options:0 error:nil];
                
                NSLog(@"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~root: %@",root);
                if([root count]==0){
                    [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                                    type:AJNotificationTypeRed
                                                   title:@"Server Error"
                                         linedBackground:AJLinedBackgroundTypeDisabled
                                               hideAfter:GZAJNotificationDelay];
                    return_block(FALSE);
                }
                else{
                    if (![[root objectForKey:@"isError"] boolValue]) {
                   
                            [[NSUserDefaults standardUserDefaults] setObject:[root objectForKey:@"authentication-secret"] forKey:@"authentication-secret"];
                            [[NSUserDefaults standardUserDefaults] setObject:[root objectForKey:@"authentication-token"] forKey:@"authentication-token"];
                            [[NSUserDefaults standardUserDefaults] setObject:[root objectForKey:@"userId"] forKey:@"userid"];
                            [[NSUserDefaults standardUserDefaults] setObject:[root objectForKey:@"isProfileComplete"] forKey:@"is-profile-complete"];
                            [[NSUserDefaults standardUserDefaults] setObject:[root objectForKey:@"firstName"] forKey:@"first_name"];
                            [[NSUserDefaults standardUserDefaults] setObject:[root objectForKey:@"lastName"] forKey:@"last_name"];
                            [[NSUserDefaults standardUserDefaults] setObject:[root objectForKey:@"serviceProvider"] forKey:@"service-provider"];
                            [[NSUserDefaults standardUserDefaults] setObject:[root objectForKey:@"profilePicture"] forKey:@"profile-picture"];
                            NSDictionary *tmpDict = (NSDictionary*)sender;
                            if ([tmpDict count]>0) {
                                [[NSUserDefaults standardUserDefaults] setObject:[tmpDict objectForKey:@"username"] forKey:@"username"];
                                [[NSUserDefaults standardUserDefaults] setObject:[tmpDict objectForKey:@"password"] forKey:@"password"];
                            }
                            [[NSUserDefaults standardUserDefaults] synchronize];
                            
                            if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"UserLogedInType"] intValue] == LoginTypeGZNative){
//                                [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
//                                                                type:AJNotificationTypeBlue
//                                                               title:[root objectForKey:@"message"]
//                                                     linedBackground:AJLinedBackgroundTypeDisabled
//                                                           hideAfter:GZAJNotificationDelay];
                            }
                        

                        if([[[NSUserDefaults standardUserDefaults] valueForKey:@"service-provider"] boolValue]==0){
                            tabBar.selectedIndex=1;
                        }
                        else{
                            tabBar.selectedIndex=0;
                        }
                        
                            return_block(TRUE);
                        
                        
                    }
                    else {
                        NSLog(@"called");
                        [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                                        type:AJNotificationTypeRed
                                                       title:[root objectForKey:@"message"]
                                             linedBackground:AJLinedBackgroundTypeDisabled
                                                   hideAfter:GZAJNotificationDelay];
                        return_block(FALSE);
                    }}
            }];
            [request setFailedBlock:^{
                NSError *error = [request error];
                NSLog(@"Error: %@",error.localizedDescription);
                [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                                type:AJNotificationTypeRed
                                               title:error.localizedDescription
                                     linedBackground:AJLinedBackgroundTypeDisabled
                                           hideAfter:GZAJNotificationDelay];
                return_block(FALSE);
            }];
        }
     //for auto native login
        else {
            NSArray *objects = [NSArray arrayWithObjects:[[NSUserDefaults standardUserDefaults] objectForKey:@"username"],[[NSUserDefaults standardUserDefaults] objectForKey:@"password"],nil];
            NSArray *keys = [NSArray arrayWithObjects:@"user_name", @"password", nil];
            loginDismiss=1;
            NSDictionary *loginDictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
            [request appendPostData:[[NSString stringWithFormat:@"%@",loginDictionary] dataUsingEncoding:NSUTF8StringEncoding]];
            [request startAsynchronous];
            [request setCompletionBlock:^{
                
                NSDictionary *root = [NSJSONSerialization JSONObjectWithData:[request responseData] options:0 error:nil];
                NSLog(@"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~root: %@",root);
                if([root count]==0){
                    [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                                    type:AJNotificationTypeRed
                                                   title:@"Server Error"
                                         linedBackground:AJLinedBackgroundTypeDisabled
                                               hideAfter:GZAJNotificationDelay];
                    return_block(FALSE);
                }
                else{
                    if (![[root objectForKey:@"isError"] boolValue]) {
                        
                            [[NSUserDefaults standardUserDefaults] setObject:[root objectForKey:@"authentication-secret"] forKey:@"authentication-secret"];
                            [[NSUserDefaults standardUserDefaults] setObject:[root objectForKey:@"authentication-token"] forKey:@"authentication-token"];
                            [[NSUserDefaults standardUserDefaults] setObject:[root objectForKey:@"userId"] forKey:@"userid"];
                            [[NSUserDefaults standardUserDefaults] setObject:[root objectForKey:@"isProfileComplete"] forKey:@"is-profile-complete"];
                            [[NSUserDefaults standardUserDefaults] setObject:[root objectForKey:@"firstName"] forKey:@"first_name"];
                            [[NSUserDefaults standardUserDefaults] setObject:[root objectForKey:@"lastName"] forKey:@"last_name"];
                            [[NSUserDefaults standardUserDefaults] setObject:[root objectForKey:@"serviceProvider"] forKey:@"service-provider"];
                            [[NSUserDefaults standardUserDefaults] setObject:[root objectForKey:@"profilePicture"] forKey:@"profile-picture"];
                            NSDictionary *tmpDict = (NSDictionary*)sender;
                            if ([tmpDict count]>0) {
                                [[NSUserDefaults standardUserDefaults] setObject:[tmpDict objectForKey:@"username"] forKey:@"username"];
                                [[NSUserDefaults standardUserDefaults] setObject:[tmpDict objectForKey:@"password"] forKey:@"password"];
                            }
                            [[NSUserDefaults standardUserDefaults] synchronize];
                            
                            if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"UserLogedInType"] intValue] == LoginTypeGZNative){
//                                [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
//                                                                type:AJNotificationTypeBlue
//                                                               title:[root objectForKey:@"message"]
//                                                     linedBackground:AJLinedBackgroundTypeDisabled
//                                                           hideAfter:GZAJNotificationDelay];
                            }
                        
                        if([[[NSUserDefaults standardUserDefaults] valueForKey:@"service-provider"] boolValue]==0){
                            tabBar.selectedIndex=1;
                        }
                        else{
                            tabBar.selectedIndex=0;
                        }
                            return_block(TRUE);
                        
                        }
                    else {
                        [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                                        type:AJNotificationTypeRed
                                                       title:[root objectForKey:@"message"]
                                             linedBackground:AJLinedBackgroundTypeDisabled
                                                   hideAfter:GZAJNotificationDelay];
                        return_block(FALSE);
                    }}
            }];
            [request setFailedBlock:^{
                NSError *error = [request error];
                NSLog(@"Error: %@",error.localizedDescription);
                [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                                type:AJNotificationTypeRed
                                               title:error.localizedDescription
                                     linedBackground:AJLinedBackgroundTypeDisabled
                                           hideAfter:GZAJNotificationDelay];
                return_block(FALSE);
            }];
        }
    }
    else if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"UserLogedInType"] intValue] == LoginTypeFacebook) {
        NSLog(@"AutoSignIn Facebook Login");
        _request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:URLFacebookLogin]];
            __unsafe_unretained ASIFormDataRequest *request = _request;
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"FBUserLogedInProfileData"] != [NSNull null]) {
            
            NSMutableDictionary *FBUserProfileData = [[NSMutableDictionary alloc] initWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:@"FBUserLogedInProfileData"]];
//            NSData *fbImageData=[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?width=100&height=100",[FBUserProfileData objectForKey:@"id"]]]];
            NSURL *fb_url=[NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?width=100&height=100",[FBUserProfileData objectForKey:@"id"]]];
           
            NSDateFormatter *f1=[[NSDateFormatter alloc]init];
            [f1 setDateFormat:@"mm/dd/yyyy"];
            NSDate *sendDate=[f1 dateFromString:[FBUserProfileData objectForKey:@"birthday"]];
            NSLog(@"send date is %@",sendDate);
            NSDateFormatter *f2=[[NSDateFormatter alloc]init];
            [f2 setDateFormat:@"MM-dd-YYYY"];
            NSString *ds=[NSString stringWithFormat:@"%@",[f2 stringFromDate:sendDate]];
            NSLog(@"date srinf %@",ds);
            NSArray *keys = [NSArray arrayWithObjects:
                             @"login_via",
                             @"user_name",
                             @"password",
                             @"first_name",
                             @"last_name",
                             @"gender",
                             @"dob",
                             @"email",
                             @"fb_url",
                             nil];
            
            NSArray *objects = [NSArray arrayWithObjects:
                                @"facebook",
                                [[NSUserDefaults standardUserDefaults] objectForKey:@"username"],
                                [[NSUserDefaults standardUserDefaults] objectForKey:@"password"],
                                [FBUserProfileData objectForKey:@"first_name"],
                                [FBUserProfileData objectForKey:@"last_name"],
                                [FBUserProfileData objectForKey:@"gender"],
                                ds,
                                [FBUserProfileData objectForKey:@"email"],
                                fb_url,
                                nil];
            loginDismiss=1;

            NSDictionary *loginDictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
            [request appendPostData:[[NSString stringWithFormat:@"%@",loginDictionary] dataUsingEncoding:NSUTF8StringEncoding]];
           // [request addData:fbImageData forKey:@"file"];
           // [request setData:fbImageData forKey:@"file"];
            [request startAsynchronous];
            NSLog(@"pinged");
            [request setCompletionBlock:^{
                
                NSDictionary *root = [NSJSONSerialization JSONObjectWithData:[request responseData] options:0 error:nil];
                NSLog(@"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~root: %@",root);
                if([root count]==0){
                    [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                                    type:AJNotificationTypeRed
                                                   title:@"Server Error"
                                         linedBackground:AJLinedBackgroundTypeDisabled
                                               hideAfter:GZAJNotificationDelay];
                    return_block(FALSE);
                }
                else{
                    if (![[root objectForKey:@"isError"] boolValue]) {
//                        ASIFormDataRequest *_requestImage = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:URLGetImage]];
//                        __unsafe_unretained ASIFormDataRequest *requestImage = _requestImage;
//                        [requestImage setPostValue:[root objectForKey:@"userId"] forKey:@"user_id"];
//                        [requestImage startAsynchronous];
                            // NSLog(@"proimage%@",[requestImage responseData]);
                            //imgData=[UIImage imageWithData:[requestImage responseData] scale:1.0f];
                            [[NSUserDefaults standardUserDefaults] setObject:[root objectForKey:@"authentication-secret"] forKey:@"authentication-secret"];
                            [[NSUserDefaults standardUserDefaults] setObject:[root objectForKey:@"authentication-token"] forKey:@"authentication-token"];
                            [[NSUserDefaults standardUserDefaults] setObject:[root objectForKey:@"userId"] forKey:@"userid"];
                            [[NSUserDefaults standardUserDefaults] setObject:[root objectForKey:@"isProfileComplete"] forKey:@"is-profile-complete"];
                            [[NSUserDefaults standardUserDefaults] setObject:[root objectForKey:@"firstName"] forKey:@"first_name"];
                            [[NSUserDefaults standardUserDefaults] setObject:[root objectForKey:@"lastName"] forKey:@"last_name"];
                            [[NSUserDefaults standardUserDefaults] setObject:[root objectForKey:@"serviceProvider"] forKey:@"service-provider"];
                            [[NSUserDefaults standardUserDefaults] setObject:[root objectForKey:@"profilePicture"] forKey:@"profile-picture"];
                            NSDictionary *tmpDict = (NSDictionary*)sender;
                            if ([tmpDict count]>0) {
                                [[NSUserDefaults standardUserDefaults] setObject:[tmpDict objectForKey:@"username"] forKey:@"username"];
                                [[NSUserDefaults standardUserDefaults] setObject:[tmpDict objectForKey:@"password"] forKey:@"password"];
                            }
                            [[NSUserDefaults standardUserDefaults] synchronize];
                            
                            if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"UserLogedInType"] intValue] == LoginTypeGZNative){
                                [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                                                type:AJNotificationTypeBlue
                                                               title:[root objectForKey:@"message"]
                                                     linedBackground:AJLinedBackgroundTypeDisabled
                                                           hideAfter:GZAJNotificationDelay];}
                            if([[[NSUserDefaults standardUserDefaults] valueForKey:@"service-provider"] boolValue]==0){
                                tabBar.selectedIndex=1;
                            }
                            else{
                                tabBar.selectedIndex=0;
                            }
                         return_block(TRUE);
                    
                        
                       
                    }
                    else {
                        [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                                        type:AJNotificationTypeRed
                                                       title:[root objectForKey:@"message"]
                                             linedBackground:AJLinedBackgroundTypeDisabled
                                                   hideAfter:GZAJNotificationDelay];
                        return_block(FALSE);
                    }}
            }];
            [request setFailedBlock:^{
                NSError *error = [request error];
                NSLog(@"Error: %@",error.localizedDescription);
                [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                                type:AJNotificationTypeRed
                                               title:error.localizedDescription
                                     linedBackground:AJLinedBackgroundTypeDisabled
                                           hideAfter:GZAJNotificationDelay];
                return_block(FALSE);
            }];
            NSLog(@"loginDictionary: %@",loginDictionary);
        }
    }
    
    
 
    NSLog(@"started");
    
}

- (void)LoginRequired:(id)sender {
   loginVC = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    UINavigationController *navigationController = [[UINavigationController alloc]  initWithRootViewController:loginVC];
    navigationController.navigationBarHidden=YES;
    [self.tabBar presentViewController:navigationController animated:NO completion:^{
        NSLog(@"Dismiss Login");
    }];
}


#pragma mark- for completing user profile
-(void)CompleteProfile{
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"UserLogedInType"] intValue] == LoginTypeGZNative){
        if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"service-provider"] boolValue]==0) {
            PaymentViewController *paymentVC=[[PaymentViewController alloc]initWithNibName:@"PaymentViewController" bundle:nil];
            UINavigationController *navController=[[UINavigationController alloc]initWithRootViewController:paymentVC];
             [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed: @"top_bar"] forBarMetrics:UIBarMetricsDefault];
            [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
            [[UIBarButtonItem appearance] setTitleTextAttributes:textAttributes forState:UIControlStateNormal];
//            if ([navController.navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
//                
//                UIImage *navBarImg = [UIImage imageNamed:@"top_bar"];
//                
//                [navController.navigationBar setBackgroundImage:navBarImg forBarMetrics:UIBarMetricsDefault];
//                
//            }
            [self.tabBar presentViewController:navController animated:NO completion:nil];
            
        }
        else{
          
            ServiceProviderProfileViewController *serviceProviderVC=[[ServiceProviderProfileViewController alloc]init];
            UINavigationController *navController=[[UINavigationController alloc]initWithRootViewController:serviceProviderVC];
             [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed: @"top_bar"] forBarMetrics:UIBarMetricsDefault];
//            if ([navController.navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
//                
//                UIImage *navBarImg = [UIImage imageNamed:@"top_bar"];
//                
//                [navController.navigationBar setBackgroundImage:navBarImg forBarMetrics:UIBarMetricsDefault];
//                
//            }
            
            [self.tabBar presentViewController:navController animated:NO completion:nil];
        }
    }
    if([[[NSUserDefaults standardUserDefaults] valueForKey:@"UserLogedInType"] intValue] == LoginTypeFacebook){
        NSLog(@"nsdefault %d",[[[NSUserDefaults standardUserDefaults] valueForKey:@"service-provider"] boolValue]);
        if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"service-provider"] boolValue]==0) {
           
            PaymentViewController *paymentVC=[[PaymentViewController alloc]init];
            UINavigationController *navController=[[UINavigationController alloc]initWithRootViewController:paymentVC];
             [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed: @"top_bar"] forBarMetrics:UIBarMetricsDefault];
//            if ([navController.navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
//                
//                UIImage *navBarImg = [UIImage imageNamed:@"top_bar"];
//                
//                [navController.navigationBar setBackgroundImage:navBarImg forBarMetrics:UIBarMetricsDefault];
//                
//            }
                        [self.tabBar presentViewController:navController animated:NO completion:nil];
        }
        else{
            ServiceProviderProfileViewController *serviceProviderVC=[[ServiceProviderProfileViewController alloc]init];
            UINavigationController *navController=[[UINavigationController alloc]initWithRootViewController:serviceProviderVC];
            [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed: @"top_bar"] forBarMetrics:UIBarMetricsDefault];
//            if ([navController.navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
//                
//                UIImage *navBarImg = [UIImage imageNamed:@"top_bar"];
//                
//                [navController.navigationBar setBackgroundImage:navBarImg forBarMetrics:UIBarMetricsDefault];
//                
//            }
           
            [self.tabBar presentViewController:navController animated:NO completion:nil];
        }
        
    }

}



- (void)LoadTabBar {
    
    gratuityVC = [[GratuityViewController alloc] initWithNibName:@"GratuityViewController" bundle:nil];
    historyVC = [[HistoryViewController alloc] initWithNibName:@"HistoryViewController" bundle:nil];
   // myaccountVC = [[MyAccountViewController alloc] initWithNibName:@"MyAccountViewController" bundle:nil];
    myaccount=[[MyAccountView alloc]initWithNibName:@"MyAccountView" bundle:nil];
    tabBar = [[UITabBarController alloc]init];
    [tabBar setDelegate:self];
    //tabBar.tabBar.frame=CGRectMake(0, 528, 320, 40);
    tabBar.tabBar.tintColor=[UIColor whiteColor];
    CGRect frame = CGRectMake(0, 0, 320, 50);
    tabBarBg = [[UIView  alloc] initWithFrame:frame];
	UIImage *tabBarBackgroundImage = [UIImage imageNamed:@"bottom_bar.png"];
    tabBar.delegate=self;
    if([[[UIDevice currentDevice] systemVersion] floatValue]>4.9)
    {    [tabBar tabBar].backgroundImage = tabBarBackgroundImage;}
    else
    {        [tabBarBg setBackgroundColor:[[UIColor alloc] initWithPatternImage:tabBarBackgroundImage]];}
   
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed: @"top_bar"] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UIBarButtonItem appearance] setTitleTextAttributes:textAttributesTabBar forState:UIControlStateNormal];
    
    navBar1.viewControllers = [NSArray arrayWithObjects:gratuityVC,nil];
  
    
    navBar2.viewControllers = [NSArray arrayWithObjects:historyVC,nil];
    //navBar2.title = @"Search";
    //navBar3.title = @"My Account";
    // navBar3.navigationItem.rightBarButtonItem=btnHelp;
    
    navBar3.viewControllers = [NSArray arrayWithObjects:myaccount,nil];
    
    tabBar.viewControllers = [NSArray arrayWithObjects:navBar1,navBar2,navBar3,nil];
    [[tabBar.tabBar.items objectAtIndex:0] setTitle:@"Gratuity"];
    [[tabBar.tabBar.items objectAtIndex:0] setTitlePositionAdjustment:UIOffsetMake(0.0, -15.0)];
    [[tabBar.tabBar.items objectAtIndex:1] setTitle:@"Search"];
    [[tabBar.tabBar.items objectAtIndex:1] setTitlePositionAdjustment:UIOffsetMake(0.0, -15.0)];
    [[tabBar.tabBar.items objectAtIndex:2] setTitle:@"My Account"];
    [[tabBar.tabBar.items objectAtIndex:2] setTitlePositionAdjustment:UIOffsetMake(0.0, -15.0)];
    tabBar.selectedIndex=0;
   
    navBar1.navigationBar.translucent = YES;
    navBar2.navigationBar.translucent = YES;
    navBar3.navigationBar.translucent = YES;
    
    

    for(UIViewController *tab in  self.tabBar.viewControllers)
        
    {
        [tab.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                [UIFont fontWithName:GZFont size:18.0f], NSFontAttributeName,[UIColor whiteColor], NSForegroundColorAttributeName, nil]
                                      forState:UIControlStateNormal];
    }
   

}

-(IBAction)btnHelpAction:(id)sender{
    NSLog(@"Help button called");
    HelpViewController *HVC=[[HelpViewController alloc]init];
    [self.tabBar presentViewController:HVC animated:YES completion:nil];
}

- (BOOL)tabBarController:(UITabBarController*)tabBarController shouldSelectViewController:(UIViewController*)viewController __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_3_0) {
	return YES;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
	NSInteger tabIndex = tabBarController.selectedIndex;
        NSLog(@"tabbabr%@",tabBarController.tabBar.selectedItem.title);
	if (tabIndex == 0) {
        UIImage *tabBarBackgroundImage = [UIImage imageNamed:@"bottom_bar.png"];
        if([[[UIDevice currentDevice] systemVersion] floatValue]>4.9){
            [tabBarController tabBar].backgroundImage = tabBarBackgroundImage;
         //  [ [tabBar.tabBarController.tabBar appearance] setTitleVerticalPositionAdjustment:-20 forBarMetrics:UIBarMetricsDefault];
            
        }
        else{
            [tabBarBg setBackgroundColor:[[UIColor alloc] initWithPatternImage:tabBarBackgroundImage]];
        }
	}
    else if (tabIndex == 1) {
        UIImage *tabBarBackgroundImage = [UIImage imageNamed:@"bottom_bar"];
        if([[[UIDevice currentDevice] systemVersion] floatValue]>4.9){
            [tabBarController tabBar].backgroundImage = tabBarBackgroundImage;
        }
        else{
            [tabBarBg setBackgroundColor:[[UIColor alloc] initWithPatternImage:tabBarBackgroundImage]];
        }
	}
    else if (tabIndex == 2) {
        UIImage *tabBarBackgroundImage = [UIImage imageNamed:@"bottom_bar"];
        if([[[UIDevice currentDevice] systemVersion] floatValue]>4.9){
            [tabBarController tabBar].backgroundImage = tabBarBackgroundImage;
        }
        else{
            [tabBarBg setBackgroundColor:[[UIColor alloc] initWithPatternImage:tabBarBackgroundImage]];
        }
	}
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}
- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}
- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}
- (void)applicationDidBecomeActive:(UIApplication *)application {
    [FBAppEvents activateApp];
    [FBAppCall handleDidBecomeActiveWithSession:self.session];
}
- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [self.session close];
}

@end
*/

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "GratuityViewController.h"
#import "HistoryViewController.h"
#import "PaymentViewController.h"
#import <CommonCrypto/CommonDigest.h>
#import "UIImageView+AFNetworking.h"
#import "ServiceProviderHistoryViewController.h"
#import "MyAccountView.h"
#import "MenuViewController.h"
#import "SideMenuController.h"
#import <Foundation/Foundation.h>
@implementation AppDelegate

@synthesize isUserSessionStart,work,EVC;
@synthesize tabBar,navBar1,navBar2,navBar3;
@synthesize session = _session;
UIView *tabBarBg;

LoginViewController *loginVC;
GratuityViewController *gratuityVC;
HistoryViewController *historyVC;
//MyAccountViewController *myaccountVC;
MyAccountView *myaccount;
MenuViewController *menuVC;
SideMenuController *sideMenuController;
ServiceProviderHistoryViewController *serviceProviderHistoryVC;

@synthesize isIpad,isiPhone5,loginDismiss,searchResultArray,locationData,imgData,isServiceProvider;

NSString *const FBSessionStateChangedNotification = @"cloudZon.GratZeez:FBSessionStateChangedNotification";
-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    NSLog(@"%@",userInfo);
}
- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSString *token = [[deviceToken description] stringByTrimmingCharactersInSet: [NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"content---%@", token);
}
- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)err {
    NSString *str = [NSString stringWithFormat: @"Error: %@", err];
    NSLog(@"%@",str);
}
//a075de7fbbc8b5247c2f6d78705e4d96aa30afe166f4d08820a479ceef42865b
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   // sleep(3);
    NSLog(@"launched without %@",launchOptions);
    isServiceProvider=FALSE;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        if ([[UIScreen mainScreen] bounds].size.height==568) {
            //iPhone5
            isIpad=NO;
            isiPhone5 = YES;
        }
        else {
            //Other iPhone
            isIpad=NO;
            isiPhone5 = NO;
        }
    }
    else {
        //iPad
        isIpad=YES;
        isiPhone5 = NO;
    }
    
  
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    menuVC = [[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil];
    
    
	loginVC = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    
	UINavigationController *contentNavigationController = [[UINavigationController alloc] initWithRootViewController:loginVC];
	SideMenuOptions *options = [[SideMenuOptions alloc] init];
	options.contentViewScale = 1.0;
	options.contentViewOpacity = 0.05;
	options.shadowOpacity = 0.0;
	sideMenuController = [[SideMenuController alloc] initWithMenuViewController:nil
                                                             contentViewController:contentNavigationController
                                                                           options:options];
    
	sideMenuController.menuFrame = CGRectMake(0, 64.0, 220.0, self.window.bounds.size.height - 64.0);
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed: @"top_bar"] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    
	self.window.rootViewController = sideMenuController;
    [self.window makeKeyAndVisible];
    [sideMenuController disable];
    loginDismiss=0;
    [self performAppStartUp:^(BOOL result) {
        if (result) {
            isUserSessionStart = YES;
            if(loginDismiss==1){
                NSLog(@"logindissmiss with one called");
                if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"UserLogedInType"] intValue] == LoginTypeFacebook){
                    if([[[NSUserDefaults standardUserDefaults] valueForKey:@"isSender"] boolValue]==0 && [[[NSUserDefaults standardUserDefaults] valueForKey:@"isServiceProvider"] boolValue]==0){
                        loginVC.lbl_register.font=[UIFont fontWithName:GZFont size:16];
                        loginVC.lbl_serviceProvider.font=[UIFont fontWithName:GZFont size:14];
                        loginVC.lbl_customer.font=[UIFont fontWithName:GZFont size:14];
                        loginVC.SelectionView.center=loginVC.view.center;
                        loginVC.SelectionView.layer.borderColor=[[UIColor blackColor] CGColor];
                        loginVC.SelectionView.layer.borderWidth=1.0;
                        loginVC.SelectionView.layer.cornerRadius=5;
                        loginVC.SelectionView.layer.masksToBounds=YES;
                        [UIView animateWithDuration:0.4 animations:^{
                            loginVC.SelectionView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
                        } completion:^(BOOL finished) {
                            loginVC.SelectionView.center=loginVC.view.center;
                            
                            [UIView animateWithDuration:0.4 animations:^{
                                loginVC.SelectionView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.95,0.95);
                            } completion:^(BOOL finished) {
                                // self.view.userInteractionEnabled=NO;
                            }];
                        }];
                        [loginVC.view addSubview:loginVC.SelectionView];
                    }
                    else{
                        if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"isSender"] boolValue]==1 && [[[NSUserDefaults standardUserDefaults] valueForKey:@"isServiceProvider"] boolValue]==0) {
                            [self redirectionForSender];
                        }
                        else if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"isSender"] boolValue]==0 && [[[NSUserDefaults standardUserDefaults] valueForKey:@"isServiceProvider"] boolValue]==1)
                        {
                            [self redirectionForServiceProvider];
                        }
                        else if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"isSender"] boolValue]==1 && [[[NSUserDefaults standardUserDefaults] valueForKey:@"isServiceProvider"] boolValue]==1){
                            UIAlertView *alert12 = [[UIAlertView alloc] initWithTitle:@"Login As:"
                                                                              message:nil
                                                                             delegate:self
                                                                    cancelButtonTitle:nil
                                                                    otherButtonTitles:@"ServiceProvider",@"Customer", nil];
                            alert12.tag=2;
                            [alert12 show];
                        }
                    }
                }
                if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"UserLogedInType"] intValue] == LoginTypeGZNative){

                    NSLog(@"===>loginas:%d %d",[[[NSUserDefaults standardUserDefaults] valueForKey:@"LoginAs"]boolValue],[[[NSUserDefaults standardUserDefaults] dictionaryRepresentation]count]);
                        if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"LoginAs"] isEqual:Sender]) {
                            if([[[NSUserDefaults standardUserDefaults] valueForKey:@"isSenderProfileComplete"] boolValue]==0){
                                [self CompleteProfile];
                            }
                            else{
                            HistoryViewController *historyVC = [[HistoryViewController alloc] initWithNibName:@"HistoryViewController" bundle:nil];
                            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:historyVC ];
                            
                            MenuViewController *menuVC = [[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil];
                            [sideMenuController disable];
                            [sideMenuController changeMenuViewController:menuVC closeMenu:YES];
                            [sideMenuController changeContentViewController:navigationController closeMenu:YES];
                            }
                        }
                        else if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"LoginAs"] isEqual:ServiceProvider])
                        {
                            if([[[NSUserDefaults standardUserDefaults] valueForKey:@"isServiceProviderProfileComplete"] boolValue]==0){
                                [self CompleteProfile];
                            }else{
                            GratuityViewController *gratuityVC=[[GratuityViewController alloc] initWithNibName:@"GratuityViewController" bundle:nil];
                            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:gratuityVC ];
                            
                            MenuViewController *menuVC = [[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil];
                            [sideMenuController disable];
                            [sideMenuController  changeMenuViewController:menuVC closeMenu:YES];
                            [sideMenuController  changeContentViewController:navigationController closeMenu:YES];
                            }
                        }
                        
                    }
            
        }
        else {
            NSLog(@"check1");
            [self ClearLoginData];
            [self LoginRequired:nil];
        }
    }
    } ];
    
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1) {
        NSLog(@"IOS6");
    }
    else {
        NSLog(@"IOS7");
    }
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
     (UIRemoteNotificationTypeBadge)];
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    return YES;
}

#pragma alertview to check usertype for facbook login

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    //for yes facebook alert
    if(alertView.tag==1){
    if(buttonIndex==0){
        NSLog(@"service provider");
       
        [[NSUserDefaults standardUserDefaults] setObject:@"true" forKey:@"isServiceProvider"];
        [[NSUserDefaults standardUserDefaults] setObject:ServiceProvider forKey:@"LoginAs"];
        [[NSUserDefaults standardUserDefaults] setObject:@"false" forKey:@"isSender"];
        if([[[NSUserDefaults standardUserDefaults] valueForKey:@"isServiceProviderProfileComplete"]  boolValue]==0){
            [self CompleteProfile];
        }
    }
    //for no
    else
    {
    [[NSUserDefaults standardUserDefaults] setObject:@"false" forKey:@"isServiceProvider"];
        [[NSUserDefaults standardUserDefaults] setObject:Sender forKey:@"LoginAs"];
    [[NSUserDefaults standardUserDefaults] setObject:@"true" forKey:@"isSender"];
        if([[[NSUserDefaults standardUserDefaults] valueForKey:@"isSenderProfileComplete"]  boolValue]==0){
            [self CompleteProfile];
        }
    }
    }
    
    //login alertview
    if(alertView.tag==2){
        if(buttonIndex==0){
            [self redirectionForServiceProvider];
        }
        if(buttonIndex==1){
            [self redirectionForSender];
        }
    }
}
-(void)redirectionForSender{
    [[NSUserDefaults standardUserDefaults] setObject:Sender forKey:@"LoginAs"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    if([[[NSUserDefaults standardUserDefaults] valueForKey:@"isSenderProfileComplete"] boolValue]==0){
        [self CompleteProfile];
    }
    else{
        HistoryViewController *historyVC = [[HistoryViewController alloc] initWithNibName:@"HistoryViewController" bundle:nil];
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:historyVC ];
        MenuViewController *menuVC = [[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil];
        [sideMenuController disable];
        [sideMenuController changeMenuViewController:menuVC closeMenu:YES];
        [sideMenuController changeContentViewController:navigationController closeMenu:YES];
    }
}
-(void)redirectionForServiceProvider{
    [[NSUserDefaults standardUserDefaults] setObject:ServiceProvider forKey:@"LoginAs"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    if([[[NSUserDefaults standardUserDefaults] valueForKey:@"isServiceProviderProfileComplete"] boolValue]==0){
        [self CompleteProfile];
    }
    else{
        GratuityViewController *gratuityVC=[[GratuityViewController alloc] initWithNibName:@"GratuityViewController" bundle:nil];
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:gratuityVC ];
        MenuViewController *menuVC = [[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil];
        [sideMenuController disable];
        [sideMenuController  changeMenuViewController:menuVC closeMenu:YES];
        [sideMenuController changeContentViewController:navigationController closeMenu:YES];
    }
}
- (NSString*)md5HexDigest:(NSString*)input {
    const char* str = [input UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, strlen(str), result);
    
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH*2];
    for(int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02x",result[i]];
    }
    return ret;
}


- (void)openSessionWithAllowLoginUI:(BOOL)allowLoginUI completionBlock:(void(^)(BOOL result))return_back {
    [FBSession openActiveSessionWithReadPermissions:[NSArray arrayWithObjects:@"email",@"basic_info",@"user_birthday",@"user_photos",nil]
                                       allowLoginUI:allowLoginUI
                                  completionHandler:^(FBSession *session, FBSessionState state, NSError *error) {
                                      if (state == FBSessionStateOpen && !error) {
                                          switch (state) {
                                              case FBSessionStateOpen: {
                                                  NSLog(@"FBSessionStateOpen");
                                                  if (FBSession.activeSession.isOpen) {
                                                      [[FBRequest requestForMe] startWithCompletionHandler:^(FBRequestConnection *connection,NSDictionary<FBGraphUser> *user,NSError *error) {
                                                          if (!error) {
                                                              [[NSUserDefaults standardUserDefaults] setValue:[user objectForKey:@"email"] forKey:@"username"];
                                                              [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:@"password"]; //[self md5HexDigest:@""]
                                                              [[NSUserDefaults standardUserDefaults] setObject:user forKey:@"FBUserLogedInProfileData"];
                                                              [[NSUserDefaults standardUserDefaults] synchronize];
                                                              
                                                              NSLog(@"FBUser: %@",user);
                                                              [[NSUserDefaults standardUserDefaults] setInteger:LoginTypeFacebook forKey:@"UserLogedInType"];
                                                              [[NSUserDefaults standardUserDefaults] synchronize];
                                                              
                                                              [self AutoSignIn:nil completionBlock:^(BOOL result) {
                                                                  if (result) {
                                                                      return_back(TRUE);
                                                                      //                                                                      [loginVC dismissViewControllerAnimated:YES completion:^{
                                                                      //                                                                          return_back(TRUE);
                                                                      //                                                                      }];
                                                                  }
                                                              }];
                                                          }
                                                          else {
                                                              [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                                                                              type:AJNotificationTypeRed
                                                                                             title:error.localizedDescription
                                                                                   linedBackground:AJLinedBackgroundTypeDisabled
                                                                                         hideAfter:GZAJNotificationDelay];
                                                              
                                                              [self ClearLoginData];
                                                              
                                                              // Once the user has logged out, we want them to be looking at the root view.
                                                              [FBSession.activeSession closeAndClearTokenInformation];
                                                              
                                                              //Ask for Login
                                                              [self performSelector:@selector(LoginRequired:) withObject:nil afterDelay:0.5f];
                                                              return_back(FALSE);
                                                          }
                                                      }];
                                                  }
                                              }
                                                  break;
                                              case FBSessionStateClosed: {
                                                  NSLog(@"FBSessionStateClosed");
                                                  
                                                  //Change state of UserLogedInType if session is closed
                                                  [self ClearLoginData];
                                                  
                                                  // Once the user has logged out, we want them to be looking at the root view.
                                                  [FBSession.activeSession closeAndClearTokenInformation];
                                                  
                                                  if (error) {
                                                      [[[UIAlertView alloc] initWithTitle:@"Oops!"
                                                                                  message:@"Something is wrong!\nPlease relogin."
                                                                                 delegate:nil
                                                                        cancelButtonTitle:@"OK"
                                                                        otherButtonTitles:nil] show];
                                                      
                                                      //Ask for Login
                                                      [self performSelector:@selector(LoginRequired:) withObject:nil afterDelay:0.5f];
                                                  }
                                              }
                                                  break;
                                              case FBSessionStateClosedLoginFailed: {
                                                  NSLog(@"FBSessionStateClosedLoginFailed");
                                                  if (error) {
                                                      [[[UIAlertView alloc] initWithTitle:@"Oops!"
                                                                                  message:@"Something is wrong!\nPlease relogin."
                                                                                 delegate:nil
                                                                        cancelButtonTitle:@"OK"
                                                                        otherButtonTitles:nil] show];
                                                      
                                                      //Change state of UserLogedInType if session is closed
                                                      [self ClearLoginData];
                                                      
                                                      //Ask for Login
                                                      [self performSelector:@selector(LoginRequired:) withObject:nil afterDelay:0.5f];
                                                  }
                                              }
                                                  break;
                                              default:
                                                  break;
                                          }
                                      }
                                      [[NSNotificationCenter defaultCenter] postNotificationName:FBSessionStateChangedNotification object:session];
                                  }];
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    NSString *urlString=[url absoluteString];
    NSLog(@"string%@",urlString);
    //  loginVC = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    NSRange r = [urlString rangeOfString:@"gratzeez" options:NSCaseInsensitiveSearch];
    
    if(r.location != NSNotFound){
        NSLog(@"founddddd");
        NSLog(@"gratzeez url %@",url);
        //NSString *str=[url valueForKey:@"email"];
        NSArray *query = [[url query] componentsSeparatedByString:@"&"];
        NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithCapacity:[query count]];
        for(NSString *parameter in query)
        {
            NSArray *kv = [parameter componentsSeparatedByString:@"="];
            [parameters setObject:[kv count] > 1 ? [[kv objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:NSISOLatin1StringEncoding] : [NSNull null]
                           forKey:[[kv objectAtIndex:0] stringByReplacingPercentEscapesUsingEncoding:NSISOLatin1StringEncoding]];
        }
        
        NSLog(@"Parameters: %@", parameters);
        
        // NSString *urlString=[url stringByAppendingPathComponent:[[NSUserDefaults standardUserDefaults] valueForKey:@"profile-picture"]];
        // NSLog(@"email is%@",newURL);
        [self.tabBar dismissViewControllerAnimated:NO completion:nil];
        RegistrationViewController *RegistrationVC=[[RegistrationViewController alloc] initWithNibName:@"RegistrationViewController" bundle:[NSBundle mainBundle]];
        
        NSLog(@"q = %@", [parameters objectForKey:@"email"]);
        //UINavigationController *navController=[[UINavigationController alloc]initWithRootViewController:RegistrationVC];
        RegistrationVC.fromBrowser=TRUE;
        [[[UIApplication sharedApplication]keyWindow].rootViewController presentViewController:RegistrationVC animated:NO completion:^{
            NSLog(@"txtemail %@ value%@",RegistrationVC.txtEmail,RegistrationVC.txtEmail.text);
            RegistrationVC.txtEmail.userInteractionEnabled=NO;
            RegistrationVC.txtEmail.text=[parameters objectForKey:@"email"];
            RegistrationVC.btnServiceProvider.hidden=YES;
            //        RegistrationVC.hideBackButton=TRUE;
            RegistrationVC.lbl_create.hidden=YES;
            
        }];
        
        //reg.txtUserName.text=@"vivek";
        // reg.navItem.leftItemsSupplementBackButton=YES;
        // navController.navigationItem.leftBarButtonItem=nil;
        return YES;
        
    }
    
    NSLog(@"received url %@",url);
    NSLog(@"application with url");
    return [FBAppCall handleOpenURL:url sourceApplication:sourceApplication withSession:self.session];
}
- (void)ClearLoginData {
    NSLog(@"ClearLoginData");
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"UserLogedInType"] intValue] == LoginTypeGZNative) {
        NSLog(@"Logout GratZeez");
        //        dictLogedInUserData = nil;
    }
    else if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"UserLogedInType"] intValue] == LoginTypeFacebook) {
        NSLog(@"Logout Facebook");
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"FBUserLogedInProfileData"];
        
        [FBSession.activeSession closeAndClearTokenInformation];
    }
    isUserSessionStart = NO;
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userid"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"username"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"password"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"service-provider"];
    // [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"UserLogedInType"];
    [[NSUserDefaults standardUserDefaults] setInteger:LoginTypeGZNative forKey:@"UserLogedInType"];
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"UserProfileData"]; //Used after signup and incomplete profile
    [self resetDefaults];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (void)resetDefaults {
    NSUserDefaults * defs = [NSUserDefaults standardUserDefaults];
    NSDictionary * dict = [defs dictionaryRepresentation];
    for (id key in dict) {
        [defs removeObjectForKey:key];
    }
}

- (void)performAppStartUp:(void(^)(BOOL result))return_block {
    NSLog(@"performAppStartUp");
    int UserLoginType = [[[NSUserDefaults standardUserDefaults] valueForKey:@"UserLogedInType"] intValue];
    if (UserLoginType == LoginTypeGZNative) {
        if (!([[NSUserDefaults standardUserDefaults] objectForKey:@"username"] &&
              [[NSUserDefaults standardUserDefaults] objectForKey:@"password"] )) {
            return_block(FALSE);
        }
        else {
            [self AutoSignIn:nil completionBlock:^(BOOL result) {
                return_block(result);
            }];
        }
    }
    else if (UserLoginType == LoginTypeFacebook) {
        [self openSessionWithAllowLoginUI:NO completionBlock:^(BOOL result) {
            if (result) {
                return_block(TRUE);
            } else {
                return_block(FALSE);
            }
        }];
    }
}
- (void)AutoSignIn:(id)sender completionBlock:(void (^)(BOOL result)) return_block {
    NSLog(@"AutoSignIn");
    ASIFormDataRequest *_request;
    
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"UserLogedInType"] intValue] == LoginTypeGZNative) {
        NSLog(@"AutoSignIn GratZeez Login");
        _request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:URLNativeLogin]];
        __unsafe_unretained ASIFormDataRequest *request = _request;
        //Condition to check mannual Login Call
        NSDictionary *tmpDict = (NSDictionary*)sender;
        if ([tmpDict count]>0) {
            NSArray *objects = [NSArray arrayWithObjects:[tmpDict objectForKey:@"username"],[tmpDict objectForKey:@"password"],nil];
            NSArray *keys = [NSArray arrayWithObjects:@"user_name", @"password", nil];
            NSDictionary *loginDictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
            NSLog(@"%@",loginDictionary);
            [request appendPostData:[[NSString stringWithFormat:@"%@",loginDictionary] dataUsingEncoding:NSUTF8StringEncoding]];
            [request startAsynchronous];
            [request setCompletionBlock:^{
                
                NSDictionary *root = [NSJSONSerialization JSONObjectWithData:[request responseData] options:0 error:nil];
                
                NSLog(@"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~root: %@",root);
                if([root count]==0){
                    [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                                    type:AJNotificationTypeRed
                                                   title:@"Server Error"
                                         linedBackground:AJLinedBackgroundTypeDisabled
                                               hideAfter:GZAJNotificationDelay];
                    return_block(FALSE);
                }
                else{
                    if (![[root objectForKey:@"isError"] boolValue]) {
                        
                        [[NSUserDefaults standardUserDefaults] setObject:[root objectForKey:@"authentication-secret"] forKey:@"authentication-secret"];
                        [[NSUserDefaults standardUserDefaults] setObject:[root objectForKey:@"authentication-token"] forKey:@"authentication-token"];
                        [[NSUserDefaults standardUserDefaults] setObject:[root objectForKey:@"userId"] forKey:@"userid"];
                        [[NSUserDefaults standardUserDefaults] setObject:[root objectForKey:@"firstName"] forKey:@"first_name"];
                        [[NSUserDefaults standardUserDefaults] setObject:[root objectForKey:@"lastName"] forKey:@"last_name"];
                        [[NSUserDefaults standardUserDefaults] setObject:[root objectForKey:@"profilePicture"] forKey:@"profile-picture"];
                        [[NSUserDefaults standardUserDefaults] setObject:[root objectForKey:@"isCompleteSenderProfile"] forKey:@"isSenderProfileComplete"];
                        [[NSUserDefaults standardUserDefaults] setObject:[root objectForKey:@"isCompleteSPProfile"] forKey:@"isServiceProviderProfileComplete"];
                        [[NSUserDefaults standardUserDefaults] setObject:[root objectForKey:@"isServiceProvider"] forKey:@"isServiceProvider"];
                        [[NSUserDefaults standardUserDefaults] setObject:[root objectForKey:@"isSender"] forKey:@"isSender"];
                        NSDictionary *tmpDict = (NSDictionary*)sender;
                        if ([tmpDict count]>0) {
                            [[NSUserDefaults standardUserDefaults] setObject:[tmpDict objectForKey:@"username"] forKey:@"username"];
                            [[NSUserDefaults standardUserDefaults] setObject:[tmpDict objectForKey:@"password"] forKey:@"password"];
                        }
                        [[NSUserDefaults standardUserDefaults] synchronize];
                        
                        if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"UserLogedInType"] intValue] == LoginTypeGZNative){
                            //                                [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                            //                                                                type:AJNotificationTypeBlue
                            //                                                               title:[root objectForKey:@"message"]
                            //                                                     linedBackground:AJLinedBackgroundTypeDisabled
                            //                                                           hideAfter:GZAJNotificationDelay];
                        }
                        NSLog(@"check");
                        NSLog(@"%@",[[NSUserDefaults standardUserDefaults] dictionaryRepresentation]);
                        return_block(TRUE);
                        
                        
                    }
                    else {
                        NSLog(@"called");
                        [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                                        type:AJNotificationTypeRed
                                                       title:[root objectForKey:@"message"]
                                             linedBackground:AJLinedBackgroundTypeDisabled
                                                   hideAfter:GZAJNotificationDelay];
                        return_block(FALSE);
                    }}
            }];
            [request setFailedBlock:^{
                NSError *error = [request error];
                NSLog(@"Error: %@",error.localizedDescription);
                [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                                type:AJNotificationTypeRed
                                               title:error.localizedDescription
                                     linedBackground:AJLinedBackgroundTypeDisabled
                                           hideAfter:GZAJNotificationDelay];
                return_block(FALSE);
            }];
        }
        //for auto native login
        else {
            NSArray *objects = [NSArray arrayWithObjects:[[NSUserDefaults standardUserDefaults] objectForKey:@"username"],[[NSUserDefaults standardUserDefaults] objectForKey:@"password"],nil];
            NSArray *keys = [NSArray arrayWithObjects:@"user_name", @"password", nil];
            loginDismiss=1;
            NSDictionary *loginDictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
            [request appendPostData:[[NSString stringWithFormat:@"%@",loginDictionary] dataUsingEncoding:NSUTF8StringEncoding]];
            [request startAsynchronous];
            [request setCompletionBlock:^{
                
                NSDictionary *root = [NSJSONSerialization JSONObjectWithData:[request responseData] options:0 error:nil];
                NSLog(@"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~root: %@",root);
                if([root count]==0){
                    [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                                    type:AJNotificationTypeRed
                                                   title:@"Server Error"
                                         linedBackground:AJLinedBackgroundTypeDisabled
                                               hideAfter:GZAJNotificationDelay];
                    return_block(FALSE);
                }
                else{
                    if (![[root objectForKey:@"isError"] boolValue]) {
                        
                        [[NSUserDefaults standardUserDefaults] setObject:[root objectForKey:@"authentication-secret"] forKey:@"authentication-secret"];
                        [[NSUserDefaults standardUserDefaults] setObject:[root objectForKey:@"authentication-token"] forKey:@"authentication-token"];
                        [[NSUserDefaults standardUserDefaults] setObject:[root objectForKey:@"userId"] forKey:@"userid"];
                        [[NSUserDefaults standardUserDefaults] setObject:[root objectForKey:@"isCompleteSenderProfile"] forKey:@"isSenderProfileComplete"];
                        [[NSUserDefaults standardUserDefaults] setObject:[root objectForKey:@"isCompleteSPProfile"] forKey:@"isServiceProviderProfileComplete"];
                        [[NSUserDefaults standardUserDefaults] setObject:[root objectForKey:@"firstName"] forKey:@"first_name"];
                        [[NSUserDefaults standardUserDefaults] setObject:[root objectForKey:@"lastName"] forKey:@"last_name"];
                        [[NSUserDefaults standardUserDefaults] setObject:[root objectForKey:@"isServiceProvider"] forKey:@"isServiceProvider"];
                        [[NSUserDefaults standardUserDefaults] setObject:[root objectForKey:@"profilePicture"] forKey:@"profile-picture"];
                        [[NSUserDefaults standardUserDefaults] setObject:[root objectForKey:@"isSender"] forKey:@"isSender"];
                        NSDictionary *tmpDict = (NSDictionary*)sender;
                        if ([tmpDict count]>0) {
                            [[NSUserDefaults standardUserDefaults] setObject:[tmpDict objectForKey:@"username"] forKey:@"username"];
                            [[NSUserDefaults standardUserDefaults] setObject:[tmpDict objectForKey:@"password"] forKey:@"password"];
                        }
                        [[NSUserDefaults standardUserDefaults] synchronize];
                        NSLog(@"%@",[[NSUserDefaults standardUserDefaults] dictionaryRepresentation]);

                        if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"UserLogedInType"] intValue] == LoginTypeGZNative){
                            //                                [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                            //                                                                type:AJNotificationTypeBlue
                            //                                                               title:[root objectForKey:@"message"]
                            //                                                     linedBackground:AJLinedBackgroundTypeDisabled
                            //                                                           hideAfter:GZAJNotificationDelay];
                        }
                        return_block(TRUE);
                        
                    }
                    else {
                        [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                                        type:AJNotificationTypeRed
                                                       title:[root objectForKey:@"message"]
                                             linedBackground:AJLinedBackgroundTypeDisabled
                                                   hideAfter:GZAJNotificationDelay];
                        return_block(FALSE);
                    }}
            }];
            [request setFailedBlock:^{
                NSError *error = [request error];
                NSLog(@"Error: %@",error.localizedDescription);
                [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                                type:AJNotificationTypeRed
                                               title:error.localizedDescription
                                     linedBackground:AJLinedBackgroundTypeDisabled
                                           hideAfter:GZAJNotificationDelay];
                return_block(FALSE);
            }];
        }
    }
    else if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"UserLogedInType"] intValue] == LoginTypeFacebook) {
        NSLog(@"AutoSignIn Facebook Login");
        _request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:URLFacebookLogin]];
        __unsafe_unretained ASIFormDataRequest *request = _request;
        NSError *error=nil;
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"FBUserLogedInProfileData"] != [NSNull null]) {
            
            NSMutableDictionary *FBUserProfileData = [[NSMutableDictionary alloc] initWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:@"FBUserLogedInProfileData"]];
            //            NSData *fbImageData=[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?width=100&height=100",[FBUserProfileData objectForKey:@"id"]]]];
            NSURL *fb_url=[NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?width=100&height=100",[FBUserProfileData objectForKey:@"id"]]];
            NSString *myString = [fb_url absoluteString];
            NSDateFormatter *f1=[[NSDateFormatter alloc]init];
            [f1 setDateFormat:@"MM/dd/yyyy"];
            NSDate *sendDate=[f1 dateFromString:[FBUserProfileData objectForKey:@"birthday"]];
            NSLog(@"send date is %@",sendDate);
            NSDateFormatter *f2=[[NSDateFormatter alloc]init];
            [f2 setDateFormat:@"MM-dd-YYYY"];
            NSString *ds=[NSString stringWithFormat:@"%@",[f2 stringFromDate:sendDate]];
            NSLog(@"date srinf %@",ds);
            NSArray *keys = [NSArray arrayWithObjects:
                             @"userName",
//                             @"password",
                             @"firstName",
                             @"lastName",
                             @"gender",
                             @"dob",
                             @"email",
                             @"fb_url",
                             nil];
            
            NSArray *objects = [NSArray arrayWithObjects:
                                [[NSUserDefaults standardUserDefaults] objectForKey:@"username"],
//                                [[NSUserDefaults standardUserDefaults] objectForKey:@"password"],
                                [FBUserProfileData objectForKey:@"first_name"],
                                [FBUserProfileData objectForKey:@"last_name"],
                                [FBUserProfileData objectForKey:@"gender"],
                                ds,
                                [FBUserProfileData objectForKey:@"email"],
                                myString,
                                nil];
            loginDismiss=1;
            
            NSDictionary *loginfbDictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
            BOOL f=[NSJSONSerialization isValidJSONObject:loginfbDictionary];
            NSLog(@"%@",loginfbDictionary);
             NSLog(@"valid===>%d",f);
            NSData *LoginData=[NSJSONSerialization dataWithJSONObject:loginfbDictionary options:NSJSONWritingPrettyPrinted error:&error];
            NSLog(@"error===>%@",error);
            NSLog(@"fblogin %@",loginfbDictionary);
       
            [request addRequestHeader:@"Content-Type" value:@"application/json"];
            
            [request appendPostData:LoginData];
         
            [request startAsynchronous];
           

            NSLog(@"pinged");
            [request setCompletionBlock:^{
                
                NSDictionary *root = [NSJSONSerialization JSONObjectWithData:[request responseData] options:0 error:nil];
                NSLog(@"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~root: %@",root);
                if([root count]==0){
                    [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                                    type:AJNotificationTypeRed
                                                   title:@"Server Error"
                                         linedBackground:AJLinedBackgroundTypeDisabled
                                               hideAfter:GZAJNotificationDelay];
                    return_block(FALSE);
                }
                else{
                    if (![[root objectForKey:@"isError"] boolValue]) {
                    
                        [[NSUserDefaults standardUserDefaults] setObject:[root objectForKey:@"authentication-secret"] forKey:@"authentication-secret"];
                        [[NSUserDefaults standardUserDefaults] setObject:[root objectForKey:@"authentication-token"] forKey:@"authentication-token"];
                        [[NSUserDefaults standardUserDefaults] setObject:[root objectForKey:@"userId"] forKey:@"userid"];
                        [[NSUserDefaults standardUserDefaults] setObject:[root objectForKey:@"firstName"] forKey:@"first_name"];
                        [[NSUserDefaults standardUserDefaults] setObject:[root objectForKey:@"lastName"] forKey:@"last_name"];
                        [[NSUserDefaults standardUserDefaults] setObject:[root objectForKey:@"profilePicture"] forKey:@"profile-picture"];
                        [[NSUserDefaults standardUserDefaults] setObject:[root objectForKey:@"isCompleteSenderProfile"] forKey:@"isSenderProfileComplete"];
                        [[NSUserDefaults standardUserDefaults] setObject:[root objectForKey:@"isCompleteSPProfile"] forKey:@"isServiceProviderProfileComplete"];
                        [[NSUserDefaults standardUserDefaults] setObject:[root objectForKey:@"isServiceProvider"] forKey:@"isServiceProvider"];
                        [[NSUserDefaults standardUserDefaults] setObject:[root objectForKey:@"isSender"] forKey:@"isSender"];
                        NSDictionary *tmpDict = (NSDictionary*)sender;
                        if ([tmpDict count]>0) {
                            [[NSUserDefaults standardUserDefaults] setObject:[tmpDict objectForKey:@"username"] forKey:@"username"];
                            [[NSUserDefaults standardUserDefaults] setObject:[tmpDict objectForKey:@"password"] forKey:@"password"];
                        }
                        [[NSUserDefaults standardUserDefaults] synchronize];
                        
                        if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"UserLogedInType"] intValue] == LoginTypeGZNative){
                            [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                                            type:AJNotificationTypeBlue
                                                           title:[root objectForKey:@"message"]
                                                 linedBackground:AJLinedBackgroundTypeDisabled
                                                       hideAfter:GZAJNotificationDelay];
                        }
                        return_block(TRUE);
                        }
                    else {
                        [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                                        type:AJNotificationTypeRed
                                                       title:[root objectForKey:@"message"]
                                             linedBackground:AJLinedBackgroundTypeDisabled
                                                   hideAfter:GZAJNotificationDelay];
                        return_block(FALSE);
                    }}
            }];
            [request setFailedBlock:^{
                NSError *error = [request error];
                NSLog(@"Error: %@",error.localizedDescription);
                [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                                type:AJNotificationTypeRed
                                               title:error.localizedDescription
                                     linedBackground:AJLinedBackgroundTypeDisabled
                                           hideAfter:GZAJNotificationDelay];
                return_block(FALSE);
            }];
            NSLog(@"loginDictionary: %@",loginfbDictionary);
        }
    }
}

- (void)LoginRequired:(id)sender {

    loginVC=[[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:loginVC];
    [sideMenuController disable];
    [sideMenuController changeContentViewController:navigationController closeMenu:YES];
    [sideMenuController changeMenuViewController:nil closeMenu:YES];
}


#pragma mark- for completing user profile
-(void)CompleteProfile{
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"UserLogedInType"] intValue] == LoginTypeGZNative){
        NSLog(@"Login as:%d",[[[NSUserDefaults standardUserDefaults] valueForKey:@"LoginAs"] boolValue]);
        if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"LoginAs"] isEqual:Sender]) {
            PaymentViewController *paymentVC=[[PaymentViewController alloc]initWithNibName:@"PaymentViewController" bundle:nil];
            UINavigationController *navController=[[UINavigationController alloc]initWithRootViewController:paymentVC];
            MenuViewController *menuVC = [[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil];
            [sideMenuController disable];
            [sideMenuController  changeMenuViewController:menuVC closeMenu:YES];
            [sideMenuController changeContentViewController:navController closeMenu:YES];
        }
        else{
            ServiceProviderProfileViewController *serviceProviderVC=[[ServiceProviderProfileViewController alloc]init];
            UINavigationController *navController=[[UINavigationController alloc]initWithRootViewController:serviceProviderVC];
            MenuViewController *menuVC = [[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil];
            [sideMenuController disable];
            [sideMenuController  changeMenuViewController:menuVC closeMenu:YES];
            [sideMenuController changeContentViewController:navController closeMenu:YES];
        }
    }
    if([[[NSUserDefaults standardUserDefaults] valueForKey:@"UserLogedInType"] intValue] == LoginTypeFacebook){
       // NSLog(@"nsdefault %d",[[[NSUserDefaults standardUserDefaults] valueForKey:@"service-provider"] boolValue]);
        if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"LoginAs"] isEqual:Sender]) {
            PaymentViewController *paymentVC=[[PaymentViewController alloc]initWithNibName:@"PaymentViewController" bundle:nil];
            UINavigationController *navController=[[UINavigationController alloc]initWithRootViewController:paymentVC];
            MenuViewController *menuVC = [[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil];
            [sideMenuController disable];
            [sideMenuController  changeMenuViewController:menuVC closeMenu:YES];
            [sideMenuController changeContentViewController:navController closeMenu:YES];
        }
        else{
            ServiceProviderProfileViewController *serviceProviderVC=[[ServiceProviderProfileViewController alloc]init];
            UINavigationController *navController=[[UINavigationController alloc]initWithRootViewController:serviceProviderVC];
            MenuViewController *menuVC = [[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil];
            [sideMenuController disable];
            [sideMenuController  changeMenuViewController:menuVC closeMenu:YES];
            [sideMenuController changeContentViewController:navController closeMenu:YES];
        }
        
    }
    
}



- (void)LoadTabBar {
    
    gratuityVC = [[GratuityViewController alloc] initWithNibName:@"GratuityViewController" bundle:nil];
    historyVC = [[HistoryViewController alloc] initWithNibName:@"HistoryViewController" bundle:nil];
    // myaccountVC = [[MyAccountViewController alloc] initWithNibName:@"MyAccountViewController" bundle:nil];
    myaccount=[[MyAccountView alloc]initWithNibName:@"MyAccountView" bundle:nil];
    tabBar = [[UITabBarController alloc]init];
    [tabBar setDelegate:self];
    //tabBar.tabBar.frame=CGRectMake(0, 528, 320, 40);
    tabBar.tabBar.tintColor=[UIColor whiteColor];
    CGRect frame = CGRectMake(0, 0, 320, 50);
    tabBarBg = [[UIView  alloc] initWithFrame:frame];
	UIImage *tabBarBackgroundImage = [UIImage imageNamed:@"bottom_bar.png"];
    tabBar.delegate=self;
    if([[[UIDevice currentDevice] systemVersion] floatValue]>4.9)
    {    [tabBar tabBar].backgroundImage = tabBarBackgroundImage;}
    else
    {        [tabBarBg setBackgroundColor:[[UIColor alloc] initWithPatternImage:tabBarBackgroundImage]];}
    
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed: @"top_bar"] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UIBarButtonItem appearance] setTitleTextAttributes:textAttributesTabBar forState:UIControlStateNormal];
    
    navBar1.viewControllers = [NSArray arrayWithObjects:gratuityVC,nil];
    
    
    navBar2.viewControllers = [NSArray arrayWithObjects:historyVC,nil];
    //navBar2.title = @"Search";
    //navBar3.title = @"My Account";
    // navBar3.navigationItem.rightBarButtonItem=btnHelp;
    
    navBar3.viewControllers = [NSArray arrayWithObjects:myaccount,nil];
    
    tabBar.viewControllers = [NSArray arrayWithObjects:navBar1,navBar2,navBar3,nil];
    [[tabBar.tabBar.items objectAtIndex:0] setTitle:@"Gratuity"];
    [[tabBar.tabBar.items objectAtIndex:0] setTitlePositionAdjustment:UIOffsetMake(0.0, -15.0)];
    [[tabBar.tabBar.items objectAtIndex:1] setTitle:@"Search"];
    [[tabBar.tabBar.items objectAtIndex:1] setTitlePositionAdjustment:UIOffsetMake(0.0, -15.0)];
    [[tabBar.tabBar.items objectAtIndex:2] setTitle:@"My Account"];
    [[tabBar.tabBar.items objectAtIndex:2] setTitlePositionAdjustment:UIOffsetMake(0.0, -15.0)];
    tabBar.selectedIndex=0;
    
    navBar1.navigationBar.translucent = YES;
    navBar2.navigationBar.translucent = YES;
    navBar3.navigationBar.translucent = YES;
    
    
    
    for(UIViewController *tab in  self.tabBar.viewControllers)
        
    {
        [tab.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                [UIFont fontWithName:GZFont size:18.0f], NSFontAttributeName,[UIColor whiteColor], NSForegroundColorAttributeName, nil]
                                      forState:UIControlStateNormal];
    }
    
    
}

-(IBAction)btnHelpAction:(id)sender{
    NSLog(@"Help button called");
    HelpViewController *HVC=[[HelpViewController alloc]init];
    [self.tabBar presentViewController:HVC animated:YES completion:nil];
}

- (BOOL)tabBarController:(UITabBarController*)tabBarController shouldSelectViewController:(UIViewController*)viewController __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_3_0) {
	return YES;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
	NSInteger tabIndex = tabBarController.selectedIndex;
    NSLog(@"tabbabr%@",tabBarController.tabBar.selectedItem.title);
	if (tabIndex == 0) {
        UIImage *tabBarBackgroundImage = [UIImage imageNamed:@"bottom_bar.png"];
        if([[[UIDevice currentDevice] systemVersion] floatValue]>4.9){
            [tabBarController tabBar].backgroundImage = tabBarBackgroundImage;
            //  [ [tabBar.tabBarController.tabBar appearance] setTitleVerticalPositionAdjustment:-20 forBarMetrics:UIBarMetricsDefault];
            
        }
        else{
            [tabBarBg setBackgroundColor:[[UIColor alloc] initWithPatternImage:tabBarBackgroundImage]];
        }
	}
    else if (tabIndex == 1) {
        UIImage *tabBarBackgroundImage = [UIImage imageNamed:@"bottom_bar"];
        if([[[UIDevice currentDevice] systemVersion] floatValue]>4.9){
            [tabBarController tabBar].backgroundImage = tabBarBackgroundImage;
        }
        else{
            [tabBarBg setBackgroundColor:[[UIColor alloc] initWithPatternImage:tabBarBackgroundImage]];
        }
	}
    else if (tabIndex == 2) {
        UIImage *tabBarBackgroundImage = [UIImage imageNamed:@"bottom_bar"];
        if([[[UIDevice currentDevice] systemVersion] floatValue]>4.9){
            [tabBarController tabBar].backgroundImage = tabBarBackgroundImage;
        }
        else{
            [tabBarBg setBackgroundColor:[[UIColor alloc] initWithPatternImage:tabBarBackgroundImage]];
        }
	}
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}
- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}
- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}
- (void)applicationDidBecomeActive:(UIApplication *)application {
    [FBAppEvents activateApp];
    [FBAppCall handleDidBecomeActiveWithSession:self.session];
}
- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [self.session close];
}

@end


