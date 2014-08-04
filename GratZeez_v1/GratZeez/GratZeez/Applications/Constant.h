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


#define kPayPalClientId @"AVgHbBAudmmDTaEnFHhKWtJQw5a3mOWTfSu97BNdqg9iNr0jB8O9pa8ZC2Xw"
//#define kPayPalReceiverEmail @"mprabtani-facilitator@gmail.com"
#define kPayPalReceiverEmail @"prabtanimehul.86@gmail.com"



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
//#define GZFont @"Avenir-Heavy"
#define GZFont @"Garamond-Bold"
#define GZAJNotificationDelay 2.0f

//[UIFont fontWithName:@"Garamond" size:17];

#define GZPercentage 5

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
#define ServiceProvider @"1"
#define Sender @"0"
#define ContentType @"Content-Type"
#define ContentTypeValue @"application/json"

//#define Location @"http://192.168.1.121:8080/gratzeez/" //khushbu
//#define ImageURL @"http://192.168.1.121:8080/gratzeez/resources/images/profilePictures"

//#define Location @"http://192.168.1.179:9191/gratzeez/"  //jayesh
//#define ImageURL @"http://192.168.1.179:9191/gratzeez/resources/images/profilePictures" //jayesh

#define Location @"http://ec2-54-205-255-99.compute-1.amazonaws.com:9090/GRATZEEZ_API/"  // new live
#define ImageURL @"http://ec2-54-205-255-99.compute-1.amazonaws.com:9090/GRATZEEZ_API/resources/images/profilePictures" //new live

//#define Location @"http://202.131.125.123:8080/GRATZEEZ_API/" //live server

//#define ImageURL @"http://202.131.125.123:8080/GRATZEEZ_API/resources/images/profilePictures" //live server

//#define Location @"http://192.168.1.179:8080/GRATZEEZ_API/"

//#define Location @"http://192.168.1.138:8080/gratzeez/foundation-types/"   //cent os server

//#define Location @"http://ec2-54-237-106-49.compute-1.amazonaws.com:8080/gratzeez/foundation-types/"

#define RGB(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define textAttributes [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont fontWithName:@"Garamond 3 SC" size:20.0f],NSFontAttributeName,nil]
#define textAttributesTabBar [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont fontWithName:@"Garamond-Bold" size:20.0f],NSFontAttributeName,nil]
#define toolBarImage [UIImage imageNamed:@"bottom_bar"]

#define URLNativeLogin Location@"nativeLogin"    //authenticators/login
#define URLFacebookLogin Location@"facebookLogin"
#define URLForgetID Location@"forgotPassword"
#define URLChangePassword Location@"changePassword"
#define URLInviteNewUser Location@"invitation"
#define URLAdvanceSearch Location@"advanceSearch"
#define URLSearchNearBy Location@"nearByLocationSearch"       //"gpsSearch/nearByLocation"
#define URLSearchByLandmark Location@"landmarkList"      //"gpsSearch/locationByLandmark"
#define URLSearchByLandMarkName Location@"searchBylandmarkName"
#define URLPaypalSenderData Location@"senderPaypalInfo"
#define URLRegistration Location@"registration" //userService/createUser
#define URLRatingGratutiyComment Location@"addGratuity"     //"giveGratutiyRatingComment"
#define URLSaveImage Location@"saveImage"
#define URLGetImage Location@"getImage"
#define URLRequestForOrganizationList Location@"organizationList"
#define URLAddAsFavorite Location@"addAsFavorite"
#define URLMyFavorite Location@"favoriteServiceProvider"
#define URLCharityList Location@"getCharityList"
#define URLAddCharity Location@"addCharity"
#define URLEstablishmentList Location@"getEstablishmentList"
#define URLGetIsFavorite Location@"getIsFavorite"
#define URLServiceProviderInfo Location@"serviceProviderInfo"
#define URLGetState Location@"getStateList"
#define URLGetCity Location@"getCityList"
#define URLGetZipCode Location@"getZipcodeList"
#define URLSaveOrganization Location@"completeServiceProviderWorkInfo"
#define URLNewOrganization Location@"organizationInfo"
#define URLGratuityPageInfo Location@"displaySenderGratuity"
#define URLServiceProviderHistory Location@"serviceProviderHistoryOfTotalGratuity"
#define URLServiceProviderDetailHistory Location@"detailHistoryOfServiceProviderGratuity"
#define URLSenderHistory Location@"senderHistoryOfTotalGratuity"
#define URLSenderDetailHistory Location@"detailHistoryOfSenderGratuity"
#define URLSenderEditProfile Location@"getSenderEditProfile"
#define URLServiceProviderEditProfile Location@"getServiceProviderEditProfile"
#define URLSaveSenderEditProfile Location@"updateSenderEditProfile"
#define URLSaveServiceProviderEditProfile Location@"updateServiceProviderEditProfile"
#define URLServiceProviderHome Location@"displayServiceProviderGratuityTab"
#define URLViewRate Location@"rateList"
#define URLViewCommentedUserList Location@"commentedUserList"
#define URLViewDetailCommentList Location@"detailCommentList"
#define URLRechargeAccount Location@"rechargeGratzeezBalance"
#define URLGetSenderCurrentBalance Location@"getGratzeezBalance"
#define URLUpdateFaceBookUserType Location@"updateFacebookUser"
#define URLPayLater Location@"laterCompletePaymentInfo"
