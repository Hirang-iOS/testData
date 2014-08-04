//
//  InviteFriendsViewController.h
//  New Handshake
//
//  Created by Mehul Prabtani on 7/9/13.
//  Copyright (c) 2013 Mehul Prabtani. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import "HelpViewController.h"
#import "Constant.h"
@interface InviteFriendsViewController : UIViewController <UITextViewDelegate,ABPeoplePickerNavigationControllerDelegate,UITextFieldDelegate,UITableViewDelegate> {
    IBOutlet UITableView *table;
    NSString *invite_points;
}

@property(nonatomic,retain)NSString *invite_points;

-(IBAction)btnSendInviteAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIToolbar *inviteuserToolbar;

@end


