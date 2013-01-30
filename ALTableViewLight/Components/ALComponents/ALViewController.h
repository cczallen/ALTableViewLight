//
//  ALViewController.h
//  
//
//  Created by 李 亞霖 on 2011/10/7.
//   
//

#import <UIKit/UIKit.h>
#import "Define.h"

@interface ALViewController : UIViewController	{
}

@property (nonatomic, weak, readonly, getter = thePopoverController) UIPopoverController * thePopoverController;

+ (id)creatViewControllerFromMainStoryboard;
- (void)myInit;
- (void)dismissSelf;

@end
