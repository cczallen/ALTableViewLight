//
//  ALBadgeView.m
//  InfoWatch
//
//  Created by Allen Lee on 12/11/12.
//  Copyright (c) 2012年 CSI. All rights reserved.
//

#import "ALBadgeView.h"
#import "Define.h"

@interface ALBadgeView	()

@property (nonatomic, strong) UIImageView * bgImv;
@property (nonatomic, strong) UILabel * lb;

@end

@implementation ALBadgeView

- (void)setText:(NSString *)text	{
	[self.lb setText:text];
	[self.lb sizeToFit];
	CGFloat width = self.lb.width;
	width += 12;
	if (width <20)	width = 20;
	[self setWidth:width];
}

- (NSString *)getText	{
	return self.lb.text;
}

- (void)setFont:(UIFont *)font	{
	[self.lb setFont:font];
	//resize
	[self.lb setText:self.lb.text];
}


-(void)myInit	{
	[self setUserInteractionEnabled:NO];
	[self setBackgroundColor:[UIColor clearColor]];
	
	UIView * shadowView = self;
	[shadowView.layer setShadowOffset:CGSizeMake(1, 1)];
	[shadowView.layer setShadowRadius:2];
	[shadowView.layer setShadowColor:[UIColor blackColor].CGColor];
	[shadowView.layer setShadowOpacity:0.6];

	
	UIImage * bgImg = [UIImage imageNamed:@"badge"];
	CGFloat edge = 11;
	bgImg = [bgImg resizableImageWithCapInsets:(UIEdgeInsetsMake(edge, edge, edge, edge)) resizingMode:(UIImageResizingModeStretch)];
	UIImageView * bgImv = [[UIImageView alloc] initWithImage:bgImg];
	[bgImv setContentMode:(UIViewContentModeScaleToFill)];
	[bgImv setBackgroundColor:[UIColor clearColor]];
	[self addSubview:bgImv];
	
	UILabel * lb = [[UILabel alloc] init];
	[lb setBackgroundColor:[UIColor clearColor]];
	[lb setTextAlignment:(NSTextAlignmentCenter)];
	[lb setTextColor:[UIColor whiteColor]];
	[lb setFont:[UIFont boldSystemFontOfSize:10]];
	[self addSubview:lb];
	

	[self setBgImv:bgImv];
	[self setLb:lb];
	
	[self setText:@"0"];
}

- (void)setFrame:(CGRect)frame	{

	CGRect rect = frame;
	rect.size.height = 20;//23;
	[super setFrame:rect];
}

- (void)layoutSubviews	{
	[super layoutSubviews];

	CGRect rect = self.bounds;
	[self.bgImv setBounds:rect];
	
	[self.bgImv moveToSuperviewsCenter];
	[self.lb moveToSuperviewsCenter];
}

- (void)increase	{
	NSString * text = [self getText];
	NSString * increasedText = NSStringFromInt([text integerValue] +1);
	[self setText:increasedText];
}

- (void)decrease	{
	NSString * text = [self getText];
	NSString * decreasedText = NSStringFromInt([text integerValue] -1);
	[self setText:decreasedText];
}

/*
//test
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event	{
	NSInteger num = [self.lb.text integerValue];
	num++;
	[self setText:NSStringFromInt(num)];
}
*/

@end
