//
//  ALTableViewController.h
//  
//
//  Created by 李 亞霖 on 2011/10/11.
//   
//

#import <UIKit/UIKit.h>
#import "ALViewController.h"


//@interface ALTableViewController : UITableViewController
@interface ALTableViewController : ALViewController <UITableViewDataSource,UITableViewDelegate>	{
	UITableView * _tableView;
}
@property (nonatomic ,strong) IBOutlet UITableView * tableView;
@property (nonatomic ,strong) NSArray * dataArray;

- (void)myInit;


@end
