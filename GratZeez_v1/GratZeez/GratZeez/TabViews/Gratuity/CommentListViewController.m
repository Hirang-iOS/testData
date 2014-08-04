//
//  CommentListViewController.m
//  GratZeez
//
//  Created by cloudZon Infosoft on 08/01/14.
//  Copyright (c) 2014 cloudZon Infosoft. All rights reserved.
//

#import "CommentListViewController.h"

@interface CommentListViewController ()

@end

@implementation CommentListViewController

@synthesize commentListArray,commentListProImage,imageString,lbl_name,nameString,commentToolbar;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"CommentList";
    NSString *urlString=[ImageURL stringByAppendingPathComponent:imageString];
    commentListProImage.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]]];
    commentListProImage.layer.borderWidth=0.5;
    commentListProImage.layer.masksToBounds=YES;
    commentListProImage.layer.cornerRadius=3.0;
    lbl_name.text=nameString;
    lbl_name.font=[UIFont fontWithName:GZFont size:18];
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];
    [[UIBarButtonItem appearance] setTitleTextAttributes:textAttributesTabBar forState:UIControlStateNormal];

    commentToolbar.frame=CGRectMake(0, 524, 320, 44);
    [self.view addSubview:commentToolbar];
    UIButton *backBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 36, 21)];
    [backBtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    UIBarButtonItem *btnitem=[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    commentToolbar.items=@[btnitem];
    [commentToolbar setBackgroundImage:toolBarImage forToolbarPosition:UIBarPositionBottom barMetrics:UIBarMetricsDefault];
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [commentListArray count];
    
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 60.0f;
//}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    return @"Comments:";
//}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 18.0f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01f;
}



- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *header_view=[[UIView alloc]init];
    UILabel *headerTitle=[[UILabel alloc]initWithFrame:CGRectMake(0,-5,90,30)];
    headerTitle.text=@"Comments:";
    headerTitle.textColor=[UIColor whiteColor];
    headerTitle.font=[UIFont fontWithName:GZFont size:16];
    header_view.backgroundColor= RGB(141, 113, 91);
    [header_view addSubview:headerTitle];
    return header_view;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *SimpleTableIdentifier;
    UITableViewCell * cell;
    tableView.contentInset=UIEdgeInsetsZero;
    [tableView setSeparatorInset:UIEdgeInsetsZero];
    tableView.backgroundColor=RGB(210, 200, 191);
    SimpleTableIdentifier = @"SimpleTableIdentifier";
    cell = [tableView  dequeueReusableCellWithIdentifier: nil];
    NSArray *tempArray=[commentListArray objectAtIndex:indexPath.row];
    if(cell == nil) {
        
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:SimpleTableIdentifier];
        cell.backgroundColor=RGB(210, 200, 191);
        UILabel *lbl_comment=[[UILabel alloc]initWithFrame:CGRectMake(3, 0, 315,32)];
        NSLog(@"height:%f",lbl_comment.frame.size.height);
        lbl_comment.numberOfLines=0;
        lbl_comment.lineBreakMode=NSLineBreakByWordWrapping;
        lbl_comment.textAlignment = NSTextAlignmentLeft;
        lbl_comment.font=[UIFont fontWithName:GZFont size:14];
        lbl_comment.text=[tempArray objectAtIndex:0];
        [cell.contentView addSubview:lbl_comment];
        UILabel *lbl_date=[[UILabel alloc]initWithFrame:CGRectMake(235, 25, 120, 20)];
        lbl_date.text=[tempArray objectAtIndex:1];
        lbl_date.textAlignment=NSTextAlignmentLeft;
        lbl_date.font=[UIFont fontWithName:@"Garamond" size:9];
        [cell.contentView addSubview:lbl_date];
        UIView *line=[[UIView alloc]initWithFrame:CGRectMake(0, 41, 320, 1)];
        line.backgroundColor=[UIColor whiteColor];
        [cell.contentView addSubview:line];
        }
    
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *tempArray=[commentListArray objectAtIndex:indexPath.row];
    NSString *text=[tempArray objectAtIndex:0];
    CGSize constraintSize = CGSizeMake(320.0f, MAXFLOAT);  // Make changes in width as per your label requirement.
    
    CGRect textRect = [text boundingRectWithSize:constraintSize
                                         options:NSStringDrawingUsesLineFragmentOrigin
                                      attributes:@{NSFontAttributeName:[UIFont fontWithName:GZFont size:14]}
                                         context:nil];
     size = textRect.size;
    NSLog(@"textSize :: %f",size.height);
    
    
    return 50;
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
