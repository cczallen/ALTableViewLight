//
//  ALBarButtonItem.m =>ALBarButtonItem 20120421
//  
//
//  Created by 亞霖 李 on 12/3/20.
//  Copyright (c) 2012年 SYSTEX 精誠資訊. All rights reserved.
//

#import "ALBarButtonItem.h"
#import "Define.h"

@implementation ALBarButtonItem
@synthesize isBackItem;

+ (ALBarButtonItem *)barButtonItemWithTitle:(NSString *)itemTitle ClickAction:(void (^)(id sender))action isBackButton:(BOOL)isBack	{
	
	NSString * imgNameOff = (isBack)? @"":@"";
	NSString * imgNameOn  = (isBack)? @"":@"";
	
	UIButton * itemButton =[UIButton buttonWithType:(UIButtonTypeCustom)];
	UIImage * img = [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:imgNameOff ofType:@"png"] ];
	[itemButton setBackgroundImage:img forState:(UIControlStateNormal)];
	img = [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:imgNameOn ofType:@"png"] ];
	[itemButton setBackgroundImage:img forState:(UIControlStateHighlighted)];
	[itemButton setBackgroundImage:img forState:(UIControlStateSelected)];
	[itemButton setFrame:(CGRectMake(0, 0, img.size.width, img.size.height))];
	if (isIPadUI) {	//fix popover
		CGRect rect = CGRectInset(itemButton.frame, 0, 2.5);
		[itemButton setFrame:rect];
	}
	[itemButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
	
	[itemButton setTitle:itemTitle forState:(UIControlStateNormal)];
	[itemButton setClickAction:action];
	ALBarButtonItem * item = [[ALBarButtonItem alloc] initWithCustomView:itemButton];
	[item setIsBackItem:NO];
	
	
	return item;
}


+ (ALBarButtonItem *)barButtonItemWithTitle:(NSString *)itemTitle ClickAction:(void (^)(id sender))action	{

	return [[self class] barButtonItemWithTitle:itemTitle ClickAction:action isBackButton:NO];
}
+ (ALBarButtonItem *)backBarButtonItemByNaVC:(UINavigationController *)naVC	{
	
	ALBarButtonItem * backItem = [[self class] barButtonItemWithTitle:[NSString stringWithFormat:@"  %@",@""]
															 ClickAction:^(id sender){
																 [naVC popViewControllerAnimated:YES];
															 } isBackButton:YES
									 ];
	[backItem setIsBackItem:YES];
	
	
	return backItem;
}

+ (ALBarButtonItem *)backBarButtonItemWithBackAction:(void (^)(id sender))action	{
	ALBarButtonItem * backItem = [[self class] barButtonItemWithTitle:[NSString stringWithFormat:@"  %@",@""]
															 ClickAction:action 
															isBackButton:YES
									 ];
	
	return backItem;
}


- (void)checkTranslationString	{
	if (self.isBackItem) {
		[self setTitle:[NSString stringWithFormat:@"  %@",@"Back"]];
	}
}

- (UIButton *)button	{
	if ([self.customView isKindOfClass:[UIButton class]]) {
		return (UIButton *)self.customView;
	} else {
		return nil;
	}
}

- (void)setTitle:(NSString *)title	{
	[self.button setTitle:title forState:(UIControlStateNormal)];
}

- (void)dealloc	{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
