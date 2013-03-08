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
	
	[ALUtilities runBlockAfterDelay:0.75 block:^{
		[self pushController];
	}];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pushController {
	
	//data
	NSArray * dataArray = @[@"aaaa",@"bbbb",@"cccc"];
	
	//init
	ALTableViewLightController * tableViewController =
	[ALTableViewLightController tableViewControllerWithDataArray:dataArray didSelectBlock:^(NSInteger index, id dataObj) {
		[[[UIAlertView alloc] initWithTitle:@"Select:" message:[NSString stringWithFormat:@"%@" , dataObj] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
	}];
	[tableViewController.tableViewLight.tableView setBackgroundColor:[UIColor scrollViewTexturedBackgroundColor]];
	NSLog(@"LOG:  tableViewController: %@",tableViewController);

	[self setTableViewController:tableViewController];
	
	[self.navigationController pushViewController:self.tableViewController animated:YES];
	
//	//frame
//	CGRect rect;
//	if (isIPadUI) {
//		rect = CGRectMake(200, 300, 400, 500);
//	}else	{
//		rect = CGRectInset(self.view.frame, 20, 155);
//	}
//	[tableview setFrame:rect];
}

@end
