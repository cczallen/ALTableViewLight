//
//  ALNavigationController.m
//  
//
//  Created by 李 亞霖 on 2011/10/11.
//   
//

#import "Define.h"
#import "ALNavigationController.h"

/*
#import <objc/runtime.h>

static  IMP originalMethodOfdrawRect;

@implementation UINavigationBar (UINavigationBarBackground)
// 自定義背景顏色
- (void)customizedDrawRect:(CGRect)rect	{
    UIImage *image = [ALImage imageNamed:@"NavBar.png"]; 
    [image drawInRect:CGRectMake(0,0,self.frame.size.width,self.frame.size.height)];   	
} 

// UIViewController可以通過[self.navigationController.navigationBar setCustomizedNaviBar:YES];
-(void)setCustomizedNaviBar:(BOOL)customized	{
		
    if (originalMethodOfdrawRect ==nil)	{
		
		// 記下原始的drawRect:的地址
		originalMethodOfdrawRect = [self methodForSelector:@selector(drawRect:)];
    }
	
    if (customized)	{
		// 當需要自定背景時，替換selector drawRect:的地址。
		class_replaceMethod([self class],@selector(drawRect:), [self methodForSelector:@selector(customizedDrawRect:)],nil);		
    }else	{
		//當需要用系統的Navi風格時，把selector的函數地址還原。
        class_replaceMethod([self class],@selector(drawRect:),originalMethodOfdrawRect,nil);       
    }
}

@end
*/

//-------------------


@implementation ALNavigationBar

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self myInit];
    }
    return self;
}
-(void)awakeFromNib	{
	
	[super awakeFromNib];
	[self myInit];
}

-(void)myInit	{

	[self setDefaultPinkAppearance];
}

- (void)setDefaultPinkAppearance	{
	NSDictionary *navbarTitleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
											   [UIColor whiteColor],UITextAttributeTextColor,
											   [UIColor colorWithWhite:0 alpha:0.15], UITextAttributeTextShadowColor,
											   [NSValue valueWithUIOffset:UIOffsetMake(1, 1)], UITextAttributeTextShadowOffset,
											   [UIFont fontWithName:@"FV Almelo" size:21], UITextAttributeFont,
											   nil];
	
	[[ALNavigationBar appearance] setTitleTextAttributes:navbarTitleTextAttributes];
	[[ALNavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"NavBarBG"] forBarMetrics:(UIBarMetricsDefault)];
}

- (void)setPhotoBrowserAppearance	{
	NSDictionary *navbarTitleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
											   [UIColor colorWithHexRed:181 green:233 blue:237 alpha:1],UITextAttributeTextColor,
											   [UIColor colorWithWhite:0 alpha:0.15], UITextAttributeTextShadowColor,
											   [NSValue valueWithUIOffset:UIOffsetMake(1, 1)], UITextAttributeTextShadowOffset,
											   [UIFont fontWithName:@"AppleCasual" size:0.0], UITextAttributeFont,
											   nil];
	
	[[ALNavigationBar appearance] setTitleTextAttributes:navbarTitleTextAttributes];
	[[ALNavigationBar appearance] setBackgroundImage:[UIImage imageWithContentsOfFileByPNGNamed:@"PhotoBrowserNabBar"] forBarMetrics:(UIBarMetricsDefault)];
}

@end

/*
@implementation PhotoBrowserNavigationBar

- (void)myInit	{
	[super myInit];
	
	NSDictionary *navbarTitleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
											   [UIColor whiteColor],UITextAttributeTextColor,
											   [UIColor colorWithHexRed:181 green:233 blue:237 alpha:1], UITextAttributeTextShadowColor,
											   [NSValue valueWithUIOffset:UIOffsetMake(1, 1)], UITextAttributeTextShadowOffset,
											   [UIFont fontWithName:@"AppleCasual" size:0.0], UITextAttributeFont,
											   nil];
	
	[[PhotoBrowserNavigationBar appearance] setTitleTextAttributes:navbarTitleTextAttributes];
	[[PhotoBrowserNavigationBar appearance] setBackgroundImage:[UIImage imageWithContentsOfFileByPNGNamed:@"PhotoBrowserNabBar"] forBarMetrics:(UIBarMetricsDefault)];
}

@end
*/


