//
//  Constant.h
//  GratZeez
//
//  Created by cloudZon Infosoft on 14/10/13.
//  Copyright (c) 2013 cloudZon Infosoft. All rights reserved.
//

#import "AppDelegate.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "AJNotificationView.h"

//#define dateFormat @"dd/MM/yyyy"
#define dateFormat @"dd MMM yyyy"

#define MyAppDelegate ((AppDelegate *)[[UIApplication sharedApplication] delegate])

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

#define DeviceUUID [UIDevice currentDevice].uniqueIdentifier

#ifdef UI_USER_INTERFACE_IDIOM
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#else
#define IS_IPAD false
#endif

#define MULTIPLES (IS_IPAD ? 1.5 : 1)

//#define GZFont @"Thonburi-Bold"
#define GZFont @"Avenir-Heavy"
#define GZAJNotificationDelay 5.0f

typedef enum {
    LoginTypeGZNative = 0,
    LoginTypeFacebook = 1,
    LoginTypeTwitter = 2
} UserLogedInType;

#ifdef __IPHONE_6_0 // iOS6 and later
#define GZTextAlignmentCenter    NSTextAlignmentCenter
#define GZTextAlignmentLeft      NSTextAlignmentLeft
#define GZTextAlignmentRight     NSTextAlignmentRight
#define GZTextTruncationTail     NSLineBreakByTruncatingTail
#define GZTextTruncationMiddle   NSLineBreakByTruncatingMiddle

//    #define GZLineBreakModeCharacterWrap       NSLineBreakModeCharacterWrap
//    #define GZLineBreakModeClip                NSLineBreakModeClip
//    #define GZLineBreakModeHeadTruncation      NSLineBreakModeHeadTruncation
//    #define GZLineBreakModeMiddleTruncation    NSLineBreakModeMiddleTruncation
//    #define GZLineBreakModeTailTruncation      NSLineBreakModeTailTruncation
#define GZLineBreakModeWordWrap            NSLineBreakByWordWrapping

#else // older versions
#define GZTextAlignmentCenter    UITextAlignmentCenter
#define GZTextAlignmentLeft      UITextAlignmentLeft
#define GZTextAlignmentRight     UITextAlignmentRight
#define GZTextTruncationTail     UILineBreakModeTailTruncation
#define GZTextTruncationMiddle   UILineBreakModeMiddleTruncation

//    #define GZLineBreakModeCharacterWrap       UILineBreakModeCharacterWrap
//    #define GZLineBreakModeClip                UILineBreakModeClip
//    #define GZLineBreakModeHeadTruncation      UILineBreakModeHeadTruncation
//    #define GZLineBreakModeMiddleTruncation    UILineBreakModeMiddleTruncation
//    #define GZLineBreakModeTailTruncation      UILineBreakModeTailTruncation
#define GZLineBreakModeWordWrap            UILineBreakModeWordWrap

#endif


//#define Location @"http://funforday.com/api/"
#define Location @"http://universalstreamsolution.com/funforday/api/"

#define	URLHomeScreen Location@"videos/list.json?" //type=homescreen&DisplayDtm=2013-05-20&DeviceID=%27test"






