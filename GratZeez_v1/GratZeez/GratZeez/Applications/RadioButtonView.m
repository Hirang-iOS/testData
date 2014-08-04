//
//  RadioButtonView.m
//  GratZeez
//
//  Created by cloudZon Infosoft on 14/11/13.
//  Copyright (c) 2013 cloudZon Infosoft. All rights reserved.
//

#import "RadioButtonView.h"
#import "ServiceProviderProfileViewController.h"
@implementation RadioButtonView
@synthesize radioButtons,genderButtonIndex,payPalRadioButton,svc;

- (id)initWithFrame:(CGRect)frame andOptions:(NSArray *)options andColumns:(int)columns{
	
	
	self.radioButtons =[[NSMutableArray alloc]init];
    if (self = [super initWithFrame:frame]) {
        // Initialization code
		int framex =0;
		framex= frame.size.width/columns;
		int framey = 0;
		framey =frame.size.height/([options count]/(columns));
//		int rem =[options count]%columns;
//		if(rem !=0){
//			framey =frame.size.height/(([options count]/columns)+1);
//		}
		int k = 0;
		for(int i=0;i<([options count]/columns);i++){
			for(int j=0;j<columns;j++){
				
			    int x = framex*0.20;
				int y = framey*0.20;
				UIButton *btTemp = [[UIButton alloc]initWithFrame:CGRectMake(framex*j+x, framey*i+y, framex/2+x, framey/2+y)];
				[btTemp addTarget:self action:@selector(radioButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
				btTemp.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
				[btTemp setImage:[UIImage imageNamed:@"radio-off.png"] forState:UIControlStateNormal];
			    [btTemp setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
				btTemp.titleLabel.font =[UIFont fontWithName:GZFont size:12.0];
                btTemp.titleLabel.numberOfLines=1;
                btTemp.titleLabel.lineBreakMode=NSLineBreakByWordWrapping;
                btTemp.titleLabel.textAlignment=NSTextAlignmentLeft;
				[btTemp setTitle:[options objectAtIndex:k] forState:UIControlStateNormal];
                btTemp.tag=j+1;
				[self.radioButtons addObject:btTemp];
				[self addSubview:btTemp];
		        //[btTemp release];
				k++;
                
			}
		}
		
      /*  for(int j=0;j<rem;j++){
            
            int x = framex*0.25;
            int y = framey*0.25;
            UIButton *btTemp = [[UIButton alloc]initWithFrame:CGRectMake(framex*j+x, framey*([options count]/columns), framex/2+x, framey/2+y)];
            [btTemp addTarget:self action:@selector(radioButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            btTemp.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            [btTemp setImage:[UIImage imageNamed:@"radio-off.png"] forState:UIControlStateNormal];
            [btTemp setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            btTemp.titleLabel.font =[UIFont systemFontOfSize:14.f];
            [btTemp setTitle:@"jhayesh" forState:UIControlStateNormal];
            [self.radioButtons addObject:btTemp];
            [self addSubview:btTemp];
            //[btTemp release];
            k++;
            
			
		} */
		
	}
    return self;
}

/*- (void)dealloc {
	//[radioButtons release];
    [super dealloc];
} */

-(IBAction) radioButtonClicked:(UIButton *) sender{
	for(int i=0;i<[self.radioButtons count];i++){
		[[self.radioButtons objectAtIndex:i] setImage:[UIImage imageNamed:@"radio-off.png"] forState:UIControlStateNormal];
        
	}
    genderButtonIndex=[sender tag];
    
    //NSLog(@"gender radio%d",genderIndex.selectedGenderIndex);
	
    [sender setImage:[UIImage imageNamed:@"radio-on.png"] forState:UIControlStateNormal];
 
    //   ServiceProviderProfileViewController *svc=[[ServiceProviderProfileViewController alloc]init];
    [_delegate buttonWasActivated:sender.tag];
    NSLog(@"delegate %@",_delegate);
   

}

-(void) removeButtonAtIndex:(int)index{
	[[self.radioButtons objectAtIndex:index] removeFromSuperview];
    
}

-(void) setSelected:(int) index{
	for(int i=0;i<[self.radioButtons count];i++){
		[[self.radioButtons objectAtIndex:i] setImage:[UIImage imageNamed:@"radio-off.png"] forState:UIControlStateNormal];
		
	}
	[[self.radioButtons objectAtIndex:index] setImage:[UIImage imageNamed:@"radio-on.png"] forState:UIControlStateNormal];
}

-(void)clearAll{
	for(int i=0;i<[self.radioButtons count];i++){
		[[self.radioButtons objectAtIndex:i] setImage:[UIImage imageNamed:@"radio-off.png"] forState:UIControlStateNormal];
		
	}
}

- (id)initWithPayPalFrame:(CGRect)frame andOptions:(NSArray *)options andColumns:(int)columns tag:(int)tag{
    self.payPalRadioButton =[[NSMutableArray alloc]init];
    if (self = [super initWithFrame:frame]) {
        // Initialization code
		int framex =0;
		framex= frame.size.width/columns;
		int framey = 0;
		framey =frame.size.height/([options count]/(columns));
        //		int rem =[options count]%columns;
        //		if(rem !=0){
        //			framey =frame.size.height/(([options count]/columns)+1);
        //		}
		int k = 0;
		for(int i=0;i<([options count]/columns);i++){
			for(int j=0;j<columns;j++){
				
			    int x = framex*0.20;
				int y = framey*0.20;
				UIButton *btTemp = [[UIButton alloc]initWithFrame:CGRectMake(framex*j+x, framey*i+y, framex/2+x, framey/2+y)];
				[btTemp addTarget:self action:@selector(payPalRadioButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
				btTemp.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
				[btTemp setImage:[UIImage imageNamed:@"radio-off.png"] forState:UIControlStateNormal];
                if(tag==1){
			    [btTemp setTitleColor:RGB(107, 72, 44) forState:UIControlStateNormal];
                }
                if(tag==0){
                    [btTemp setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                }
				btTemp.titleLabel.font =[UIFont fontWithName:GZFont size:12.0];
                btTemp.titleLabel.numberOfLines=1;
                btTemp.titleLabel.lineBreakMode=NSLineBreakByWordWrapping;
                btTemp.titleLabel.textAlignment=NSTextAlignmentLeft;
				[btTemp setTitle:[options objectAtIndex:k] forState:UIControlStateNormal];
                btTemp.tag=j+1;
				[self.payPalRadioButton addObject:btTemp];
				[self addSubview:btTemp];
		        //[btTemp release];
				k++;
                
			}
		}
		
        
		
	}
    return self;

}
-(IBAction) payPalRadioButtonClicked:(UIButton *) sender{
    for(int i=0;i<[self.payPalRadioButton count];i++){
		[[self.payPalRadioButton objectAtIndex:i] setImage:[UIImage imageNamed:@"radio-off.png"] forState:UIControlStateNormal];
        
	}
    genderButtonIndex=[sender tag];
        //NSLog(@"gender radio%d",genderIndex.selectedGenderIndex);
    [_delegate buttonWasActivated:sender.tag];
	[sender setImage:[UIImage imageNamed:@"radio-on.png"] forState:UIControlStateNormal];

}
-(void)setPayPalSelected:(int)index{
    for(int i=0;i<[self.payPalRadioButton count];i++){
		[[self.payPalRadioButton objectAtIndex:i] setImage:[UIImage imageNamed:@"radio-off.png"] forState:UIControlStateNormal];
		
	}
	[[self.payPalRadioButton objectAtIndex:index] setImage:[UIImage imageNamed:@"radio-on.png"] forState:UIControlStateNormal];
}
@end
