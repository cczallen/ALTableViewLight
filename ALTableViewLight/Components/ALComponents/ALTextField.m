//
//  ALTextField.m
//  InfoWatch
//
//  Created by Allen Lee on 12/11/20.
//  Copyright (c) 2012年 CSI. All rights reserved.
//

#import "ALTextField.h"

@implementation ALTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void) drawPlaceholderInRect:(CGRect)rect {
	[[UIColor colorWithWhite:0.415 alpha:1.000] setFill];
	[self.placeholder drawInRect:rect withFont:self.font lineBreakMode:NSLineBreakByClipping alignment:self.textAlignment];
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
	
	if (action == @selector(sampleMenuAction))
    {
        return NO;
    } */
    return [super canPerformAction:action withSender:sender];
}


@end
