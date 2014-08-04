//
//  WorkLocationDetailsViewController.m
//  GratZeez
//
//  Created by cloudZon Infosoft on 26/11/13.
//  Copyright (c) 2013 cloudZon Infosoft. All rights reserved.
//

#import "WorkLocationDetailsViewController.h"

@interface WorkLocationDetailsViewController ()

@end

@implementation WorkLocationDetailsViewController
@synthesize workDetailArray,lblTag,establishId,isFromEditProfile_WorkDetail,workToolbar;

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
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title=@"WorkLocation List";
    NSLog(@"Array%@",workDetailArray);
    tempDataArray=[workDetailArray mutableCopy];
    NSLog(@"tempArray%@",tempDataArray);
    [self.view setBackgroundColor: RGB(210, 200, 191)];
  //  NSMutableArray *temp=[[NSMutableArray alloc]init];
    searchArray =[[NSMutableArray alloc]init];

    
    for (UIView* subview in [[workLocationSearchBar.subviews lastObject] subviews]) {
        if ([subview isKindOfClass:[UITextField class]]) {
            UITextField *textField = (UITextField*)subview;
            textField.font=[UIFont fontWithName:GZFont size:15.0f];
            [textField setBackgroundColor:RGB(220, 211, 204)];
           // textField.leftViewMode = UITextFieldViewModeNever;
            //textField.rightViewMode = UITextFieldViewModeAlways;
        }
    }
    

    
    
    for(int i=0;i<[tempDataArray count];i++){
        NSArray *t=[tempDataArray objectAtIndex:i];
        [searchArray addObject:[t objectAtIndex:1]];
    }
    NSLog(@"outside temp:%@",searchArray);
    search=FALSE;
    //workLocationTableView.tableFooterView=[self create];
    workLocationSearchBar.barTintColor=RGB(198, 181, 171);
    workLocationSearchBar.translucent=NO;
    [workLocationSearchBar setImage:[UIImage imageNamed:@"magnifying_glass"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    workLocationSearchBar.tintColor=[UIColor whiteColor];
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    workLocationTableView.backgroundColor=RGB(210, 200, 191);
    [workLocationTableView setSeparatorInset:UIEdgeInsetsZero];
    // Do any additional setup after loading the view from its nib.
    [[UIBarButtonItem appearance] setTitleTextAttributes:textAttributesTabBar forState:UIControlStateNormal];
    
    workToolbar.frame=CGRectMake(0,524, 320, 44);
    [self.view addSubview:workToolbar];
    UIButton *backBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 36, 21)];
    [backBtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    UIBarButtonItem *btnitem=[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    workToolbar.items=@[btnitem];
    [workToolbar setBackgroundImage:toolBarImage forToolbarPosition:UIBarPositionBottom barMetrics:UIBarMetricsDefault];
    [self addLeftMenuButtonWithImage:[UIImage imageNamed:@"menu_icon"]];
    [self addrightMenuButtonWithImage:[UIImage imageNamed:@"help"]];
    UISwipeGestureRecognizer *rightRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(backAction:)];
    rightRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [rightRecognizer setNumberOfTouchesRequired:1];
    [self.view addGestureRecognizer:rightRecognizer];
}
-(IBAction)backAction:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
//- (void)setImage:(UIImage *)iconImage forSearchBarIcon:(UISearchBarIcon)icon state:(UIControlState){
//    
//}
//- (UIImage *)imageForSearchBarIcon:(UISearchBarIcon)icon state:(UIControlState)state

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


