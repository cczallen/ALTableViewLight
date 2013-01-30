//
//  ALBadgeView.h
//  InfoWatch
//
//  Created by Allen Lee on 12/11/12.
//  Copyright (c) 2012年 CSI. All rights reserved.
//


#import "ALView.h"

@interface ALBadgeView : ALView

- (void)setText:(NSString *)text;
- (NSString *)getText;

- (void)setFont:(UIFont *)font;

- (void)increase;
- (void)decrease;

@end
