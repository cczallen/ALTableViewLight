//
//  FirstViewController.m
//  ALTableViewLight
//
//  Created by Allen Lee on 13/1/30.
//  Copyright (c) 2013年 cczallen. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)loadView	{
	//data
	NSArray * dataArray = @[@"1",@"2",@"3",@"a",@"b",@"c"];
	
	//init
	ALTableViewLight * tableview = [ALTableViewLight tableViewWithDataArray:dataArray didSelectBlock:^(NSInteger index, id dataObj) {
		[[[UIAlertView alloc] initWithTitle:@"Select:" message:[NSString stringWithFormat:@"%@" , dataObj] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
	}];
	[tableview.tableView setBackgroundColor:[UIColor scrollViewTexturedBackgroundColor]];
	[self setView:tableview];
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

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
