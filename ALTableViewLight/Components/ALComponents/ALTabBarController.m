//
//  ALTabBarController.m
//  
//
//  Created by 李 亞霖 on 2011/10/11.
//   
//

#import "ALTabBarController.h"
#import "Define.h"

//@implementation ALTabBar
//
//@end
////-------------------
//@implementation UITabBarItem (hideTitle)
//- (void)setTitle:(NSString *)title	{
//	//do nothing...
//}
//@end
////-------------------

@interface ALTabBarController ()	 <UITabBarControllerDelegate> {
}

- (void)initViewControllers;

@end


@implementation ALTabBarController

static ALTabBarController * instance = nil;
#pragma mark - init
- (void)initViewControllers {
}

- (void)myInit {
	instance = self;
	
	[self setAppearance];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
		[self myInit];
    }
    return self;
}

-(void)awakeFromNib	{

	[super awakeFromNib];
	[self myInit];
}

- (void)didReceiveMemoryWarning	{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle
- (void)viewDidAppear:(BOOL)animated	{
	[super viewDidAppear:animated];
}
- (void)viewDidLoad	{
    [super viewDidLoad];
	[self initViewControllers];
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex	{
	[super setSelectedIndex:selectedIndex];
	//代傳
	if ([self.delegate respondsToSelector:@selector(tabBarController:didSelectViewController:)]) {
		[self.delegate tabBarController:self didSelectViewController:[self.viewControllers objectAtIndex:selectedIndex]];
	}
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}

- (BOOL)shouldAutorotate	{	//NS_AVAILABLE_IOS(6_0);
	return YES;
}
- (NSUInteger)supportedInterfaceOrientations	{	//NS_AVAILABLE_IOS(6_0);
	if (isIPadDevice) {
		return UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskPortraitUpsideDown;
	}
	return UIInterfaceOrientationMaskPortrait;
}


#pragma mark - UITabBarControllerDelegate
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController	{
	
//	NSInteger iSelNdx = [tabBarController selectedIndex];

}



#pragma mark - Actions
- (void)setAppearance	{
	
	//nav bar
//	[[UINavigationBar appearance] setTintColor:[UIColor colorWithHexRed:92 green:92 blue:92 alpha:0.8]];
	
	//	//button
	//	UIImage * img;
	//	img = [self resizableImagebyName:@"blackButton"];
	//	[[UIButton appearanceWhenContainedIn:[UIView class], nil] setBackgroundImage:img forState:(UIControlStateNormal)];
	//	img = [self resizableImagebyName:@"blackButtonHighlight"];
	//	[[UIButton appearance] setBackgroundImage:img forState:(UIControlStateHighlighted)];
	
}



#pragma mark - Show Hide Tabbar

- (void) hidetabbar	{
	if (isTabBarHidden) {
		return;
	}
	
	[self performSelector:@selector(hidetabbar:) 
			   withObject:[NSNumber numberWithBool:YES] 
			   afterDelay:0.3
	 ];
}
- (void) showtabbar	{
	if (!isTabBarHidden) {
		return;
	}
	
	[self performSelector:@selector(hidetabbar:) 
			   withObject:[NSNumber numberWithBool:NO]
			   afterDelay:0.3
	 ];	
}

// In UITabBarController's custom implementation add following method, 
// this method is all that will do the trick, just call this method 
// whenever tabbar needs to be hidden/shown 
- (void) hidetabbar:(NSNumber*)isHidden {
	
	if ([isHidden boolValue]) {
		if (isTabBarHidden) {
			return;
		}
	}else	{
		if (!isTabBarHidden) {
			return;
		}
	}
	
    UITabBarController *tabBarController = self;
	
//    [UIView beginAnimations:nil context:NULL];
//    [UIView setAnimationDuration:0.5];
	
    CGRect tabbarFrame=CGRectZero;
    for(UIView *theView in tabBarController.view.subviews) {
        //NSLog(@"%@", view);
        if([theView isKindOfClass:[UITabBar class]]) {
            tabbarFrame=theView.frame;
            if ([isHidden boolValue]) {
                tabbarFrame=CGRectMake(tabbarFrame.origin.x, 
                                       tabBarController.view.frame.size.height, 
                                       tabbarFrame.size.width, 
                                       tabbarFrame.size.height);
            } else {
                tabbarFrame=CGRectMake(tabbarFrame.origin.x, 
                                       tabBarController.view.frame.size.height - tabbarFrame.size.height, 
                                       tabbarFrame.size.width,
                                       tabbarFrame.size.height);
            }
            theView.frame=tabbarFrame;
            break;
        }
    }
	
    for(UIView *theView in tabBarController.view.subviews) {
        if(![theView isKindOfClass:[UITabBar class]]) {
            CGRect theViewFrame=theView.frame;
            if ([isHidden boolValue]) {
                theViewFrame=CGRectMake(theViewFrame.origin.x, 
                                        theViewFrame.origin.y, 
                                        theViewFrame.size.width, 
                                        theViewFrame.size.height + tabbarFrame.size.height);
            } else {
                theViewFrame=CGRectMake(theViewFrame.origin.x, 
                                        theViewFrame.origin.y, 
                                        theViewFrame.size.width, 
                                        theViewFrame.size.height - tabbarFrame.size.height);
            }
            theView.frame=theViewFrame;
        }
    }
	//    [UIView commitAnimations];
	
	isTabBarHidden = [isHidden boolValue];
}



+ (ALTabBarController *)getInstance	{
	return instance;
}

@end
