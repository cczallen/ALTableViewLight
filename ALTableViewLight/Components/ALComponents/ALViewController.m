//
//  ALViewController.m
//  
//
//  Created by 李 亞霖 on 2011/10/7.
//   
//

#import "ALViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation ALViewController

+ (id)creatViewControllerFromMainStoryboard	{
	id vc = [ALUtilities creatViewControllerByStoryboardID:NSStringFromClass([self class])];
//	if (vc == nil)
//		vc = [[[self class] alloc] init];
	return vc;
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

-(void)myInit	{
	// please override & call super first
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


#pragma mark - View lifecycle
- (void)viewWillAppear:(BOOL)animated	{
	[super viewWillAppear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	//debug
//	[self setTitle:NSStringFromClass([self class])];
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
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (NSUInteger)supportedInterfaceOrientations	{	//NS_AVAILABLE_IOS(6_0);
	if (isIPadDevice) {
		return (UIInterfaceOrientationMaskPortrait |UIInterfaceOrientationMaskPortraitUpsideDown);
	}
	return UIInterfaceOrientationMaskPortrait;
}

- (void)dismissSelf	{
	[self dismissViewControllerAnimated:YES completion:nil];
}

//getter
- (UIPopoverController *)thePopoverController	{
	UIPopoverController * thePopoverController = [self valueForKey:@"popoverController"];
	return thePopoverController;
}

@end
