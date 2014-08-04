//
//  SearchedResultViewController.m
//  GratZeez
//
//  Created by cloudZon Infosoft on 29/01/14.
//  Copyright (c) 2014 cloudZon Infosoft. All rights reserved.
//

#import "SearchedResultViewController.h"
#import "UIImageView+AFNetworking.h"
#import "SearchResultCell.h"
@interface SearchedResultViewController ()

@end

@implementation SearchedResultViewController
@synthesize tempArray,searchResultToolbar;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *btnHelp = [[UIBarButtonItem alloc] initWithTitle:@"Help" style:UIBarButtonItemStylePlain target:self action:@selector(btnHelpAction:)];
    self.navigationItem.rightBarButtonItem=btnHelp;
    // NSDictionary* textAttributes = [NSDictionary dictionaryWithObject: [UIColor whiteColor]
    //                                                           forKey: NSForegroundColorAttributeName];
    //[btnHelp setTitleTextAttributes:textAttributes forState:UIControlStateNormal];
    [[UIBarButtonItem appearance] setTitleTextAttributes:textAttributesTabBar forState:UIControlStateNormal];
    self.title = @"Search Result";
    NSLog(@"search result loaded");
    tempArray=[[NSMutableArray alloc]init];
    tempArray=[MyAppDelegate.searchResultArray mutableCopy];
    self.view.backgroundColor=RGB(210, 200, 191);
    
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    
    [self.view addSubview:searchResultToolbar];
    UIButton *backBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 36, 21)];
    [backBtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    UIBarButtonItem *btnitem=[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    searchResultToolbar.items=@[btnitem];
    [searchResultToolbar setBackgroundImage:toolBarImage forToolbarPosition:UIBarPositionBottom barMetrics:UIBarMetricsDefault];
    [self addLeftMenuButtonWithImage:[UIImage imageNamed:@"menu_icon"]];
    [self addrightMenuButtonWithImage:[UIImage imageNamed:@"help"]];
    
    UISwipeGestureRecognizer *rightRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(backAction:)];
    rightRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [rightRecognizer setNumberOfTouchesRequired:1];
    [self.view addGestureRecognizer:rightRecognizer];
}
-(void)viewWillAppear:(BOOL)animated{
    if(self.view.frame.origin.y==0){
    searchResultToolbar.frame=CGRectMake(0,524, 320, 44);
    }
    if(self.view.frame.origin.y==64){
        searchResultToolbar.frame=CGRectMake(0,460, 320, 44);
    }
   
}
//-(void)viewDidAppear:(BOOL)animated{
//     NSLog(@"===>%f %f %f %f",searchResultToolbar.frame.size.height,searchResultToolbar.frame.origin.y,self.view.frame.origin.y,self.view.frame.size.height);
//}
//- (void)rightSwipeHandle:(UISwipeGestureRecognizer*)gestureRecognizer
//{ [self.navigationController popViewControllerAnimated:YES];
//    NSLog(@"rightSwipeHandle");
//}


-(IBAction)backAction:(id)sender{
    NSLog(@"ok");
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)btnHelpAction:(id)sender{
    [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                    type:AJNotificationTypeRed
                                   title:@"Coming Soon"
                         linedBackground:AJLinedBackgroundTypeDisabled
                               hideAfter:GZAJNotificationDelay];
    return ;
    HelpViewController *HVC=[[HelpViewController alloc]init];
    UINavigationController *helpNavController=[[UINavigationController alloc]initWithRootViewController:HVC];
    [self presentViewController:helpNavController animated:YES completion:nil];}

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


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [MyAppDelegate.searchResultArray count];
    // return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;    //changes
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

