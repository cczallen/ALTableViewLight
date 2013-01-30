//
//  ALNavigationController.h
//  
//
//  Created by 李 亞霖 on 2011/10/11.
//   
//

/*
@interface UINavigationBar (UINavigationBarBackground)	//from: http://blog.csdn.net/phased_array/article/details/6797737
// 自定義背景顏色
- (void)customizedDrawRect:(CGRect)rect;
// UIViewController可以通過[self.navigationController.navigationBar setCustomizedNaviBar:YES];
-(void)setCustomizedNaviBar:(BOOL)customized;
@end
*/


//-------------------


@interface ALNavigationBar : UINavigationBar
-(void)myInit;
- (void)setDefaultPinkAppearance;
- (void)setPhotoBrowserAppearance;
@end

//@interface PhotoBrowserNavigationBar : ALNavigationBar
//@end


//-------------------


@interface ALNavigationController : UINavigationController

+ (ALNavigationController *)navigationControllerWithClassName:(NSString *)className;
+ (ALNavigationController *)navigationController;	//參考 http://stackoverflow.com/a/9814743
+ (ALNavigationController *)navigationControllerWithRootViewController:(UIViewController *)rootViewController;

-(void)myInit;
//-(void)setBackItem;
//-(void)setBackToMenuItem;

@end


@interface ALRotationNavigationController : ALNavigationController

@end