//tableviewdelegate methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(search==FALSE){
    NSLog(@"array count%d",[tempDataArray count]);
        return [tempDataArray count]+1;
    //    return 1;
    }
    else{
        return [searchResultArray count]+1;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01f;
}
-(UIView *)selectedCellView{
    UIView *cellView=[[UIView alloc]init];
    cellView.backgroundColor=RGB(155,130,110);
    return cellView;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WorkDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:nil];
    tableView.tableFooterView=nil;
    tableView.contentInset=UIEdgeInsetsMake(0, 0, self.bottomLayoutGuide.length, 0);
    //self.edgesForExtendedLayout=UIRectEdgeNone;
    if (cell == nil) {
        NSArray *topLevelObject;
        topLevelObject = [[NSBundle mainBundle] loadNibNamed:@"WorkDetailCell" owner:self options:nil];
        cell = [topLevelObject objectAtIndex:0];
        cell.backgroundColor=RGB(210, 200, 191);
        cell.selectedBackgroundView=[self selectedCellView];
        UIButton *doneButton=[UIButton buttonWithType:UIButtonTypeCustom];
        doneButton.frame=CGRectMake(220, 45, 100, 60);
        //[doneButton setTitle:@"pick" forState:UIControlStateNormal];
        [doneButton addTarget:self action:@selector(doneButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [doneButton setImage:[UIImage imageNamed:@"pick"] forState:UIControlStateNormal];
        [doneButton setTag:indexPath.row];
        UIButton *previewButton=[UIButton buttonWithType:UIButtonTypeCustom];
        previewButton.frame=CGRectMake(235, 15, 65, 30);
        //[previewButton setTitle:@"Preview" forState:UIControlStateNormal];
        //[previewButton setTitleColor:RGB(110, 73, 44) forState:UIControlStateNormal];
        NSMutableAttributedString *preview = [[NSMutableAttributedString alloc] initWithString:@"Preview"];
        [preview addAttribute:NSForegroundColorAttributeName  value:RGB(110, 73, 44) range:(NSRange){0,[preview length]}];
        
        [preview addAttribute:NSFontAttributeName value:[UIFont fontWithName:GZFont size:18.0f] range:(NSRange){0,[preview length]}];
        [previewButton setAttributedTitle:preview forState:UIControlStateNormal];
        [previewButton addTarget:self action:@selector(previewButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [previewButton setTag:indexPath.row];
        [cell.contentView addSubview:doneButton];
        [cell.contentView addSubview:previewButton];
        cell.lblOrganization.font=[UIFont fontWithName:GZFont size:14.0f];
        cell.lblAddress.font=[UIFont fontWithName:GZFont size:14.0f];
        cell.lblLandmark.font=[UIFont fontWithName:GZFont size:14.0f];
        cell.lblCity.font=[UIFont fontWithName:GZFont size:14.0f];
        cell.lblState.font=[UIFont fontWithName:GZFont size:14.0f];
    }

    if(search==FALSE){
        NSLog(@"%d",indexPath.row);
        cell.clearsContextBeforeDrawing=YES;
        if(indexPath.row==[tempDataArray count]){
            UITableViewCell *lastCell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"lastCell"];
            UIButton *addcharity=[UIButton buttonWithType:UIButtonTypeCustom];
            //[addcharity setTitle:@"Add Another" forState:UIControlStateNormal];
            [addcharity setImage:[UIImage imageNamed:@"add_another"] forState:UIControlStateNormal];
            [addcharity addTarget:self action:@selector(addWorkLocation:) forControlEvents:UIControlEventTouchUpInside];
            // [addcharity setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];//set the color this is may be different for iOS 7
            addcharity.frame=CGRectMake(100, 20, 130, 60); //set some large width to ur title
            [lastCell.contentView addSubview:addcharity];
            lastCell.backgroundColor=RGB(210, 200, 191);
            lastCell.selectedBackgroundView=[self selectedCellView];
            return lastCell;
        }
        //NSDictionary *detailList=[tempDataArray objectAtIndex:indexPath.row];
        NSArray *temp=[tempDataArray objectAtIndex:indexPath.row];
        cell.lblOrganization.text=[temp objectAtIndex:1];//@"TGB";//[detailList valueForKey:@"organizationName"];
        cell.lblAddress.text=[temp objectAtIndex:2];//@"Ahmedabad";//detailList[@"address"];
        cell.lblLandmark.text=[temp objectAtIndex:3];//@"SG HighWay";//detailList[@"landmark"];
        cell.lblCity.text=[temp objectAtIndex:4];//@"Ahmedabad";//detailList[@"city"];
        cell.lblState.text=[temp objectAtIndex:5];//@"Ahmedabad";//detailList[@"state"];

       
        // UIButton *btn=[btnArray objectAtIndex:0];
        //UIButton *bt=[btnArray objectAtIndex:1];
  
   
    }
    else{
     //   NSDictionary *detailList=[searchResultArray objectAtIndex:indexPath.row];
       // NSLog(@"dic%@",detailList);
        //cell.contentView.clearsContextBeforeDrawing=YES;
      cell.clearsContextBeforeDrawing=YES;
        if(indexPath.row==[searchResultArray count]){
             UITableViewCell *lastCell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"lastCell"];
            UIButton *addcharity=[UIButton buttonWithType:UIButtonTypeCustom];
            //[addcharity setTitle:@"Add Another" forState:UIControlStateNormal];
            [addcharity setImage:[UIImage imageNamed:@"add_another"] forState:UIControlStateNormal];
            [addcharity addTarget:self action:@selector(addWorkLocation:) forControlEvents:UIControlEventTouchUpInside];
            // [addcharity setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];//set the color this is may be different for iOS 7
            addcharity.frame=CGRectMake(100, 20, 130, 60); //set some large width to ur title
            [lastCell.contentView addSubview:addcharity];
             lastCell.backgroundColor=RGB(210, 200, 191);
            lastCell.selectedBackgroundView=[self selectedCellView];
            return lastCell;
        }
        NSArray *temp=[searchResultArray objectAtIndex:indexPath.row];
        cell.lblOrganization.text= [temp objectAtIndex:1]; //[detailList valueForKey:@"organizationName"];
        cell.lblAddress.text=[temp objectAtIndex:2];//detailList[@"address"];
        cell.lblLandmark.text=[temp objectAtIndex:3];//detailList[@"landmark"];
        cell.lblCity.text=[temp objectAtIndex:4];//detailList[@"city"];
        cell.lblState.text=[temp objectAtIndex:5];//detailList[@"state"];
        
     
    }
    return cell;
}

-(UIView *)create{
    UIView *footerView=[[UIView alloc]initWithFrame:CGRectMake(100, 0, 320, 40)];
    UIButton *addcharity=[UIButton buttonWithType:UIButtonTypeCustom];
    //[addcharity setTitle:@"Add Another" forState:UIControlStateNormal];
    [addcharity setImage:[UIImage imageNamed:@"add_another"] forState:UIControlStateNormal];
    [addcharity addTarget:self action:@selector(addWorkLocation:) forControlEvents:UIControlEventTouchUpInside];
   // [addcharity setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];//set the color this is may be different for iOS 7
    addcharity.frame=CGRectMake(0, 0, 130, 60); //set some large width to ur title
    [footerView addSubview:addcharity];
    return footerView;
}

-(IBAction)addWorkLocation:(id)sender{
    WorkLocationViewController *workVC=[[WorkLocationViewController alloc]init];
    workVC.establishId=self.establishId;
    workVC.isFromEditProfile=isFromEditProfile_WorkDetail;
    
    // [self.navigationController pushViewController:workVC animated:YES];
    ASIFormDataRequest *_request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:URLGetState]];
    __unsafe_unretained ASIFormDataRequest *request = _request;
    [request setDelegate:self];
    [request setCompletionBlock:^{
        NSDictionary *root = [NSJSONSerialization JSONObjectWithData:request.responseData options:0 error:nil];
        NSLog(@"Worklocatio root %@",root);
        // WorkLocationViewController *wvc=[[WorkLocationViewController alloc]init];
       // EstablishmentViewController *eVC=[[EstablishmentViewController alloc]init];
        workVC.stateArray=root[@"stateList"];
        NSArray *array = [self.navigationController viewControllers];
        if (isFromEditProfile_WorkDetail==TRUE) {
            workVC.delegate=[array objectAtIndex:1];
        }
        else{
        workVC.delegate=[array objectAtIndex:0];
        }
        workVC.lblTag=self.lblTag;
        [self.navigationController pushViewController:workVC animated:YES];
    }];
    [request setFailedBlock:^{
        NSError *error = [request error];
        [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                        type:AJNotificationTypeRed
                                       title:error.localizedDescription
                             linedBackground:AJLinedBackgroundTypeDisabled
                                   hideAfter:GZAJNotificationDelay];
    }];
    [request startAsynchronous];

}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 102;
}

