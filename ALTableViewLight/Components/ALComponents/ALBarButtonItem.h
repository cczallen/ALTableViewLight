//
//  CargoBarButtonItem.h =>ALBarButtonItem
//  
//
//  Created by 亞霖 李 on 12/3/20.
//  Copyright (c) 2012年 SYSTEX 精誠資訊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ALBarButtonItem : UIBarButtonItem

@property (nonatomic, readwrite) BOOL isBackItem;

+ (ALBarButtonItem *)barButtonItemWithTitle:(NSString *)itemTitle ClickAction:(void (^)(id sender))action;
+ (ALBarButtonItem *)backBarButtonItemByNaVC:(UINavigationController *)naVC;
+ (ALBarButtonItem *)backBarButtonItemWithBackAction:(void (^)(id sender))action;

- (UIButton *)button;

- (void)setTitle:(NSString *)title;

@end
