//
//  MenuViewController.m
//  GratZeez
//
//  Created by cloudZon Infosoft on 23/01/14.
//  Copyright (c) 2014 cloudZon Infosoft. All rights reserved.
//

#import "MenuViewController.h"
#import "SideMenuController.h"
#import  "HistoryViewController.h"
//#import "LoginViewController.h"
#import "GratuityViewController.h"
#import "MyAccountView.h"
#import "LoginViewController.h"
@interface MenuViewController ()

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *menuItems;

@end

@implementation MenuViewController

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
    NSLog(@"%@",[[NSUserDefaults standardUserDefaults] dictionaryRepresentation]);
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"MenuCell"];
    
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"LoginAs"] isEqual:Sender]) {
    
        if([[[NSUserDefaults standardUserDefaults] valueForKey:@"isServiceProvider"] boolValue]==1 && [[[NSUserDefaults standardUserDefaults] valueForKey:@"isSenderProfileComplete"] boolValue]==1){
            self.menuItems = @[@"Search for Service Provider", @"Gratuity", @"My Account",@"ServiceProvider Profile",@"Logout",];
        }
        else if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"isServiceProvider"] boolValue]==1 && [[[NSUserDefaults standardUserDefaults] valueForKey:@"isSenderProfileComplete"] boolValue]==0){
            self.menuItems=@[@"ServiceProvider Profile",@"Logout"];
        }
        else if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"isServiceProvider"] boolValue]==0 && [[[NSUserDefaults standardUserDefaults] valueForKey:@"isSenderProfileComplete"] boolValue]==1){
            self.menuItems = @[@"Search for Service Provider", @"Gratuity", @"My Account",@"Logout"];
        }
        else if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"isServiceProvider"] boolValue]==0 && [[[NSUserDefaults standardUserDefaults] valueForKey:@"isSenderProfileComplete"] boolValue]==0){
            self.menuItems = @[@"Logout"];
        }
    }
    
    else if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"LoginAs"] isEqual:ServiceProvider]){
      if([[[NSUserDefaults standardUserDefaults] valueForKey:@"isSender"] boolValue]==1 && [[[NSUserDefaults standardUserDefaults] valueForKey:@"isServiceProviderProfileComplete"] boolValue]==1){
        self.menuItems = @[@"Gratuity", @"History", @"My Account",@"Customer Profile",@"Logout"];
      }
      else if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"isSender"] boolValue]==1 && [[[NSUserDefaults standardUserDefaults] valueForKey:@"isServiceProviderProfileComplete"] boolValue]==0){
          self.menuItems = @[@"Customer Profile",@"Logout"];
      }
      else if([[[NSUserDefaults standardUserDefaults] valueForKey:@"isSender"] boolValue]==0 && [[[NSUserDefaults standardUserDefaults] valueForKey:@"isServiceProviderProfileComplete"] boolValue]==1){
            self.menuItems = @[@"Gratuity", @"History", @"My Account",@"Logout"];
        }
        else if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"isSender"] boolValue]==0 &&[[[NSUserDefaults standardUserDefaults] valueForKey:@"isServiceProviderProfileComplete"] boolValue]==0){
            self.menuItems=@[@"Logout"];
        }
    }
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark – UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return self.menuItems.count;
}
-(UIView *)selectedCellView{
    UIView *cellView=[[UIView alloc]init];
    cellView.backgroundColor=RGB(155,130,110);
    return cellView;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *cellIdentifier = @"MenuCell";
	tableView.separatorInset=UIEdgeInsetsZero;
    tableView.backgroundColor=RGB(210, 200, 191);
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	cell.backgroundColor=RGB(210, 200, 191);
    cell.selectedBackgroundView=[self selectedCellView];
    UIView *view_cell=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
    view_cell.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"carrot"]];
	NSString *item = [self.menuItems objectAtIndex:indexPath.row];
    UIView *v=[[UIView alloc]initWithFrame:CGRectMake(0, 44, 220, 1)];
    v.backgroundColor=[UIColor whiteColor];
    v.tag=1;
    [cell.contentView addSubview:v];
    UILabel *itemLabel=[[UILabel alloc]initWithFrame:CGRectMake(5, 5, 190, 30)];
//	[cell.textLabel setText:item];
    itemLabel.text=item;
//    itemLabel.textAlignment=NSTextAlignmentCenter;
    cell.accessoryView=view_cell;
    itemLabel.font=[UIFont fontWithName:GZFont size:15.0f];
	[cell.contentView addSubview:itemLabel];
    return cell;
}

