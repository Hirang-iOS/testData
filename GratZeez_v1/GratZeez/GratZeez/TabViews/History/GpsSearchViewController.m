//
//  GpsSearchViewController.m
//  GratZeez
//
//  Created by cloudZon Infosoft on 31/10/13.
//  Copyright (c) 2013 cloudZon Infosoft. All rights reserved.
//

#import "GpsSearchViewController.h"

@interface GpsSearchViewController ()

@end

@implementation GpsSearchViewController
@synthesize btn_manually,btn_nearestLocation,mainToolBar;

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
    self.title=@"Search By Location";
    
    UIBarButtonItem *btnHelp = [[UIBarButtonItem alloc] initWithTitle:@"Help" style:UIBarButtonItemStylePlain target:self action:@selector(btnHelpAction:)];
    self.navigationItem.rightBarButtonItem=btnHelp;
    [btnHelp setTitleTextAttributes:textAttributesTabBar forState:UIControlStateNormal];
   // self.navigationController.navigationBar.translucent=YES;
   // self.navigationController.naviga
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];
    [[UIBarButtonItem appearance] setTitleTextAttributes:textAttributesTabBar forState:UIControlStateNormal];
    //self.navigationController.navigationBar.titleTextAttributes=textAttributes;
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    btn_manually.titleLabel.font=[UIFont fontWithName:GZFont size:18.0f];
    NSMutableAttributedString *locateManually = [[NSMutableAttributedString alloc] initWithString:@"Nearest Location Search"];
    [locateManually addAttribute:NSForegroundColorAttributeName  value:[UIColor blackColor] range:(NSRange){0,[locateManually length]}];
    [locateManually addAttribute:(NSString*)kCTUnderlineStyleAttributeName
                            value:[NSNumber numberWithInt:NSUnderlineStyleSingle]
                            range:(NSRange){0,[locateManually length]}];
    [locateManually addAttribute:NSFontAttributeName value:[UIFont fontWithName:GZFont size:18.0f] range:(NSRange){0,[locateManually length]}];
    [btn_nearestLocation setAttributedTitle:locateManually forState:UIControlStateNormal];
  //  btn_nearestLocation.titleLabel.font=[UIFont fontWithName:GZFont size:18.0f];
    
    // Do any additional setup after loading the view from its nib.
   
    UIButton *backBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 33, 33)];
    [backBtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    UIBarButtonItem *btnitem=[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    mainToolBar.items=@[btnitem];
    [mainToolBar setBackgroundImage:toolBarImage forToolbarPosition:UIBarPositionBottom barMetrics:UIBarMetricsDefault];
    [self addLeftMenuButtonWithImage:[UIImage imageNamed:@"menu_icon"]];
    [self addrightMenuButtonWithImage:[UIImage imageNamed:@"help"]];
  //  UIPanGestureRecognizer *pan=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(backAction:)];
   // [self.view addGestureRecognizer:pan];
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
-(void)viewWillAppear:(BOOL)animated{
    locationManager=[[CLLocationManager alloc]init];
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)searchLocation:(id)sender {
    
    locationManager.delegate=self;
    locationManager.desiredAccuracy=kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];

    
}

- (IBAction)locateManually:(id)sender {
    GPSManuallySearchViewController *searchManually=[[GPSManuallySearchViewController alloc]init];
    [self.navigationController pushViewController:searchManually animated:YES];
}


#pragma sending Latitude ND Longitude

-(void)sendCoordinate{
    ASIFormDataRequest *_request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:URLSearchNearBy]];
    __unsafe_unretained ASIFormDataRequest *request = _request;
    
    [request appendPostData:[[NSString stringWithFormat:@"%@",coordinateDictionary] dataUsingEncoding:NSUTF8StringEncoding]];
    NSLog(@"sent%@",coordinateDictionary);
    [request setCompletionBlock:^{
        NSDictionary *root = [NSJSONSerialization JSONObjectWithData:[request responseData] options:0 error:nil];
        NSLog(@"Searh Root for GPS%@",root);
        NSLog(@"first object is%@",[root valueForKey:@"searchResult"]);
        NSLog(@"iserror%@",[root valueForKey:@"isError"]);
        MyAppDelegate.searchResultArray=[[NSMutableArray alloc]init];
//        NSLog(@"only one%@",[ary objectAtIndex:0]);
//        NSArray *single=[ary objectAtIndex:0];
//        NSLog(@"%@",[single objectAtIndex:0]);
        if([[root valueForKey:@"isError"] boolValue]==0){
            if([[root valueForKey:@"searchResult"] count]==0){
                [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window type:AJNotificationTypeBlue
                                               title:@"No Data Found"
                                     linedBackground:AJLinedBackgroundTypeDisabled
                                           hideAfter:GZAJNotificationDelay];
                return ;
            }
            else{
            SearchedResultViewController *SearchResultVC=[[SearchedResultViewController alloc]initWithNibName:@"SearchedResultViewController" bundle:nil];
                [self compute:[root valueForKey:@"searchResult"] completionBlock:^(BOOL result){
                    if(result){
                    NSLog(@"after co");
                    [self.navigationController pushViewController:SearchResultVC animated:YES];
                    }
                }];
               // [self.navigationController pushViewController:SearchResultVC animated:YES];

                }
        }
        else if([[root valueForKey:@"isError"] boolValue]==1){
            [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window type:AJNotificationTypeRed
                                           title:[root objectForKey:@"message"]
                                 linedBackground:AJLinedBackgroundTypeDisabled
                                       hideAfter:GZAJNotificationDelay];
            return ;
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
        return ;
        
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
            [MyAppDelegate.searchResultArray replaceObjectAtIndex:[MyAppDelegate.searchResultArray count]-1 withObject:temp1];        }
        else{
            
            NSLog(@"temp is%@ %d",temp,id);
            [MyAppDelegate.searchResultArray addObject:temp];
        }
        id=[[temp objectAtIndex:4] integerValue];
    }
    NSLog(@"%@",MyAppDelegate.searchResultArray);
    return_block(TRUE);
}

#pragma CLLocation Delegate

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"didfailwith error:%@",error);
    [locationManager stopUpdatingLocation];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    CLLocation *searchLocation=[locations lastObject];
    if(searchLocation !=nil){
        NSLog(@"latitude%f, logitude%f",searchLocation.coordinate.latitude,searchLocation.coordinate.longitude);
    }
    NSString *latString=[[NSString alloc]initWithFormat:@"%f",searchLocation.coordinate.latitude];
    NSString *longString=[[NSString alloc]initWithFormat:@"%f",searchLocation.coordinate.longitude ];
    NSLog(@"%@,%@",latString,longString);
    NSArray *objects=[[NSArray alloc]initWithObjects:latString,longString,[[NSUserDefaults standardUserDefaults] valueForKey:@"userid"], nil];
    NSArray *keys=[[NSArray alloc]initWithObjects:@"latitude",@"longitude",@"sender_id", nil];
    coordinateDictionary=[[NSDictionary alloc]initWithObjects:objects forKeys:keys];
    NSLog(@"%@",coordinateDictionary);
    [locationManager stopUpdatingLocation];
    [self sendCoordinate];
}


@end
