//
//  ViewRateViewController.m
//  GratZeez
//
//  Created by cloudZon Infosoft on 06/01/14.
//  Copyright (c) 2014 cloudZon Infosoft. All rights reserved.
//

#import "ViewRateViewController.h"

@interface ViewRateViewController ()

@end

@implementation ViewRateViewController
@synthesize rateListDataArray,viewRateToolbar;
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
    self.title=@"Rating";
    [[UIBarButtonItem appearance] setTitleTextAttributes:textAttributesTabBar forState:UIControlStateNormal];
    
    viewRateToolbar.frame=CGRectMake(0, 524, 320, 44);
    [self.view addSubview:viewRateToolbar];
    UIButton *backBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 36, 21)];
    [backBtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    UIBarButtonItem *btnitem=[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    viewRateToolbar.items=@[btnitem];
    [viewRateToolbar setBackgroundImage:toolBarImage forToolbarPosition:UIBarPositionBottom barMetrics:UIBarMetricsDefault];
    [self addLeftMenuButtonWithImage:[UIImage imageNamed:@"menu_icon"]];
    [self addrightMenuButtonWithImage:[UIImage imageNamed:@"help"]];
    
    UISwipeGestureRecognizer *rightRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(backAction:)];
    rightRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [rightRecognizer setNumberOfTouchesRequired:1];
    [self.view addGestureRecognizer:rightRecognizer];
    // Do any additional setup after loading the view from its nib.
}
-(IBAction)backAction:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
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

#pragma mark - tableview method
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [rateListDataArray count];
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView=[[UIView alloc]init];
    UILabel *header_givenBy=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 100, 40)];
    header_givenBy.text=@"Given By";
    header_givenBy.font=[UIFont fontWithName:GZFont size:18];
    header_givenBy.textColor=[UIColor whiteColor];
    UILabel *header_rate=[[UILabel alloc]initWithFrame:CGRectMake(220, 0, 100, 40)];
    header_rate.text=@"Rating";
    header_rate.textColor=[UIColor whiteColor];
    header_rate.font=[UIFont fontWithName:GZFont size:18];
    [headerView addSubview:header_givenBy];
    [headerView addSubview:header_rate];
    headerView.backgroundColor=RGB(141, 113, 91);
    return headerView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40.0f;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    tableView.backgroundColor=RGB(210, 200, 191);
    NSString *SimpleTableIdentifier;
    UITableViewCell * cell;
    tableView.contentInset=UIEdgeInsetsZero;
    [tableView setSeparatorInset:UIEdgeInsetsZero];
    SimpleTableIdentifier = @"SimpleTableIdentifier";
    cell = [tableView  dequeueReusableCellWithIdentifier: nil];
    
    if(cell == nil) {
        
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:SimpleTableIdentifier];
        cell.backgroundColor=RGB(210, 200, 191);
        }
    
    tempArray=[rateListDataArray objectAtIndex:indexPath.row];
    cell.textLabel.text=[tempArray objectAtIndex:0];
    cell.textLabel.font=[UIFont fontWithName:GZFont size:15];
    DYRateView *rateView = [[DYRateView alloc] initWithFrame:CGRectMake(180, 10, 120, 20)
                                                    fullStar:[UIImage imageNamed:@"StarFullLarge.png"]
                                                   emptyStar:[UIImage imageNamed:@"StarEmptyLarge.png"]];
    rateView.padding = 2;
    rateView.rate =[[tempArray objectAtIndex:1] floatValue];
    rateView.alignment = RateViewAlignmentCenter;
    rateView.editable = NO;
    [cell addSubview:rateView];
    
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
