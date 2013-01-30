ALTableViewLight
================

TableView Using Block



Use
```
- (void)viewDidLoad
{
    [super viewDidLoad];
	
	
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
```
