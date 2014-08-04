//
//  Comment_UserListViewController.m
//  GratZeez
//
//  Created by cloudZon Infosoft on 08/01/14.
//  Copyright (c) 2014 cloudZon Infosoft. All rights reserved.
//

#import "Comment_UserListViewController.h"

@interface Comment_UserListViewController ()

@end

@implementation Comment_UserListViewController
@synthesize commentedUserListArray,commentListToolbar;
CommentListViewController *commentVC;
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
    self.title=@"Comment From";
    [[UIBarButtonItem appearance] setTitleTextAttributes:textAttributesTabBar forState:UIControlStateNormal];
    
    commentListToolbar.frame=CGRectMake(0, 524, 320, 44);
    [self.view addSubview:commentListToolbar];
    UIButton *backBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 36, 21)];
    [backBtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    UIBarButtonItem *btnitem=[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    commentListToolbar.items=@[btnitem];
    [commentListToolbar setBackgroundImage:toolBarImage forToolbarPosition:UIBarPositionBottom barMetrics:UIBarMetricsDefault];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [commentedUserListArray count];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.0f;
}

-(UIView *)selectedCellView{
    UIView *cellView=[[UIView alloc]init];
    cellView.backgroundColor=RGB(155,130,110);
    return cellView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    tableView.backgroundColor=RGB(210, 200, 191);
    NSString *SimpleTableIdentifier;
    UITableViewCell * cell;
    tableView.contentInset=UIEdgeInsetsZero;
    [tableView setSeparatorInset:UIEdgeInsetsZero];
    SimpleTableIdentifier = @"SimpleTableIdentifier";
    cell = [tableView  dequeueReusableCellWithIdentifier: nil];
    NSArray *tempArray=[commentedUserListArray objectAtIndex:indexPath.row];
    if(cell == nil) {
        
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:SimpleTableIdentifier];
        cell.backgroundColor=RGB(210, 200, 191);
        cell.selectedBackgroundView=[self selectedCellView];
        UIImageView *imageview=[[UIImageView alloc]initWithFrame:CGRectMake(20, 12, 40, 40)];
        NSString *urlString=[ImageURL stringByAppendingPathComponent:[tempArray objectAtIndex:2]];
        imageview.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]]];
        [cell.contentView addSubview:imageview];
        UILabel *nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(75, 5, 100, 40)];
        nameLabel.text=[tempArray objectAtIndex:1];
        nameLabel.font=[UIFont fontWithName:GZFont size:15];
        [cell.contentView addSubview:nameLabel];
        
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ASIFormDataRequest *_request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:URLViewDetailCommentList]];
    __unsafe_unretained ASIFormDataRequest *request = _request;
    [request setDelegate:self];
    NSArray *tempArray=[commentedUserListArray objectAtIndex:indexPath.row];
    NSDictionary *viewRateDictionary=[[NSDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults] valueForKey:@"userid"],@"service_providerId",[[tempArray objectAtIndex:0] stringValue],@"sender_id", nil];
    [request appendPostData:[[NSString stringWithFormat:@"%@",viewRateDictionary] dataUsingEncoding:NSUTF8StringEncoding]];
    NSLog(@"rating dic%@",viewRateDictionary);
    [request setCompletionBlock:^{
        NSDictionary *root = [NSJSONSerialization JSONObjectWithData:request.responseData options:0 error:nil];
        NSLog(@"comment list%@",root);
        commentVC=[[CommentListViewController alloc]initWithNibName:@"CommentListViewController" bundle:nil];
        [self initializeCommentListArray:root[@"commentList"] completion:^(BOOL result) {
            if(result){
                commentVC.imageString=[tempArray objectAtIndex:2];
                commentVC.nameString=[tempArray objectAtIndex:1];
                NSLog(@"%@",[tempArray objectAtIndex:1]);
                [self.navigationController pushViewController:commentVC animated:YES];
            }
        }];
        
    }];
    [request setFailedBlock:^{
        NSError *error = [request error];
        NSLog(@"Error: %@",error.localizedDescription);
        [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                        type:AJNotificationTypeRed
                                       title:error.localizedDescription
                             linedBackground:AJLinedBackgroundTypeDisabled
                                   hideAfter:GZAJNotificationDelay];
    }];
    [request startAsynchronous];
}

-(void)initializeCommentListArray:(NSMutableArray *)array completion:(void (^)(BOOL result)) return_block{
    commentVC.commentListArray=array;
    return_block(TRUE);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