-(IBAction)doneButtonClicked:(id)sender{
    if(search==FALSE){
    NSLog(@"pick%d",[sender tag]);
        NSLog(@"pick from temp");
         NSArray *tempArray=[tempDataArray objectAtIndex:[sender tag]];
        [_delegate organizationInfo:[tempArray objectAtIndex:0] name:[tempArray objectAtIndex:1] tag:lblTag];
        NSLog(@"1%@",_delegate);
    }
    if(search==TRUE){
        NSArray *tempArray=[searchResultArray objectAtIndex:[sender tag]];
        [_delegate organizationInfo:[tempArray objectAtIndex:0] name:[tempArray objectAtIndex:1] tag:lblTag];
    }

    NSLog(@"2%@",_delegate);
    [self.navigationController popViewControllerAnimated:YES];
}
-(IBAction)previewButtonClicked:(id)sender{
    NSLog(@"clicked");
    NSLog(@"preview%d",[sender tag]);
    NSArray *tempArray;CLLocationCoordinate2D co;NSString *latstr,*lngstr;
    MapViewController *mapVC=[[MapViewController alloc]init];
    if(search==FALSE){
    tempArray=[tempDataArray objectAtIndex:[sender tag]];
        latstr=[tempArray objectAtIndex:9];
       lngstr=[tempArray objectAtIndex:10];
        co.latitude=[latstr floatValue];
        co.longitude=[lngstr floatValue];
        mapVC.city=[tempArray objectAtIndex:4];
        mapVC.landmark=[tempArray objectAtIndex:3];
    }
    if(search==TRUE){
        tempArray=[searchResultArray objectAtIndex:[sender tag]];
        latstr=[tempArray objectAtIndex:9];
        lngstr=[tempArray objectAtIndex:10];
        co.latitude=[latstr floatValue];
        co.longitude=[lngstr floatValue];
        mapVC.city=[tempArray objectAtIndex:4];
        mapVC.landmark=[tempArray objectAtIndex:3];
    }
    mapVC.coordinate=co;
    mapVC.islblHide=1;
    [self.navigationController pushViewController:mapVC animated:YES];

    
}
//searchbar delegate method

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    workLocationSearchBar.showsCancelButton=YES;
    workLocationSearchBar.autocorrectionType=UITextAutocorrectionTypeNo;
    
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText

