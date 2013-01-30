//
//  ALTextView.h
//  
//
//  Created by AllenLion on 12/10/4.
//  Copyright (c) 2012年 AllenLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ALTextView : UITextView <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, readwrite) BOOL isCanBecomeFirstResponder;
//for paste
@property (nonatomic, readwrite) uint maxLength;

@property (nonatomic, strong) UITableView * sampleTableView;
@property (nonatomic, strong) NSArray * samples;

@end
