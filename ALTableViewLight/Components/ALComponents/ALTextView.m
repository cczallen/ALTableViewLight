//
//  ALTextView.m
//  
//
//  Created by AllenLion on 12/10/4.
//  Copyright (c) 2012年 AllenLee. All rights reserved.
//

#import "ALTextView.h"
#import "Define.h"

@implementation ALTextView

- (id)initWithFrame:(CGRect)frame	{
    self = [super initWithFrame:frame];
    if (self) {
		[self myInit];
    }
    return self;
}
-(void)awakeFromNib {
	[super awakeFromNib];
	[self myInit];
}
-(void)myInit	{
	[self setMaxLength:NSNotFound];
	[self setIsCanBecomeFirstResponder:YES];
}

- (void)dealloc	{
}

- (BOOL)resignFirstResponder	{
	
	CGRect rect = self.sampleTableView.frame;
	rect.size.height = 1;
	[UIView animateWithDuration:0.35 animations:^(void) {
		[self.sampleTableView setFrame:rect];
	}completion:^(BOOL finished) {
		[self.sampleTableView removeFromSuperview];
	}];
	
	return [super resignFirstResponder];
}

- (BOOL)canBecomeFirstResponder	{
	return self.isCanBecomeFirstResponder;
}

- (void)paste:(id)sender	{
	[super paste:sender];
	if (self.maxLength != NSNotFound) {
		if (self.text.length >= self.maxLength) {
			NSString * subString = [self.text substringToIndex:self.maxLength];
			[self setText:subString];
			
			//BDPhotoNoteAndShareViewController
			if ([self.delegate respondsToSelector:@selector(calTextCounter)]) {
				[self.delegate performSelector:@selector(calTextCounter)];
			}
		}
	}
}

- (void)sampleMenuAction	{
	BOOL isFirstResponder = [self isFirstResponder];
	if (!isFirstResponder || self.sampleTableView.superview) {
		return;
	}
	
	CGRect rect = self.frame;	//rect.size.height = 160;
	rect = CGRectMake(20, rect.origin.y, 280, 160);
	UITableView * tv = [[UITableView alloc] initWithFrame:rect style:(UITableViewStylePlain)];
	[tv setIndicatorStyle:(UIScrollViewIndicatorStyleWhite)];
	[tv setBackgroundColor:[UIColor colorWithWhite:0.200 alpha:0.740]];
	[tv setRowHeight:40];
	[tv setDataSource:self];
	[tv setDelegate:self];
	[tv.layer setMasksToBounds:YES];
	[tv.layer setCornerRadius:CornerRadiusForView];
	[self.superview addSubview:tv];
	
	CGRect rectBeforeAnimation = rect;
	rectBeforeAnimation.size.height = 1;
	[tv setFrame:rectBeforeAnimation];
	[UIView animateWithDuration:0.35 animations:^(void) {
		[tv setFrame:rect];
	}completion:^(BOOL finished) {
		[tv flashScrollIndicators];
	}];
	[self setSampleTableView:tv];
}


#pragma mark - Table view data source & delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView	{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section	{
    return [self.samples count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
		[cell.textLabel setTextColor:[UIColor colorWithWhite:0.902 alpha:1.000]];
		[cell.textLabel setFont:[UIFont systemFontOfSize:12]];
		[cell.textLabel setNumberOfLines:2];
		[cell.textLabel setAdjustsLetterSpacingToFitWidth:YES];
		[cell.textLabel setAdjustsFontSizeToFitWidth:YES];
    }
    
    // Configure the cell...
	NSInteger myRow = indexPath.row;
	NSString * str = [self.samples objectAtIndex:myRow];
	[cell.textLabel setText:str];
	
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath	{
	NSInteger myRow = indexPath.row;
	if (myRow == 0) {
		//cancel
		CGRect rect = self.sampleTableView.frame;
		rect.size.height = 1;
		[UIView animateWithDuration:0.35 animations:^(void) {
			[self.sampleTableView setFrame:rect];
		}completion:^(BOOL finished) {
			[self.sampleTableView removeFromSuperview];
		}];
		return;
	}
	//set text
	NSString * strSample = [self.samples objectAtIndex:myRow];
	
	if ([self.selectedTextRange isEmpty] == NO)	{
		[self replaceRange:self.selectedTextRange withText:strSample];
	}else	{
		NSString * str = [self.text stringByAppendingFormat:@"%@%@" ,  (self.text.length ==0)?@"":@"\n" ,strSample];
		[self setText:str];
	}
	
	//animation
	[UIView animateWithDuration:0.1 animations:^(void) {
		[self.sampleTableView setAlpha:0];
	}completion:^(BOOL finished) {
		[self.sampleTableView removeFromSuperview];
	}];
}



- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
	/*
    if (action == @selector(paste:))
    {
        return NO;
    }
    else if (action == @selector(copy:))
    {
        return NO;
    }
	else if (action == @selector(select:))
    {
        return NO;
    }
	else if (action == @selector(selectAll:))
    {
        return NO;
    }
	*/
	if (action == @selector(sampleMenuAction:))
    {
        return YES;
    }
    return [super canPerformAction:action withSender:sender];
}


@end