//-------------------


@implementation ALNavigationController

+ (ALNavigationController *)navigationControllerWithClassName:(NSString *)className
{
	Class MyClass = NSClassFromString(className);
//	UIViewController * rootViewController = [[MyClass alloc] initWithNibName:className bundle:[NSBundle mainBundle]];
	UIViewController * rootViewController = [[MyClass alloc] init];
//	[rootViewController autorelease];
	
    ALNavigationController *controller = [[self class] navigationController];
    [controller setViewControllers:[NSArray arrayWithObject:rootViewController]];
    return controller;
}

+ (ALNavigationController *)navigationController
{	//為了替換NavigationBar
	NSString * nibName = NSStringFromClass([self class]);	//@"ALNavigationController"/@"ALRotationNavigationController"
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil];
    ALNavigationController *controller = (ALNavigationController *)[nib objectAtIndex:0];
    return controller;
}


+ (ALNavigationController *)navigationControllerWithRootViewController:(UIViewController *)rootViewController
{
    ALNavigationController *controller = [[self class] navigationController];
    [controller setViewControllers:[NSArray arrayWithObject:rootViewController]];
    return controller;
}

- (id)init
{
    self = [super init];
//    [self autorelease]; // We are ditching the one they allocated.  Need to load from NIB.
//    return [[ALNavigationController navigationController] retain]; // Over-retain, this should be alloced
	return [ALNavigationController navigationController];
}

- (id)initWithRootViewController:(UIViewController *)rootViewController
{
    self = [super init];
//    [self autorelease];
//    return [[[self class] navigationControllerWithRootViewController:rootViewController] retain];
	return [[self class] navigationControllerWithRootViewController:rootViewController];
}
//
//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}

-(void)awakeFromNib	{
	
	[super awakeFromNib];
	[self myInit];
}

-(void)myInit	{
//	[self.navigationBar setCustomizedNaviBar:YES];
}


#pragma mark - View lifecycle
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
//	[self setBackToMenuItem];
}

/*
-(void)setBackToMenuItem	{
	
	UIButton * button = [UIButton buttonWithType:(UIButtonTypeCustom)];
	[button setImage:[ALImage imageNamed:@"BtHome"] forState:(UIControlStateNormal)];
	[button setFrame:CGRectMake(0, 0, button.imageView.image.size.width, button.imageView.image.size.height)];
	[button setClickAction:^{
		[[NSNotificationCenter defaultCenter] postNotificationName:SHOWMENUVIEWKEY 
															object:nil
		 ];
	}];
	UIBarButtonItem * backToMenuItem = [[UIBarButtonItem alloc] initWithCustomView:button];
										

	UIViewController * rootViewController = [self.viewControllers objectAtIndex:0];
	[rootViewController.navigationItem setLeftBarButtonItem:backToMenuItem];	[backToMenuItem release];	
}
*/
-(void)setBackItem	{
	// create a custom navigation bar button and set it to always say "back"
	ALBarButtonItem * backItem = [ALBarButtonItem backBarButtonItemByNaVC:self];
	[self.topViewController.navigationItem setLeftBarButtonItem:backItem];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}

- (NSUInteger)supportedInterfaceOrientations	{	//NS_AVAILABLE_IOS(6_0);
	if (isIPadDevice) {
		return (UIInterfaceOrientationMaskPortrait |UIInterfaceOrientationMaskPortraitUpsideDown);
	}
	return UIInterfaceOrientationMaskPortrait;
}

// Uses a horizontal slide transition. Has no effect if the view controller is already in the stack.
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated	
{
	[super pushViewController:viewController animated:animated];
	if ( ![viewController isEqual:[self.viewControllers objectAtIndex:0]]) {
	    [self setBackItem];
	}
}


@end


@implementation ALRotationNavigationController

- (BOOL)shouldAutorotate	{	//NS_AVAILABLE_IOS(6_0);
	return NO;
}
- (NSUInteger)supportedInterfaceOrientations	{	//NS_AVAILABLE_IOS(6_0);
	return UIInterfaceOrientationMaskAll;
}

@end