{
    
    NSLog(@"%@",searchText);
    
    // remove all data that belongs to previous search
    if([searchText isEqualToString:Nil]||searchText==nil){
        search=FALSE;
        [workLocationTableView reloadData];
    }
    else{
        searchResultArray=[[NSMutableArray alloc]init];
        int i=0;
        for(NSString *tempString in searchArray)
            
        {
            
            //  NSAutoreleasePool *pool = [[NSAutoreleasePool alloc]init];
            NSLog(@"name is %@ ",tempString);
            NSRange r = [tempString rangeOfString:searchText options:NSCaseInsensitiveSearch];
            
            if(r.location != NSNotFound)
                
            {
                
                //    if(r.location== 0)//that is we are checking only start of the names.
                
                {
                    
                    [searchResultArray addObject:[tempDataArray objectAtIndex:i]];
                    NSLog(@"added%d",i);
                    search=TRUE;
                }
                
            }
            i++;
            NSLog(@"reach %d",i);
           
        }
               if([[searchText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]<=0){
           
        search=FALSE;
        }
        if([searchResultArray count]==0){
            search=FALSE;
        }
       workLocationTableView.clearsContextBeforeDrawing=YES;
        [workLocationTableView reloadData];
    }
}


- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar
{
    search=FALSE;
    [workLocationTableView reloadData];
    workLocationSearchBar.text=@"";
    [workLocationSearchBar resignFirstResponder];
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
