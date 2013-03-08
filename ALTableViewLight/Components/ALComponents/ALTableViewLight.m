//
//  ALTableViewLight.m
//  InfoWatch
//
//  Created by Allen Lee on 13/3/8.
//

#import "ALTableViewLight.h"


@interface ALTableViewLight ()
@property (nonatomic ,strong) NSMutableArray * checkmarkArray;
@end

@implementation ALTableViewLight

+ (ALTableViewLight *)tableViewWithDataArray:(NSArray *)dataArray
							  didSelectBlock:(ALTableViewLightDidSelectBlock)didSelectBlock	{
	
	return [self tableViewWithDataArray:dataArray rowHeight:44 didSelectBlock:didSelectBlock];
}
+ (ALTableViewLight *)tableViewWithDataArray:(NSArray *)dataArray
								   rowHeight:(CGFloat)rowHeight
							  didSelectBlock:(ALTableViewLightDidSelectBlock)didSelectBlock	{
	
	ALTableViewLight * tableViewLight = [[self alloc] init];
	[tableViewLight setDataArray:dataArray];
	[tableViewLight.tableView setRowHeight:rowHeight];
	[tableViewLight setDidSelectBlock:didSelectBlock];
	
	return tableViewLight;
}


- (void)myInit	{
	[super myInit];
	
	CGRect rect = self.bounds;
	UITableView * tv = [[UITableView alloc] initWithFrame:rect];
	[tv setAutoresizingMask:(UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight)];
	[tv setDataSource:self];
	[tv setDelegate:self];
	[self setTableView:tv];
	[self addSubview:self.tableView];
}



- (void)selectIndex:(NSInteger)index	{
	[self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] animated:YES scrollPosition:(UITableViewScrollPositionTop)];
}

- (void)setCheckmarkOnIndex:(NSInteger)index enabled:(BOOL)enabled	{
	if (self.checkmarkArray == nil) {
		self.checkmarkArray = [NSMutableArray array];
	}
	NSNumber * indexNumber = @(index);
	if (enabled) {
		if (![self.checkmarkArray containsObject:indexNumber]) {
			[self.checkmarkArray addObject:indexNumber];
		}
	}else	{
		if ([self.checkmarkArray containsObject:indexNumber]) {
			[self.checkmarkArray removeObject:indexNumber];
		}
	}
	[self.tableView reloadData];
}


#pragma mark - Table view data source & delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView	{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section	{
    return [self.dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
		[cell.textLabel setAdjustsFontSizeToFitWidth:YES];
		[cell.textLabel setAdjustsLetterSpacingToFitWidth:YES];
    }
    
    // Configure the cell...
	NSInteger myRow = indexPath.row;
	NSString * str = [self.dataArray objectAtIndex:myRow];
	[cell.textLabel setText:str];
	
	[cell setAccessoryType:([self.checkmarkArray containsObject:@(myRow)])?UITableViewCellAccessoryCheckmark:UITableViewCellAccessoryNone];
	
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath	{
	NSInteger myRow = indexPath.row;
	NSString * str = [self.dataArray objectAtIndex:myRow];
	
    if (self.didSelectBlock) {
		self.didSelectBlock(myRow , str);
	}
}

@end

