//
//  AppDelegate.m
//  GratZeez
//
//  Created by cloudZon Infosoft on 14/10/13.
//  Copyright (c) 2013 cloudZon Infosoft. All rights reserved.
//

#import "AppDelegate.h"

#import "LoginViewController.h"

#import "GratuityViewController.h"
#import "HistoryViewController.h"
#import "MyAccountViewController.h"

@implementation AppDelegate

@synthesize isUserSessionStart;
@synthesize tabBar;
@synthesize session = _session;

UIView *tabBarBg;

LoginViewController *loginVC;
GratuityViewController *gratuityVC;
HistoryViewController *historyVC;
MyAccountViewController *myaccountVC;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    [self performSelector:@selector(LoadTabBar)];
    self.window.rootViewController = tabBar;

    [self.window makeKeyAndVisible];
    
    [self performAppStartUp:^(BOOL result) {
        if (result) {
            isUserSessionStart = YES;
            [loginVC dismissViewControllerAnimated:YES completion:^{
                
            }];
//            [requests LoadData:nil];
        } else {
            [self ClearLoginData];
            [self LoginRequired:nil];
        }
    }];

    
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1) {
        NSLog(@"IOS6");
    } else {
        NSLog(@"IOS7");
    }
    
    return YES;
}


- (void)openSessionWithAllowLoginUI:(BOOL)allowLoginUI completionBlock:(void(^)(BOOL result))return_back {
    [FBSession openActiveSessionWithReadPermissions:[NSArray arrayWithObjects:@"email",@"basic_info",@"user_birthday",nil]
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
                                                              [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:@"password"];
                                                              [[NSUserDefaults standardUserDefaults] setObject:user forKey:@"FBUserLogedInProfileData"];
                                                              [[NSUserDefaults standardUserDefaults] synchronize];
                                                              
                                                              NSLog(@"FBUser: %@",user);
                                                              [[NSUserDefaults standardUserDefaults] setInteger:LoginTypeFacebook forKey:@"UserLogedInType"];
                                                              [[NSUserDefaults standardUserDefaults] synchronize];
                                                              
                                                              [self AutoSignIn:nil completionBlock:^(BOOL result) {
                                                                  if (result) {
                                                                      return_back(TRUE);
//                                                                      [self.window.rootViewController dismissViewControllerAnimated:YES completion:^{
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
//                                      [[NSNotificationCenter defaultCenter] postNotificationName:FBSessionStateChangedNotification object:session];
                                  }];
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    NSLog(@"application");
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
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"username"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"password"];
    [[NSUserDefaults standardUserDefaults] setInteger:LoginTypeGZNative forKey:@"UserLogedInType"];
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"UserProfileData"]; //Used after signup and incomplete profile
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    //Unregister for APNS
    [[UIApplication sharedApplication] unregisterForRemoteNotifications];
}

