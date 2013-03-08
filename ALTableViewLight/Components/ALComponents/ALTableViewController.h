//
//  ALTableViewController.h
//  
//
//  Created by 李 亞霖 on 2011/10/11.
//   
//

#import <UIKit/UIKit.h>
#import "ALViewController.h"
#import "ALTableViewLight.h"

//@interface ALTableViewController : UITableViewController
@interface ALTableViewController : ALViewController <UITableViewDataSource,UITableViewDelegate>	{
	UITableView * _tableView;
}
@property (nonatomic ,strong) IBOutlet UITableView * tableView;
@property (nonatomic ,strong) NSArray * dataArray;

- (void)myInit;


@end


//@class ALTableViewLight;
@interface ALTableViewLightController : ALViewController

@property (nonatomic, strong) ALTableViewLight * tableViewLight;


+ (ALTableViewLightController *)tableViewControllerWithDataArray:(NSArray *)dataArray
												  didSelectBlock:(ALTableViewLightDidSelectBlock)didSelectBlock;

+ (ALTableViewLightController *)tableViewControllerWithDataArray:(NSArray *)dataArray
													   rowHeight:(CGFloat)rowHeight
												  didSelectBlock:(ALTableViewLightDidSelectBlock)didSelectBlock;

- (void)selectIndex:(NSInteger)index;
- (void)setCheckmarkOnIndex:(NSInteger)index enabled:(BOOL)enabled;

@end