#pragma mark – UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //when user have only one profile enabled
    if([self.menuItems count]==1){
        if(indexPath.row==0){
        [[self sideMenuController] closeMenu];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                        message:@"Confirm Logout?"
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:@"Logout", nil];
        alert.tag=1;
        [alert show];
        }
    }
    
    //when user have both profile enabled but not completed his/her profile
    else if ([self.menuItems count]==2){
              //Looged in as sender so first item will be serviceProvider profile
       
        if(indexPath.row==0){
                NSLog(@"to first row");
                if([[[NSUserDefaults standardUserDefaults] valueForKey:@"LoginAs"] isEqual:Sender]){

                
                if([[[NSUserDefaults standardUserDefaults] valueForKey:@"isServiceProviderProfileComplete"] boolValue]==0){
                  [[NSUserDefaults standardUserDefaults] setValue:ServiceProvider forKey:@"LoginAs"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    [MyAppDelegate CompleteProfile];
                    return;
                  
                }
                else{
                   
                     [[NSUserDefaults standardUserDefaults] setValue:ServiceProvider forKey:@"LoginAs"];
                    [[NSUserDefaults standardUserDefaults]synchronize];
                    UINavigationController *navigationController;
                    MenuViewController *menuVC;
                    GratuityViewController *gratuityVC=[[GratuityViewController alloc] initWithNibName:@"GratuityViewController" bundle:nil];
                    navigationController = [[UINavigationController alloc] initWithRootViewController:gratuityVC ];
                    menuVC = [[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil];
                    [[self sideMenuController ] changeContentViewController:navigationController closeMenu:YES];
                    [[self sideMenuController ] changeMenuViewController:menuVC closeMenu:YES];
                }
              
            }
        
        else if([[[NSUserDefaults standardUserDefaults] valueForKey:@"LoginAs"] isEqual:ServiceProvider]){
        //Logged in as serviceProvider so first item will be sender profile

                if([[[NSUserDefaults standardUserDefaults] valueForKey:@"isSenderProfileComplete"] boolValue]==0){
                    [[NSUserDefaults standardUserDefaults] setObject:Sender forKey:@"LoginAs"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    [MyAppDelegate CompleteProfile];
                    return;
                }
                else{
                    [[NSUserDefaults standardUserDefaults] setObject:Sender forKey:@"LoginAs"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    HistoryViewController *historyVC = [[HistoryViewController alloc] initWithNibName:@"HistoryViewController" bundle:nil];
                    UINavigationController *navigationController1 = [[UINavigationController alloc] initWithRootViewController:historyVC];
                    MenuViewController *menuVC1 = [[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil];
                    [[self sideMenuController] changeContentViewController:navigationController1 closeMenu:YES];
                    [[self sideMenuController] changeMenuViewController:menuVC1 closeMenu:YES];
                    
                }
                       }
            }
        
        //Second will be logout button
        if(indexPath.row==1){
            [[self sideMenuController] closeMenu];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                            message:@"Confirm Logout?"
                                                           delegate:self
                                                  cancelButtonTitle:@"Cancel"
                                                  otherButtonTitles:@"Logout", nil];
            alert.tag=1;
            [alert show];
        }
        
    }
    
    else if([self.menuItems count]==4){
        if(indexPath.row==0){
            if([[[NSUserDefaults standardUserDefaults] valueForKey:@"LoginAs"] isEqual:Sender]){
                HistoryViewController *historyVC = [[HistoryViewController alloc] initWithNibName:@"HistoryViewController" bundle:nil];
                UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:historyVC];
                [[self sideMenuController] changeContentViewController:navigationController closeMenu:YES];
            }
            else if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"LoginAs"] isEqual:ServiceProvider]){
                GratuityViewController *gratuityVC = [[GratuityViewController alloc] initWithNibName:@"GratuityViewController" bundle:nil];
                UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:gratuityVC];
                [[self sideMenuController] changeContentViewController:navigationController closeMenu:YES];
            }
        }
        else if(indexPath.row==1){
            if([[[NSUserDefaults standardUserDefaults] valueForKey:@"LoginAs"] isEqual:Sender]){
                GratuityViewController *gratuityVC = [[GratuityViewController alloc] initWithNibName:@"GratuityViewController" bundle:nil];
                UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:gratuityVC];
                [[self sideMenuController] changeContentViewController:navigationController closeMenu:YES];
            }
            else if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"LoginAs"] isEqual:ServiceProvider]){
                HistoryViewController *historyVC = [[HistoryViewController alloc] initWithNibName:@"HistoryViewController" bundle:nil];
                UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:historyVC];
                [[self sideMenuController] changeContentViewController:navigationController closeMenu:YES];
            }
        }
        else if (indexPath.row==2){
            MyAccountView *myAccountVC = [[MyAccountView alloc] initWithNibName:@"MyAccountView" bundle:nil];
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:myAccountVC];
            [[self sideMenuController] changeContentViewController:navigationController closeMenu:YES];
        }
        else if (indexPath.row==3){
            [[self sideMenuController] closeMenu];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                            message:@"Confirm Logout?"
                                                           delegate:self
                                                  cancelButtonTitle:@"Cancel"
                                                  otherButtonTitles:@"Logout", nil];
            alert.tag=1;
            [alert show];
        }
    }
    
    else{
 	if(indexPath.row==0){
        if([[[NSUserDefaults standardUserDefaults] valueForKey:@"LoginAs"] isEqual:Sender]){
        HistoryViewController *historyVC = [[HistoryViewController alloc] initWithNibName:@"HistoryViewController" bundle:nil];
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:historyVC];
        [[self sideMenuController] changeContentViewController:navigationController closeMenu:YES];
        }
        else if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"LoginAs"] isEqual:ServiceProvider]){
            GratuityViewController *gratuityVC = [[GratuityViewController alloc] initWithNibName:@"GratuityViewController" bundle:nil];
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:gratuityVC];
            [[self sideMenuController] changeContentViewController:navigationController closeMenu:YES];
        }
    }
    else if(indexPath.row==1){
        if([[[NSUserDefaults standardUserDefaults] valueForKey:@"LoginAs"] isEqual:Sender]){
            GratuityViewController *gratuityVC = [[GratuityViewController alloc] initWithNibName:@"GratuityViewController" bundle:nil];
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:gratuityVC];
            [[self sideMenuController] changeContentViewController:navigationController closeMenu:YES];
        }
        else if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"LoginAs"] isEqual:ServiceProvider]){
            HistoryViewController *historyVC = [[HistoryViewController alloc] initWithNibName:@"HistoryViewController" bundle:nil];
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:historyVC];
            [[self sideMenuController] changeContentViewController:navigationController closeMenu:YES];
        }
    }
    else if (indexPath.row==2){
        
        MyAccountView *myAccountVC = [[MyAccountView alloc] initWithNibName:@"MyAccountView" bundle:nil];
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:myAccountVC];
        [[self sideMenuController] changeContentViewController:navigationController closeMenu:YES];
    }
    else if (indexPath.row==3){
        UINavigationController *navigationController;
        MenuViewController *menuVC;
        if([[[NSUserDefaults standardUserDefaults] valueForKey:@"LoginAs"] isEqual:Sender]){
        [[NSUserDefaults standardUserDefaults] setValue:ServiceProvider forKey:@"LoginAs"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            if([[[NSUserDefaults standardUserDefaults] valueForKey:@"isServiceProviderProfileComplete"] boolValue]==0){
                [MyAppDelegate CompleteProfile];
                return;
            }
            else{
            GratuityViewController *gratuityVC=[[GratuityViewController alloc] initWithNibName:@"GratuityViewController" bundle:nil];
            navigationController = [[UINavigationController alloc] initWithRootViewController:gratuityVC ];
            menuVC = [[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil];
            }
        }
        else if([[[NSUserDefaults standardUserDefaults] valueForKey:@"LoginAs"] isEqual:ServiceProvider]){
            [[NSUserDefaults standardUserDefaults] setValue:Sender forKey:@"LoginAs"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            if([[[NSUserDefaults standardUserDefaults] valueForKey:@"isSenderProfileComplete"] boolValue]==0){
                [MyAppDelegate CompleteProfile];
                return;
            }
            else{
            HistoryViewController *historyVC = [[HistoryViewController alloc] initWithNibName:@"HistoryViewController" bundle:nil];
            navigationController = [[UINavigationController alloc] initWithRootViewController:historyVC];
            menuVC = [[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil];
        }
        }
        [[self sideMenuController ] changeContentViewController:navigationController closeMenu:YES];
        [[self sideMenuController ] changeMenuViewController:menuVC closeMenu:YES];
    }
    else if (indexPath.row==4){
        [[self sideMenuController] closeMenu];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                        message:@"Confirm Logout?"
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:@"Logout", nil];
        alert.tag=1;
        [alert show];
    }

    }
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    
        //set cell horizontal saparator view color of selected cell bcoz when cell selected all view color is gone
        UIView *hSeparatorview1=[selectedCell viewWithTag:1];
        hSeparatorview1.backgroundColor = [UIColor whiteColor];
        UIImageView *accessoryImage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"carrot"]];
        selectedCell.accessoryView=accessoryImage;

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag==1) {
        if (buttonIndex == 1) {
            [MyAppDelegate ClearLoginData];
            LoginViewController *mvc=[[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:mvc];
            [[self sideMenuController] disable];
            [[self sideMenuController] changeContentViewController:navigationController closeMenu:YES];
            [[self sideMenuController] changeMenuViewController:nil closeMenu:YES];
        }
    }
}
@end
