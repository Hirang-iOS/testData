//
//  WorkLocationViewController.h
//  GratZeez
//
//  Created by cloudZon Infosoft on 14/11/13.
//  Copyright (c) 2013 cloudZon Infosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapViewController.h"
#import "HelpViewController.h"
#import "GratuityViewController.h"
@class MapViewController;
//@protocol WorkLocationDelegate
//@required
//-(CLLocationCoordinate2D)latLongForLocation:(NSString *)lat long:(NSString *)lng;
//@end

@protocol WorkLocationViewDelegate <NSObject>
@required
-(void)workInfo:(NSString *) organization_id name:(NSString *)name tag:(int )tag;

@end

@interface WorkLocationViewController : UIViewController<UITextFieldDelegate,MapViewDelegateMethods,UIPickerViewDelegate,UIPickerViewDataSource>{
    CGPoint originalCenter;
    CLLocationCoordinate2D workCoordinate,changeCoordinate;
    NSString *landMark,*address,*city,*website,*state,*zipcode,*organization,*telephone;
 //   NSString *landMark1,*address1,*city1,*website1,*state,*zipcode,*organization,*telephone;
    NSMutableArray *stateArray,*stateTempArray,*cityArray,*cityTempArray,*zipCodeArray;
    UIPickerView *statePicker,*cityPicker;
    UIView *subview;
    UITapGestureRecognizer *tapGesture;
    UIToolbar *toolBar1;
    NSString *stateId,*cityId;
    int minZipCode,maxZipCode;
    NSMutableArray *zipTempArray,*zipArray;
    NSString *establishId;
    int lblTag,coordinateChangeFlag,isWorkLocationList,textflag;
    
}
@property(assign,nonatomic) BOOL isFromEditProfile;
@property(nonatomic,assign) int lblTag;
- (void)sendLatLongRequestAction:(void(^)(BOOL result))return_block;
//@property(nonatomic,assign)id<WorkLocationDelegate> delegate;
@property(weak)id<WorkLocationViewDelegate> delegate;
@property(nonatomic,strong)NSString *establishId;
@property(nonatomic,strong) NSMutableArray *stateArray;
@property(nonatomic,strong) NSMutableArray *stateTempArray;
@property (weak, nonatomic) IBOutlet UITextField *txtOrganization;
@property (weak, nonatomic) IBOutlet UITextField *txtLandMark;
@property (weak, nonatomic) IBOutlet UITextField *txtAddress;
@property (weak, nonatomic) IBOutlet UITextField *txtCity;
@property (weak, nonatomic) IBOutlet UITextField *txtWebSite;
@property (weak, nonatomic) IBOutlet UITextField *txtZipCode;
@property (weak, nonatomic) IBOutlet UITextField *txtState;
@property (strong, nonatomic) IBOutlet UILabel *stateLbl;
@property (weak, nonatomic) IBOutlet UITextField *txtTelePhone;
@property (strong, nonatomic) IBOutlet UILabel *cityLbl;
@property (strong, nonatomic) IBOutlet UIButton *btn_preview;
@property (strong, nonatomic) IBOutlet UILabel *zipLbl;
- (IBAction)previewAction:(id)sender;
- (IBAction)continueAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIToolbar *workTolbar2;

@end
