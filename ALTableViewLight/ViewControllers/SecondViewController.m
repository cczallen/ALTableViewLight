//
//  SecondViewController.m
//  ALTableViewLight
//
//  Created by Allen Lee on 13/1/30.
//  Copyright (c) 2013年 cczallen. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	
	//data
	NSArray * dataArray = @[@"aaaa",@"bbbb",@"cccc"];
	
	//init
	ALTableViewLight * tableview = [ALTableViewLight tableViewWithDataArray:dataArray didSelectBlock:^(NSInteger index, id dataObj) {
		[[[UIAlertView alloc] initWithTitle:@"Select:" message:[NSString stringWithFormat:@"%@" , dataObj] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
	}];
	[tableview.tableView setBackgroundColor:[UIColor scrollViewTexturedBackgroundColor]];
	[self.view addSubview:tableview];
	NSLog(@"LOG:  tableview: %@",tableview);
	
	//frame
	CGRect rect;
	if (isIPadUI) {
		rect = CGRectMake(200, 300, 400, 500);
	}else	{
		rect = CGRectInset(self.view.frame, 20, 155);
	}
	[tableview setFrame:rect];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
