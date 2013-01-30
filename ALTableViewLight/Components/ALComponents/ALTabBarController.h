//
//  ALTabBarController.h
//  
//
//  Created by 李 亞霖 on 2011/10/11.
//   
//


//@interface ALTabBar : UITabBar
//@end
//
////-------------------
//@interface UITabBarItem (hideTitle)
//- (void)setTitle:(NSString *)title;
//@end
////-------------------

@interface ALTabBarController : UITabBarController 	{
	BOOL isTabBarHidden;
}

- (void)myInit;

- (void) hidetabbar;	//delayed
- (void) showtabbar;
- (void) hidetabbar:(NSNumber*)isHidden;

+ (ALTabBarController *)getInstance;

@end
