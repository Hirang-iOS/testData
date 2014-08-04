//
//  ExsitingCharityViewController.m
//  GratZeez
//
//  Created by cloudZon Infosoft on 02/12/13.
//  Copyright (c) 2013 cloudZon Infosoft. All rights reserved.
//

#import "ExsitingCharityViewController.h"

@interface ExsitingCharityViewController ()

@end

@implementation ExsitingCharityViewController
@synthesize charitySearchBar,charityTable,dataDict,txtCharityMail,txtCharityName,charityId,txtGratuity;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
            if (self) {
                // Custom initialization
            }
            return self;

}
-(UIView *)create{
    UIView *footerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
    UIButton *addcharity=[UIButton buttonWithType:UIButtonTypeCustom];
    [addcharity setTitle:@"Click to Add Manually" forState:UIControlStateNormal];
    [addcharity addTarget:self action:@selector(addCharity:) forControlEvents:UIControlEventTouchUpInside];
    [addcharity setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];//set the color this is may be different for iOS 7
    addcharity.frame=CGRectMake(0, 0, 200, 30); //set some large width to ur title
    [footerView addSubview:addcharity];
    return footerView;
}
-(IBAction)addCharity:(id)sender{
    txtCharityMail.hidden=NO;
    txtCharityName.hidden=NO;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title=@"Charity Details";
    search=FALSE;
    UIButton *btnOther =  [UIButton buttonWithType:UIButtonTypeSystem]; //UIButtonTypeCustom for image button
    [btnOther setTitle:@"Save" forState:UIControlStateNormal];
    btnOther.titleLabel.font = [UIFont fontWithName:GZFont size:12.0f];
    //    [btnSave setImage:[UIImage imageNamed:@"save.png"] forState:UIControlStateNormal];
    [btnOther addTarget:self action:@selector(btnSaveAction:) forControlEvents:UIControlEventTouchUpInside];
    [btnOther setFrame:CGRectMake(0, 0, 55, 29)];
    dataArray=[[NSMutableArray alloc]init];
    nameSearchArray=[[NSMutableArray alloc]init];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btnOther];
    txtCharityName.hidden=YES;
    txtCharityMail.hidden=YES;
    originalCenter=self.view.center;
    frame1=txtCharityMail.frame;
    NSLog(@"frame1%f",frame1.origin.y);
    NSLog(@"viewcenter:%f %f",self.view.center.x,self.view.center.y);
    NSLog(@"center:%f %f",originalCenter.x,originalCenter.y);
    j=0;
    [[UIBarButtonItem appearance] setTitleTextAttributes:textAttributesTabBar forState:UIControlStateNormal];
  //  charityTable.tableFooterView=[self create];
   // charityTable.tableFooterView.userInteractionEnabled=YES;
    //charityTable.tableFooterView=
        // Do any additional setup after loading the view from its nib.
}

- (void)setTitle:(NSString *)title {
    //    [super setTitle:title];
    UILabel *titleView = (UILabel *)self.navigationItem.titleView;
    if (!titleView) {
        titleView = [[UILabel alloc] initWithFrame:CGRectZero];
        titleView.backgroundColor = [UIColor clearColor];
        titleView.font = [UIFont fontWithName:GZFont size:16.0];
        titleView.textColor = [UIColor colorWithRed:241/255.0 green:90/255.0 blue:41/255.0 alpha:1.0];
        self.navigationItem.titleView = titleView;
    }
    titleView.text = title;
    [titleView sizeToFit];
}

