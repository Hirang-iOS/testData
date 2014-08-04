//
//  EstablishmentDetailViewController.h
//  GratZeez
//
//  Created by cloudZon Infosoft on 07/01/14.
//  Copyright (c) 2014 cloudZon Infosoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EstablishmentDetailViewController : UIViewController
{
IBOutlet UILabel *lblEstablishment;
UIView *SubView;
NSMutableArray *ary;
UIPickerView *myPickerView,*myPickerView1,*myPickerView2;
UILabel *firstlbl,*lbl1,*lbl2,*worklocation_lbl,*worklocation_lbl1,*worklocation_lbl2;
UIButton *btn,*rm1,*rm2;
UITextField *txt,*txt1,*txt2;
int number_of_textfields;
float space_between_textfield;
float frame_y;
float height_of_component,width_of_lbl;
NSMutableArray *pickerDataArray,*exsitingWorkArray;
NSString *establishmentId1,*establishmentId2,*establishmentId3,*workLocationId1,*workLocationId2,*workLocationId3;
UIToolbar *toolBar;
}
- (IBAction)saveAction:(id)sender;
@property(strong,nonatomic)NSMutableArray *exsitingWorkArray;
@property(weak,nonatomic) id<EstablishmentSaveDelegate> delegate;
@property(strong,nonatomic) UILabel *firstlbl;
@property(strong,nonatomic) UILabel *lbl1;
@property(strong,nonatomic) UILabel *lbl2;
@property(strong,nonatomic) UILabel *worklocation_lbl;
@property(strong,nonatomic) UILabel *worklocation_lbl1;
@property(strong,nonatomic) UILabel *worklocation_lbl2;
@property(strong,nonatomic)NSMutableArray *pickerDataArray;
- (IBAction)go:(id)sender;
@property(strong,nonatomic)UIPickerView *myPickerView,*myPickerView1,*myPickerView2;
@end
