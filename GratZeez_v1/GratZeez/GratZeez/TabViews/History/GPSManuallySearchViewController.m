//
//  GPSManuallySearchViewController.m
//  GratZeez
//
//  Created by cloudZon Infosoft on 07/11/13.
//  Copyright (c) 2013 cloudZon Infosoft. All rights reserved.
//

#import "GPSManuallySearchViewController.h"

@interface GPSManuallySearchViewController ()

@end

@implementation GPSManuallySearchViewController
@synthesize searchbar,searchTable,tempData,locateManually,searchedResult,gpsSearchToolbar;
UIBarButtonItem *btnitem;
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
 //   self.edgesForExtendedLayout = UIRectEdgeAll;

    self.title=@"LandMarks";
    MyAppDelegate.locationData=[[NSMutableArray alloc]init];
    locateManually=[[NSMutableDictionary alloc]init ];
    UIBarButtonItem *btnHelp = [[UIBarButtonItem alloc] initWithTitle:@"Help" style:UIBarButtonItemStylePlain target:self action:@selector(btnHelpAction:)];
    self.navigationItem.rightBarButtonItem=btnHelp;
    //NSDictionary* textAttributes = [NSDictionary dictionaryWithObject: [UIColor whiteColor]
     //                                                          forKey: NSForegroundColorAttributeName];
    //[btnHelp setTitleTextAttributes:textAttributes forState:UIControlStateNormal];
    // Do any additional setup after loading the view from its nib.
    [[UIBarButtonItem appearance] setTitleTextAttributes:textAttributesTabBar forState:UIControlStateNormal];
    searchbar.barTintColor=RGB(198, 181, 171);
    searchbar.translucent=NO;
    searchbar.tintColor=[UIColor whiteColor];
    searchTable.backgroundColor=RGB(210, 200, 191);
    [searchTable setSeparatorInset:UIEdgeInsetsZero];
    for (UIView* subview in [[searchbar.subviews lastObject] subviews]) {
        if ([subview isKindOfClass:[UITextField class]]) {
            UITextField *textField = (UITextField*)subview;
            textField.font=[UIFont fontWithName:GZFont size:15.0f];
            [textField setBackgroundColor:RGB(220, 211, 204)];
        }
    }
    [searchbar setImage:[UIImage imageNamed:@"magnifying_glass"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    
    gpsSearchToolbar.frame=CGRectMake(0, 460, 320, 44);
    [self.view addSubview:gpsSearchToolbar];
    UIButton *backBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 36, 21)];
    [backBtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    btnitem=[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    gpsSearchToolbar.items=@[btnitem];
    [gpsSearchToolbar setBackgroundImage:toolBarImage forToolbarPosition:UIBarPositionBottom barMetrics:UIBarMetricsDefault];
    [self addLeftMenuButtonWithImage:[UIImage imageNamed:@"menu_icon"]];
    [self addrightMenuButtonWithImage:[UIImage imageNamed:@"help"]];
    UISwipeGestureRecognizer *rightRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightSwipeHandle:)];
    rightRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [rightRecognizer setNumberOfTouchesRequired:1];
    
    //add the your gestureRecognizer , where to detect the touch..
    [self.view addGestureRecognizer:rightRecognizer];
}
- (void)rightSwipeHandle:(UISwipeGestureRecognizer*)gestureRecognizer
{ [self.navigationController popViewControllerAnimated:YES];
    NSLog(@"rightSwipeHandle");
}
-(IBAction)backAction:(id)sender{
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
    [self presentViewController:helpNavController animated:YES completion:nil];
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

-(void)viewWillAppear:(BOOL)animated{
    [searchbar setText:@""];
    search=FALSE;
    [locateManually setObject:@"YES" forKey:@"request_for_landmarkList"];
    [self sendRequest:URLSearchByLandmark flag:0];
   // [self.view setTranslatesAutoresizingMaskIntoConstraints:NO];
    NSLog(@"viewwill finish");

}

-(void)viewWillDisappear:(BOOL)animated{
    search=FALSE;
     NSLog(@"%f %f %f",self.view.frame.origin.x,self.view.frame.origin.y,self.view.frame.size.height);
}

-(void)sendRequest:(NSString *)str flag:(BOOL )flag{
    NSLog(@"string%@",str);
    ASIFormDataRequest *_request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:str]];
    __unsafe_unretained ASIFormDataRequest *request = _request;
    NSLog(@"%@",locateManually);
    [request appendPostData:[[NSString stringWithFormat:@"%@",locateManually] dataUsingEncoding:NSUTF8StringEncoding]];
    [locateManually removeAllObjects];
    [request setCompletionBlock:^{
        NSDictionary *root = [NSJSONSerialization JSONObjectWithData:[request responseData] options:0 error:nil];
        NSLog(@"Searh Root for GPS%@",root);
     //   NSLog(@"%@",[root valueForKey:@"isLandmark"]);
        if(flag==0)//set isLandmark in dictonary because same method is used for different req
        {
        MyAppDelegate.locationData=[root valueForKey:@"searchResult"];
        NSLog(@"%@",[root valueForKey:@"searchResult"]);
        NSLog(@"locationdata%@",MyAppDelegate.locationData);
        tempData=[[NSMutableArray alloc]initWithArray:MyAppDelegate.locationData];
            tempData=[[NSMutableArray alloc]init];
            tempData=[MyAppDelegate.locationData mutableCopy];
            [searchTable reloadData];
        }
        else{
           // MyAppDelegate.locationData=[root valueForKey:@"searchResult"];
            MyAppDelegate.searchResultArray=[[NSMutableArray alloc]init];
            if([root[@"searchResult"] count]==0){
                [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                                type:AJNotificationTypeRed
                                               title:@"No data Found"
                                     linedBackground:AJLinedBackgroundTypeDisabled
                                           hideAfter:GZAJNotificationDelay];
                return ;
            }
            SearchedResultViewController *searchResultVC=[[SearchedResultViewController alloc]initWithNibName:@"SearchedResultViewController" bundle:nil];
            [self compute:[root valueForKey:@"searchResult"] completionBlock:^(BOOL result){
                if(result){
                NSLog(@"after co");
                 [self.navigationController pushViewController:searchResultVC animated:YES];
                }
            }];
           
            NSLog(@"locationdata of user%@",MyAppDelegate.locationData);
        }
        
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

-(void)compute:(NSMutableArray *)ary completionBlock:(void (^)(BOOL result)) return_block{
    NSLog(@"before co");
    int id=0;
    NSLog(@"Array is%@",ary);
    NSMutableArray *temp;
    for(int i=0;i<[ary count];i++){
        temp=[ary objectAtIndex:i];
        NSLog(@"string%@",[temp objectAtIndex:8]);
        if(id==[[temp objectAtIndex:4] integerValue]){
            NSLog(@"inside");
            NSMutableArray *temp1=[[MyAppDelegate.searchResultArray lastObject] mutableCopy];
            NSLog(@"temp1%@",temp1);
            NSString *tempStr=[NSString stringWithFormat:@"%@,%@",[temp1 objectAtIndex:9],[temp objectAtIndex:9]];
            NSLog(@"%@",tempStr);
            NSString *Id_Str=[NSString stringWithFormat:@"%@,%@",[temp1 objectAtIndex:8],[temp objectAtIndex:8]];
            [temp1 replaceObjectAtIndex:9 withObject:tempStr];
            [temp1 replaceObjectAtIndex:8 withObject:Id_Str];
            [MyAppDelegate.searchResultArray replaceObjectAtIndex:[MyAppDelegate.searchResultArray count]-1 withObject:temp1];
        }
        else{
            
            NSLog(@"temp is%@ %d",temp,id);
            [MyAppDelegate.searchResultArray addObject:temp];
        }
        id=[[temp objectAtIndex:4] intValue];
    }
    NSLog(@"%@",MyAppDelegate.searchResultArray);
    return_block(TRUE);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    @try {
        
        if(search==FALSE){
            //tempData=[NSMutableArray arrayWithObjects:@"Satellite Road",@"Solano St",@"7th St",@"Vallejo st", nil];
            return [tempData count];
        }
        else{
            return [tempSearchResult count];
        }
    }
    @catch (NSException *exception) {
        NSLog(@"exception from no. of rows");
        [self viewWillAppear:YES];
    }
    
    
}
// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
-(UIView *)selectedCellView{
    UIView *cellView=[[UIView alloc]init];
    cellView.backgroundColor=RGB(155,130,110);
    return cellView;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    @try {
        UITableViewCell *cell=[[UITableViewCell alloc ]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cel"];
        cell.backgroundColor=RGB(210, 200, 191);
        cell.selectedBackgroundView=[self selectedCellView];
        cell.textLabel.font=[UIFont fontWithName:GZFont size:16.0];
        if(search==FALSE){
            cell.textLabel.text=[ tempData objectAtIndex:indexPath.row];
            return cell;
        }
        else{
            cell.textLabel.text=[ tempSearchResult objectAtIndex:indexPath.row];
            return cell;
        }

    }
    @catch (NSException *exception) {
    NSLog(@"cell for");
        [self viewWillAppear:YES];
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if([tempData count]==0){
        [tempData addObjectsFromArray:MyAppDelegate.locationData];
        tempData=[MyAppDelegate.locationData mutableCopy];
        NSLog(@"%d",[tempData count]);
    }
    NSString *str=[tempData objectAtIndex:indexPath.row];
    NSLog(@"string is%@",str);
    [locateManually setObject:str forKey:@"landmarkName"];
    [locateManually setObject:[[NSUserDefaults standardUserDefaults] valueForKey:@"userid"] forKey:@"sender_id"];
    [self sendRequest:URLSearchByLandMarkName flag:1];
    NSLog(@"didselect");

}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    searchbar.showsCancelButton=YES;
    searchbar.autocorrectionType=UITextAutocorrectionTypeNo;
    
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText

{
    
    // remove all data that belongs to previous search
            if([searchText isEqualToString:Nil]||searchText==nil){
                search=FALSE;
        [searchTable reloadData];
    }
    else{
        tempSearchResult=[[NSMutableArray alloc]init];
        for(NSString *tempString in [MyAppDelegate.locationData copy])
            
        {
            
            //  NSAutoreleasePool *pool = [[NSAutoreleasePool alloc]init];
            NSLog(@"name is %@ ",tempString);
            NSRange r = [tempString rangeOfString:searchText options:NSCaseInsensitiveSearch];
            
            if(r.location != NSNotFound)
                
            {
                
            //    if(r.location== 0)//that is we are checking only start of the names.
                    
                {
                    
                    [tempSearchResult addObject:tempString];
                    search=TRUE;
                }
                
            }
            
            }
        if([tempSearchResult count]==0){
            search=FALSE;
        }
        [searchTable reloadData];
    }
}


- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar
{
    search=FALSE;
    [searchTable reloadData];
    searchbar.text=@"";
    [searchbar resignFirstResponder];
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    
}


@end