-(IBAction)btnSaveAction:(id)sender{
    ASIFormDataRequest *_request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:URLAddCharity]];
    __unsafe_unretained ASIFormDataRequest *request = _request;
    [request setDelegate:self];
    NSLog(@"req. dclr");
    NSLog(@"length%d",[charityId length]);
    if([charityId length]<=0 && [txtCharityMail.text length]<=0 && [txtCharityName.text length]<=0 && [txtGratuity.text length]<=0){
        [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                        type:AJNotificationTypeRed
                                       title:@"Select Charity and Enter Donation Amount"
                             linedBackground:AJLinedBackgroundTypeDisabled
                                   hideAfter:GZAJNotificationDelay];
        return;
    }
    NSLog(@"1st if");
    if([txtGratuity.text length]<=0){
        [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                        type:AJNotificationTypeRed
                                       title:@"Enter Amount"
                             linedBackground:AJLinedBackgroundTypeDisabled
                                   hideAfter:GZAJNotificationDelay];
        return;
    }
    else if([charityId length]<=0 && ([txtCharityName.text length]<=0 && [txtCharityMail.text length]<=0)){
        [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                        type:AJNotificationTypeRed
                                       title:@"Please Select Charity"
                             linedBackground:AJLinedBackgroundTypeDisabled
                                   hideAfter:GZAJNotificationDelay];
        return;
        
    }
    else if([charityId length]<=0 && [txtGratuity.text length]<=0){
        [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                        type:AJNotificationTypeRed
                                       title:@"Select Charity and Enter Donation Amount"
                             linedBackground:AJLinedBackgroundTypeDisabled
                                   hideAfter:GZAJNotificationDelay];
        return;
    }
    NSLog(@"id%@",charityId);
    NSDictionary *charityDictionary=[[NSDictionary alloc]initWithObjectsAndKeys:charityId,@"charity_id",txtCharityName.text,@"charity_name",txtCharityMail.text,@"charity_mail",txtGratuity.text,@"gratuity_percentage",[[NSUserDefaults standardUserDefaults] valueForKey:@"userid"],@"service_providerId",nil];
  //NSDictionary *charityDictionary=[[NSDictionary alloc]initWithObjectsAndKeys:charityId,@"chrityId",txtGratuity.text,@"gratuity_percentage",[[NSUserDefaults standardUserDefaults] valueForKey:@"userid"],@"service_providerId",nil];
    [request appendPostData:[[NSString stringWithFormat:@"%@",charityDictionary] dataUsingEncoding:NSUTF8StringEncoding]];
    NSLog(@"CHARITYDICT:%@",charityDictionary);
    [request setCompletionBlock:^{
        NSDictionary *root=[NSJSONSerialization JSONObjectWithData:[request responseData] options:0 error:nil];
        NSLog(@"cahrityroot%@",root);
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


-(void)viewWillAppear:(BOOL)animated{
    NSLog(@"dict%@",dataDict);
   dataArray=[dataDict valueForKey:@"charityList"];
        NSLog(@"a%@",[dataArray objectAtIndex:0]);
    NSMutableArray *object=[[NSMutableArray alloc]init];
 //   NSLog(@"%@",[object valueForKey:@"charityName"]);
    for(int i=0;i<[dataArray count];i++){
        object=[dataArray objectAtIndex:i];
        [nameSearchArray addObject:[object objectAtIndex:1]];
    }
    NSLog(@"arr%@",nameSearchArray);
    [charityTable reloadData];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(search==FALSE){
        if([nameSearchArray count]<=0){
            return 1;
        }
        else{
        return [nameSearchArray count];
        }
    }
    else{
            return [searchResultArray count];
        }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellIdentifier";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
    if(!cell){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    if(search==FALSE){
        if([nameSearchArray count]<=0){
    cell.textLabel.text=@"No Charity Found";
            cell.textLabel.font=[UIFont systemFontOfSize:12.0f];
        //[nameSearchArray objectAtIndex:indexPath.row];
        }
        else{
            cell.textLabel.text=[nameSearchArray objectAtIndex:indexPath.row];
            cell.textLabel.font=[UIFont systemFontOfSize:12.0f];
        }
    }
    else{
        cell.textLabel.text=[searchResultArray objectAtIndex:indexPath.row];
    }
    return cell;
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    
//    return @"Charity :";
//}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger) section
{
    //section text as a label
    UILabel *lbl = [[UILabel alloc] init];
    lbl.textAlignment = NSTextAlignmentCenter;
    
    lbl.text = @"Charity";
    [lbl setBackgroundColor:[UIColor clearColor]];
    
    return lbl;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   NSArray *charityArray = [dataArray objectAtIndex:indexPath.row];
    charityId=[[charityArray objectAtIndex:0] stringValue];
    NSLog(@"charityId%@",charityId);
    NSLog(@"len%d",[charityId length]);
    NSLog(@"error");
    txtCharityMail.text=@"";
    txtCharityName.text=@"";
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    charitySearchBar.showsCancelButton=YES;
    charitySearchBar.autocorrectionType=UITextAutocorrectionTypeNo;
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {

    if(textField==txtCharityName){
        NSLog(@"%f",self.view.center.y);
        [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{CGRect frame;
            frame=self.view.frame;
            frame.origin.y=frame.origin.y-120;
            self.view.frame=frame;
        } completion:^(BOOL finished){
            if(finished){
                NSLog(@"finished");
            }
        }];
        NSLog(@"%f %f",frame1.origin.y,self.view.center.y);
    }
//    if(textField==txtCharityMail)
//    {
//        if(j==1){
//            return;
//        }
//        NSLog(@"%f %f",frame1.origin.y,txtCharityMail.frame.origin.y);
//        [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{CGRect frame;
//            frame=self.view.frame;
//            //frame=textField.frame;
//            frame.origin.y=frame.origin.y-120;
//            //textField.frame=frame;
//            self.view.frame=frame;
//        } completion:^(BOOL finished){
//            if(finished){
//                NSLog(@"finished");
//            }
//        }];
//    }
//    j=0;
    }
-(void)textFieldDidEndEditing:(UITextField *)textField{
//    if(textField==txtGratuity)
//    {
//    [UIView animateWithDuration:0.25 delay:0.0 options: UIViewAnimationOptionCurveEaseInOut
//                     animations:^{
//                         
//                         CGRect frame;
//                         
//                         // let's move our textField
//                         frame = self.view.frame;
//                         frame.origin.y = frame.origin.y+120;
//                         //textField.frame=frame;
//                         self.view.frame=frame;
//                     }
//                     completion:^(BOOL finished){
//                         if(finished)  {NSLog(@"Finished !!!!!");}
//                                             }];
//    }
    if( textField==txtCharityMail)
    {
        
        [UIView animateWithDuration:0.25 delay:0.0 options: UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             
                             CGRect frame;
                             
                             // let's move our textField
                             frame = self.view.frame;
                             frame.origin.y = frame.origin.y+120;
                             //textField.frame=frame;
                             self.view.frame=frame;
                         }
                         completion:^(BOOL finished){
                             if(finished)  {NSLog(@"Finished end !!!!!");}
                         }];
        NSLog(@"%f",self.view.center.y);
    }
    
}

                                             
                                             
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if(textField==txtCharityName){
        [txtCharityName resignFirstResponder];
        [txtCharityMail becomeFirstResponder];
        j=1;
        NSLog(@"should");
    }
    if(textField==txtCharityMail){
        [txtCharityMail resignFirstResponder];
    }
    if(textField==txtGratuity){
        [txtGratuity resignFirstResponder];
    }
    return YES;
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText

{
    
    NSLog(@"%@",searchText);
    
    // remove all data that belongs to previous search
    if([searchText isEqualToString:Nil]||searchText==nil){
        search=FALSE;
        [charityTable reloadData];
    }
    else{
        searchResultArray=[[NSMutableArray alloc]init];
       // int i=0;
        for(NSString *tempString in nameSearchArray)
            
        {
            
            //  NSAutoreleasePool *pool = [[NSAutoreleasePool alloc]init];
            NSLog(@"name is %@ ",tempString);
            NSRange r = [tempString rangeOfString:searchText];
            
            if(r.location != NSNotFound)
                
            {
                
                //    if(r.location== 0)//that is we are checking only start of the names.
                
                {
                    
                    [searchResultArray addObject:tempString];
                  // NSLog(@"added%d",i);
                    search=TRUE;
                }
                
            }
         //   i++;
          //  NSLog(@"reach %d",i);
            
        }
        if([[searchText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]<=0){
            
            search=FALSE;
        }
        [charityTable reloadData];
    }
}


- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar
{
    search=FALSE;
    [charityTable reloadData];
    charitySearchBar.text=@"";
    [charitySearchBar resignFirstResponder];
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

- (IBAction)enableTextFieldAction:(id)sender {
    txtCharityName.hidden=NO;
    txtCharityMail.hidden=NO;
}
@end
