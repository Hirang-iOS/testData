//
//  AppDelegate.h
//  GratZeez
//
//  Created by cloudZon Infosoft on 14/10/13.
//  Copyright (c) 2013 cloudZon Infosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import<Foundation/Foundation.h>
//#import <FacebookSDK/FacebookSDK.h>
#import <FacebookSDK/FacebookSDK.h>
#import <AudioToolbox/AudioToolbox.h>
#import "ServiceProviderProfileViewController.h"
#import "EstablishmentViewController.h"
//#import "EstablishmentDetailViewController.h"
#import "RegistrationViewController.h"
@class RegistrationViewController;
@class ServiceProviderProfileViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate,UITabBarControllerDelegate>
{
    NSMutableArray *searchResultArray;
    NSMutableArray *locationData;
    UIImage *imgData;
    NSString *work;
    EstablishmentViewController *EVC;
    //EstablishmentDetailViewController *EVC;
    BOOL isServiceProvider;
    UINavigationController *navBar1,*navBar2,*navBar3;
}
//b90788cd69d880c0727691c3e74bcb6176b39ec9
@property(nonatomic,strong)UINavigationController *navBar1;
@property(nonatomic,strong)UINavigationController *navBar2;
@property(nonatomic,strong)UINavigationController *navBar3;
@property(nonatomic)BOOL isServiceProvider;
@property(strong,nonatomic)EstablishmentViewController *EVC;
@property(retain,nonatomic) NSString *work;
@property(retain,nonatomic) UIImage *imgData;
@property (strong, nonatomic) UIWindow *window;
@property (retain, nonatomic) UITabBarController *tabBar;
@property(nonatomic,retain)NSMutableArray *searchResultArray;
@property(nonatomic,copy)NSMutableArray *locationData;
@property (strong, nonatomic) FBSession *session;
@property (nonatomic,assign) BOOL isUserSessionStart;
@property (nonatomic) BOOL isIpad;
@property (nonatomic) BOOL isiPhone5,loginDismiss;

- (void)ClearLoginData;
- (NSString*)md5HexDigest:(NSString*)input;
- (void)LoginRequired:(id)sender;
- (void)openSessionWithAllowLoginUI:(BOOL)allowLoginUI completionBlock:(void(^)(BOOL result))return_back;
- (void)AutoSignIn:(id)sender completionBlock:(void (^)(BOOL result)) return_block;
-(void)CompleteProfile;
@end