- (void)AutoSignIn:(id)sender completionBlock:(void (^)(BOOL result)) return_block {
    ASIFormDataRequest *_request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:@""]];
    __unsafe_unretained ASIFormDataRequest *request = _request;
    
    
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"UserLogedInType"] intValue] == LoginTypeGZNative) {
        NSLog(@"AutoSignIn GratZeez Login");
        [request setPostValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"username"] forKey:@"username"];
        [request setPostValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"password"] forKey:@"password"];
    }
    else if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"UserLogedInType"] intValue] == LoginTypeFacebook) {
        NSLog(@"AutoSignIn Facebook Login");
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"FBUserLogedInProfileData"] != [NSNull null]) {
            NSMutableDictionary *FBUserProfileData = [[NSMutableDictionary alloc] initWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:@"FBUserLogedInProfileData"]];
            
            [request setPostValue:@"facebook" forKey:@"login_via"];
            [request setPostValue:[FBUserProfileData objectForKey:@"id"] forKey:@"fb_user_id"];
            [request setPostValue:[FBUserProfileData objectForKey:@"username"] forKey:@"username"];
            [request setPostValue:[FBUserProfileData objectForKey:@"email"] forKey:@"email"];
            
            [request setPostValue:[FBUserProfileData objectForKey:@"first_name"] forKey:@"first_name"];
            [request setPostValue:[FBUserProfileData objectForKey:@"last_name"] forKey:@"last_name"];
            [request setPostValue:[FBUserProfileData objectForKey:@"gender"] forKey:@"gender"];
            [request setPostValue:[FBUserProfileData objectForKey:@"birthday"] forKey:@"dob"];
        }
    }
    
    
    [request setCompletionBlock:^{
        NSDictionary *root = [NSJSONSerialization JSONObjectWithData:[request responseData] options:0 error:nil];
        NSLog(@"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~root: %@",root);
        if ([root objectForKey:@"signin"] != [NSNull null]) {
            if ([[[root objectForKey:@"signin"] objectForKey:@"success_flag"] intValue]==1) {
                
                NSData *data = [NSKeyedArchiver archivedDataWithRootObject:[root objectForKey:@"signin"]];
                [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"UserProfileData"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                // Add registration for remote notifications //call APNS for registaring device
                [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
                 (UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound)];
                //[[UIApplication sharedApplication] unregisterForRemoteNotifications];
                
                return_block(TRUE);
            }
            else {
                [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                                type:AJNotificationTypeRed
                                               title:[[root objectForKey:@"signin"] objectForKey:@"msg"]
                                     linedBackground:AJLinedBackgroundTypeDisabled
                                           hideAfter:GZAJNotificationDelay];
                return_block(FALSE);
            }
        }
        else {
            [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                            type:AJNotificationTypeRed
                                           title:[[root objectForKey:@"signin"] objectForKey:@"msg"]
                                 linedBackground:AJLinedBackgroundTypeDisabled
                                       hideAfter:GZAJNotificationDelay];
            return_block(FALSE);
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
        return_block(FALSE);
    }];
    [request startAsynchronous];
    
}
- (void)performAppStartUp:(void(^)(BOOL result))return_block {
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




- (void)LoadTabBar {
    gratuityVC = [[GratuityViewController alloc] initWithNibName:@"GratuityViewController" bundle:nil];
    historyVC = [[HistoryViewController alloc] initWithNibName:@"HistoryViewController" bundle:nil];
    myaccountVC = [[MyAccountViewController alloc] initWithNibName:@"MyAccountViewController" bundle:nil];

    tabBar = [[UITabBarController alloc]init];
    [tabBar setDelegate:self];
    
    CGRect frame = CGRectMake(0, 0, 320, 50);
    tabBarBg = [[UIView  alloc] initWithFrame:frame];
	UIImage *tabBarBackgroundImage = [UIImage imageNamed:@"request-tab.png"];
    
    if([[[UIDevice currentDevice] systemVersion] floatValue]>4.9)
        [tabBar tabBar].backgroundImage = tabBarBackgroundImage;
    else
        [tabBarBg setBackgroundColor:[[UIColor alloc] initWithPatternImage:tabBarBackgroundImage]];
    
    float initialRed = 255;
    float initialGreen = 255;
    float initialBlue = 255;
    
    UINavigationController *navBar1 = [[UINavigationController alloc] init];
    navBar1.navigationBar.tintColor = [UIColor colorWithRed:initialRed/255.0f green:initialGreen/255.0f blue:initialBlue/255.0f alpha:1.0f];
    navBar1.viewControllers = [NSArray arrayWithObjects:gratuityVC,nil];
    
    UINavigationController *navBar2 = [[UINavigationController alloc] init];
    navBar2.navigationBar.tintColor = [UIColor colorWithRed:initialRed/255.0f green:initialGreen/255.0f blue:initialBlue/255.0f alpha:1.0f];
    navBar2.viewControllers = [NSArray arrayWithObjects:historyVC,nil];
    
    UINavigationController *navBar3 = [[UINavigationController alloc] init];
    navBar3.navigationBar.tintColor = [UIColor colorWithRed:initialRed/255.0f green:initialGreen/255.0f blue:initialBlue/255.0f alpha:1.0f];
    navBar3.viewControllers = [NSArray arrayWithObjects:myaccountVC,nil];
    
    tabBar.viewControllers = [NSArray arrayWithObjects:navBar1,navBar2,navBar3,nil];
}


- (BOOL)tabBarController:(UITabBarController*)tabBarController shouldSelectViewController:(UIViewController*)viewController __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_3_0) {
	return YES;
}
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
	NSInteger tabIndex = tabBarController.selectedIndex;
	if (tabIndex == 0) {
        UIImage *tabBarBackgroundImage = [UIImage imageNamed:@"request-tab.png"];
        if([[[UIDevice currentDevice] systemVersion] floatValue]>4.9){
            [tabBarController tabBar].backgroundImage = tabBarBackgroundImage;
        }
        else{
            [tabBarBg setBackgroundColor:[[UIColor alloc] initWithPatternImage:tabBarBackgroundImage]];
        }
	}
    else if (tabIndex == 1) {
        UIImage *tabBarBackgroundImage = [UIImage imageNamed:@"rewards-tab.png"];
        if([[[UIDevice currentDevice] systemVersion] floatValue]>4.9){
            [tabBarController tabBar].backgroundImage = tabBarBackgroundImage;
        }
        else{
            [tabBarBg setBackgroundColor:[[UIColor alloc] initWithPatternImage:tabBarBackgroundImage]];
        }
	}
    else if (tabIndex == 2) {
        UIImage *tabBarBackgroundImage = [UIImage imageNamed:@"profile-tab.png"];
        if([[[UIDevice currentDevice] systemVersion] floatValue]>4.9){
            [tabBarController tabBar].backgroundImage = tabBarBackgroundImage;
        }
        else{
            [tabBarBg setBackgroundColor:[[UIColor alloc] initWithPatternImage:tabBarBackgroundImage]];
        }
	}
    else if (tabIndex == 3) {
        UIImage *tabBarBackgroundImage = [UIImage imageNamed:@"settings-tab.png"];
        if([[[UIDevice currentDevice] systemVersion] floatValue]>4.9){
            [tabBarController tabBar].backgroundImage = tabBarBackgroundImage;
        }
        else{
            [tabBarBg setBackgroundColor:[[UIColor alloc] initWithPatternImage:tabBarBackgroundImage]];
        }
	}
}

- (void)LoginRequired:(id)sender {
    loginVC = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    UINavigationController *navigationController = [[UINavigationController alloc]  initWithRootViewController:loginVC];
    [self.tabBar presentViewController:navigationController animated:NO completion:^{
        NSLog(@"Dismiss Login");
    }];

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
