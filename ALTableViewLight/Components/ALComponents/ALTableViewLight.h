//
//  ALTableViewLight.h
//  InfoWatch
//
//  Created by Allen Lee on 13/3/8.
//

#import <Foundation/Foundation.h>
#import "ALView.h"

typedef void(^ALTableViewLightDidSelectBlock)(NSInteger index , id dataObj);

@interface ALTableViewLight : ALView <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic ,strong) UITableView * tableView;
@property (nonatomic ,strong) NSArray * dataArray;
@property (nonatomic, copy) ALTableViewLightDidSelectBlock didSelectBlock;


+ (ALTableViewLight *)tableViewWithDataArray:(NSArray *)dataArray
							  didSelectBlock:(ALTableViewLightDidSelectBlock)didSelectBlock;

+ (ALTableViewLight *)tableViewWithDataArray:(NSArray *)dataArray
								   rowHeight:(CGFloat)rowHeight
							  didSelectBlock:(ALTableViewLightDidSelectBlock)didSelectBlock;

- (void)selectIndex:(NSInteger)index;
- (void)setCheckmarkOnIndex:(NSInteger)index enabled:(BOOL)enabled;

@end