-(UIView *)selectedCellView{
    UIView *cellView=[[UIView alloc]init];
    cellView.backgroundColor=RGB(155,130,110);
    return cellView;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    tableView.separatorInset=UIEdgeInsetsZero;
    self.edgesForExtendedLayout=UIRectEdgeNone;
    tableView.backgroundColor=RGB(210, 200, 191);
    SearchResultCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchResultCell"];
    NSArray *tempSearchArray=[tempArray objectAtIndex:indexPath.section];
    if (cell == nil) {
        NSArray *topLevelObject;
        topLevelObject = [[NSBundle mainBundle] loadNibNamed:@"SearchResultCell" owner:self options:nil];
        cell = [topLevelObject objectAtIndex:0];
        cell.backgroundColor=RGB(210, 200, 191);
        cell.selectedBackgroundView=[self selectedCellView];
    }
    NSLog(@"%@",[tempSearchArray objectAtIndex:0]);
    NSLog(@"%@",[tempSearchArray objectAtIndex:1]);
    cell.lblUsername.text = [tempSearchArray objectAtIndex:0];
    cell.lblUsername.font=[UIFont fontWithName:GZFont size:14.0f];
    cell.lblNumber.text = [tempSearchArray objectAtIndex:9];
    cell.lblNumber.font=[UIFont fontWithName:GZFont size:14.0f];
    if([tempSearchArray objectAtIndex:2]==[NSNull null])
    {
        NSLog(@"nullll");
        cell.lblFirst_name.text=@"";
    }
    else{
        cell.lblFirst_name.text = [[tempSearchArray objectAtIndex:2] stringByAppendingFormat:@"  %@",[tempSearchArray objectAtIndex:3]];
        cell.lblFirst_name.font=[UIFont fontWithName:GZFont size:14.0f];
    }
    service_providerId=[[tempSearchArray objectAtIndex:4] stringValue];
    
    NSString *urlString=[ImageURL stringByAppendingPathComponent:[tempSearchArray objectAtIndex:6]];
    cell.imgIcon.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]]];
    cell.imgIcon.layer.cornerRadius = 3.0;
    cell.imgIcon.layer.masksToBounds = YES;
    
    if([[tempSearchArray objectAtIndex:7] boolValue]==1){
        DYRateView *rateView = [[DYRateView alloc] initWithFrame:CGRectMake(90, 75, 120, 20)
                                                        fullStar:[UIImage imageNamed:@"StarFullLarge.png"]
                                                       emptyStar:[UIImage imageNamed:@"StarEmptyLarge.png"]];
        rateView.padding = 2;
        rateView.rate =[[tempSearchArray objectAtIndex:5] floatValue];
        //NSLog(@"rating value%f",[[tempSearchArray objectAtIndex:4] floatValue]);
        rateView.alignment = RateViewAlignmentCenter;
        rateView.delegate = self;
        rateView.editable = NO;
        [cell addSubview:rateView];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SearchedProfileViewController *profileVC=[[SearchedProfileViewController alloc]init];
    profileVC.cellId=indexPath.section;
    NSArray *objectArray=[tempArray objectAtIndex:indexPath.section];
    ASIFormDataRequest *_request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:URLGetIsFavorite]];
    __unsafe_unretained ASIFormDataRequest *request = _request;
    [request setDelegate:self];
    NSDictionary *serviceProviderInfoDict=[[NSDictionary alloc]initWithObjectsAndKeys:[objectArray objectAtIndex:4],@"serviceProviderId",[[NSUserDefaults standardUserDefaults] valueForKey:@"userid"],@"senderId", nil];
    NSLog(@"serviceDict:%@",serviceProviderInfoDict);
    NSError *error;
    NSData *fetchData=[NSJSONSerialization dataWithJSONObject:serviceProviderInfoDict options:NSJSONWritingPrettyPrinted error:&error];
    [request addRequestHeader:ContentType value:ContentTypeValue];
    [request appendPostData:fetchData];
    [request setCompletionBlock:^{
        NSDictionary *root=[NSJSONSerialization JSONObjectWithData:[request responseData] options:0 error:nil];
        NSLog(@"info root%@",root);
        NSDictionary *dataDict;
        if([root[@"data"] count]==0){
            [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                            type:AJNotificationTypeRed
                                           title:@"Contact Administrator"
                                 linedBackground:AJLinedBackgroundTypeDisabled
                                       hideAfter:GZAJNotificationDelay];
        }
        else{
            dataDict=root[@"data"];
            profileVC.isFavorite=[dataDict[@"isFavourite"] boolValue];
            profileVC.individualRate=dataDict[@"rating"];
            if(dataDict[@"amountToCharity"]==0){
                profileVC.amountToCharity=0;
            }
            else{
                profileVC.amountToCharity=[dataDict[@"amountToCharity"] integerValue];
            }
            [self.navigationController pushViewController:profileVC animated:YES];

        }
        
    }];
    [request startAsynchronous];
    NSLog(@"%d",profileVC.cellId);
    
    //[self presentViewController:profileVC animated:YES completion:nil];
}

- (void)rateView:(DYRateView *)rateView changedToNewRate:(NSNumber *)rate {
    //    self.rateLabel.text = [NSString stringWithFormat:@"Rate: %d", rate.intValue];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
