//
//  ALUtilities.m
//
//
//  Created by AllenLion on 12/9/18.
//  Copyright (c) 2012年 AllenLee. All rights reserved.
//

#import "ALUtilities.h"
//#import "DescriptionBuilder.h"
#import <QuartzCore/QuartzCore.h>
#import <objc/runtime.h>

UIKIT_EXTERN NSString *NSStringFromInt(NSInteger num)	{
	NSString * strNum = [NSString stringWithFormat:@"%i",num];
	return strNum;
}

UIKIT_EXTERN NSString *NSStringFromFloat(CGFloat num)	{
	NSString * strNum = [NSString stringWithFormat:@"%f",num];
	return strNum;
}
UIKIT_EXTERN double km2mile(double km)	{
	return km * 0.62137119;
}

static int indentLevelForLog = 0;		//for NSArray log


@implementation ALUtilities

//判斷iOS版本
+(BOOL)isIOS4	{
	NSString *osversion = [UIDevice currentDevice].systemVersion;
	
	if ( [osversion floatValue] >= 4.0 && [osversion floatValue] < 5.0)
		return	YES;
	return	NO;
}

+(BOOL)isIOS5	{
	NSString *osversion = [UIDevice currentDevice].systemVersion;
	
	if ( [osversion floatValue] >= 5.0 && [osversion floatValue] < 6.0)
		return	YES;
	return	NO;
}

+(BOOL)isIOS4Later	{
	NSString *osversion = [UIDevice currentDevice].systemVersion;
	
	if ( [osversion floatValue] >= 4.0)
		return	YES;
	return	NO;
}
+(BOOL)isIOS5Later	{
	NSString *osversion = [UIDevice currentDevice].systemVersion;
	
	if ( [osversion floatValue] >= 5.0)
		return	YES;
	return	NO;
}
+(BOOL)isIOS6Later	{
	NSString *osversion = [UIDevice currentDevice].systemVersion;
	
	if ( [osversion floatValue] >= 6.0)
		return	YES;
	return	NO;
}

+(void)runBlockAfterDelay:(NSTimeInterval)delay block:(void (^)(void))block	{
	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC*delay),	\
				   dispatch_get_main_queue(), block);
}

//background task
#define isMultitaskingSupported		(([[UIDevice currentDevice] respondsToSelector:@selector(isMultitaskingSupported)])? [UIDevice currentDevice].multitaskingSupported : NO)
UIBackgroundTaskIdentifier backgroundTask;
+ (void)beginBackgroundTask	{
	if (isMultitaskingSupported == NO) {
		return;
	}
	
	if (!backgroundTask || backgroundTask == UIBackgroundTaskInvalid) {
		id __weak weakSelf = self;
		backgroundTask = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
			// Synchronize the cleanup call on the main thread in case
			// the task actually finishes at around the same time.
			[weakSelf beginBackgroundTask];
		}];
	}
}
+ (void)beginBackgroundTaskWithUnlimitedTime	{
	if (isMultitaskingSupported == NO) {
		return;
	}
	
	if (!backgroundTask || backgroundTask == UIBackgroundTaskInvalid) {
		id __weak weakSelf = self;
		backgroundTask = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
			// Synchronize the cleanup call on the main thread in case
			// the task actually finishes at around the same time.
			[weakSelf endBackgroundTask];
		}];
	}
}
+ (void)endBackgroundTask	{
	if (isMultitaskingSupported == NO) {
		return;
	}
	
	dispatch_async(dispatch_get_main_queue(), ^{
		if (backgroundTask != UIBackgroundTaskInvalid) {
			[[UIApplication sharedApplication] endBackgroundTask:backgroundTask];
			backgroundTask = UIBackgroundTaskInvalid;
		}
	});
}

//檢核用
+ (BOOL)checkUnicharIsNumeric:(unichar)c	{
	if ( c>=48  && c<=57 ) {
		//數字
		return YES;
		
	} else {
		//非數字
		return NO;
	}
}
+ (BOOL)checkUnicharIsAlphabetic:(unichar)c	{
	if ( ( c>=65  && c<=90 ) || ( c>=97  && c<=122 ) ) {
		//英文字母大寫或小寫
		return YES;
		
	} else {
		//非英文字母
		return NO;
	}
}

+ (BOOL)checkStringIsAllNumeric:(NSString *)str	{
	
	BOOL isAllNumeric = YES;
	for (int i=0; i<[str length]; i++) {
		unichar c = [str characterAtIndex:i];
		if ( [ALUtilities checkUnicharIsNumeric:c] == NO ) {		//非數字
			isAllNumeric = NO;
		}
	}
	NSLog(@"LOG: %@ isAllNumeric: %@", str ,(isAllNumeric)? @"YES":@"NO" );
	if (isAllNumeric) {
		return YES;
	}else	{
		return NO;
	}
}

+ (BOOL)checkStringIsAllAlphabetic:(NSString *)str	{
	
	BOOL isAllAlphabetic = YES;
	for (int i=0; i<[str length]; i++) {
		unichar c = [str characterAtIndex:i];
		if ( [ALUtilities checkUnicharIsAlphabetic:c] == NO ) {		//非數字
			isAllAlphabetic = NO;
		}
	}
	NSLog(@"LOG:  isAllAlphabetic: %@",(isAllAlphabetic)? @"YES":@"NO" );
	if (isAllAlphabetic) {
		return YES;
	}else	{
		return NO;
	}
}

+ (NSString *)KG2LB:(NSString *)kg	{
	
	NSNumberFormatter * numFormatter = [[NSNumberFormatter alloc] init];
	[numFormatter setNumberStyle:(NSNumberFormatterDecimalStyle)];
	[numFormatter setMaximumFractionDigits:1];
	
	NSNumber * numKg = [numFormatter numberFromString:kg];
	NSNumber * numLb = [NSNumber numberWithFloat: [numKg floatValue] *2.20462 ];
	
	NSString * strLb = [numFormatter stringFromNumber:numLb];
	
	return strLb;
}

static NSTimeInterval activityStartTime;
+ (void)activityStartAnimating	{
	//卡住畫面
	[[UIApplication sharedApplication] beginIgnoringInteractionEvents];
	
	UIWindow * window = [[[UIApplication sharedApplication] delegate] window];
	//activity旋轉
	UIActivityIndicatorView * acitvityV = (UIActivityIndicatorView *)[window viewWithTag:ACTIVITYVIEWKEY];
	if (acitvityV ==nil) {
		//畫面變灰
		UIView * grayView = [[UIView alloc] initWithFrame:window.bounds];
		[grayView setBackgroundColor:[UIColor colorWithWhite:0.8 alpha:0.6]];
		[grayView setAutoresizingMask:(UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight)];
		//init
		acitvityV = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyleWhiteLarge)];
		[acitvityV setTag:ACTIVITYVIEWKEY];
		[grayView addSubview:acitvityV];	//[acitvityV release];
		[window addSubview:grayView];	//[grayView release];
		[acitvityV moveToSuperviewsCenter];
	}else {
		UIView * grayView = acitvityV.superview;
		[grayView setAlpha:1];
	}
	[acitvityV startAnimating];
	activityStartTime = [[NSDate date] timeIntervalSince1970];
}
+ (void)activityStopAnimating	{
	//至少轉Duration秒
	NSTimeInterval Duration = 0.35;
	NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
	if (now -activityStartTime <Duration) {
		[ALUtilities runBlockAfterDelay:Duration block:^{
			[ALUtilities activityStopAnimating];
		}];
		return;
	}
	
	//卡住畫面
	[[UIApplication sharedApplication] endIgnoringInteractionEvents];
	
	UIWindow * window = [[[UIApplication sharedApplication] delegate] window];
	//activity旋轉
	UIActivityIndicatorView * acitvityV = (UIActivityIndicatorView *)[window viewWithTag:ACTIVITYVIEWKEY];
	if (acitvityV ==nil) {
		//ignore
		return;
	}else {
		//畫面變灰
		UIView * grayView = acitvityV.superview;
		[grayView setAlpha:0];
	}
	[acitvityV stopAnimating];
}


+ (id)creatViewByName:(NSString *)className	{
	Class ViewClass = NSClassFromString(className);
	if (ViewClass == nil) {
		return nil;
	}
	
	id view = nil;
	NSArray * nibObjects = [ [NSBundle mainBundle] loadNibNamed:className owner:nil options:nil];
	for ( id currentObject in nibObjects ) {
		if ([currentObject isKindOfClass:ViewClass ]  ) {
			view = currentObject;
		}
	}
	
	//	return [[view retain] autorelease];
	return view;
}

+ (id)creatViewControllerByStoryboardID:(NSString *)stroyboardID	{
	
#ifdef Version_Campus
	return [[self class] creatViewControllerByStoryboardID:stroyboardID andStoryboardName:@"MainStoryboard_Version_Campus_iPhone"];	//MainStoryboard
#else
	return [[self class] creatViewControllerByStoryboardID:stroyboardID andStoryboardName:@"MainStoryboard_iPhone"];	//MainStoryboard
#endif
}
+ (id)creatViewControllerByStoryboardID:(NSString *)stroyboardID andStoryboardName:(NSString *)stroyboardName	{
	UIStoryboard * mainStroyboard = [UIStoryboard storyboardWithName:stroyboardName bundle:nil];
	UIViewController * VC = [mainStroyboard instantiateViewControllerWithIdentifier:stroyboardID];
	return VC;
}

+ (NSString *)NSDateToStrDate:(NSDate *)date	{
	
	NSDateFormatter * dateF = [[NSDateFormatter alloc] init];
	[dateF setDateFormat:@"yyyy/MM/dd"];
	[dateF setTimeZone:[NSTimeZone localTimeZone]];
	NSString * strDate = [dateF stringFromDate:date];
	
	return strDate;
}
+ (NSString *)NSDateToStrTime:(NSDate *)date	{
	
	NSDateFormatter * dateF = [[NSDateFormatter alloc] init];
	[dateF setDateFormat:@"HH:mm"];
	[dateF setTimeZone:[NSTimeZone localTimeZone]];
	NSString * strTime = [dateF stringFromDate:date];
	
	return strTime;
}
+ (NSString *)NSDateToStrDateAndTime:(NSDate *)date	{
	
	NSDateFormatter * dateF = [[NSDateFormatter alloc] init];
	[dateF setDateFormat:@"yyyy/MM/dd HH:mm"];
	[dateF setTimeZone:[NSTimeZone localTimeZone]];
	NSString * strTime = [dateF stringFromDate:date];
	
	return strTime;
}

+ (NSDate *)NSStringToNSDate:(NSString *)strDate	{
	
	NSDateFormatter * dateF = [[NSDateFormatter alloc] init];
	[dateF setDateFormat:@"YYYY/MM/dd"];
	NSDate * date = [dateF dateFromString:strDate];
	
	return date;
}
+ (NSDate *)NSStringToNSDateTime:(NSString *)strDate	{
	
	NSDateFormatter * dateF = [[NSDateFormatter alloc] init];
	[dateF setDateFormat:@"HH:mm"];
	NSDate * date = [dateF dateFromString:strDate];
	
	return date;
}

+ (CGRect)getSquareRect:(CGRect)rect	{
	
	CGFloat width = MIN(rect.size.width, rect.size.height);
	if (width == rect.size.width && width == rect.size.height) {
		return rect;
	}
	CGFloat x = 0, y = 0;
	BOOL isLandscape = rect.size.width > rect.size.height;
	if (isLandscape) {
		x = (rect.size.width - width) *0.5;
	}else	{
		y = (rect.size.height - width) *0.5;
	}
	
	CGRect newRect = CGRectMake(x, y, width, width);
	return newRect;
}

//+ (NSString *)MyPhoneNumber {		//http://stackoverflow.com/questions/193182/programmatically-get-own-phone-number-in-iphone-os
//	NSString * phone = CTSettingCopyMyPhoneNumber();
//	if (phone == nil) {
//		NSLog(@"LOG:  phone == nil");
//		return nil;
//	}
//	return phone;
//}
+ (BOOL)call:(NSString *)strNumber	{
	
	//	//1
	//	NSString * strURL = [NSString stringWithFormat:@"tel:%@" , strNumber];
	//	UIWebView * webview = [[UIWebView alloc] init];
	//	[webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:strURL]]];
	
	//2
	strNumber = [strNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
	strNumber = [strNumber stringByReplacingOccurrencesOfString:@")" withString:@""];
	strNumber = [strNumber stringByReplacingOccurrencesOfString:@"(" withString:@""];
	strNumber = [strNumber stringByReplacingOccurrencesOfString:@"-" withString:@""];
	NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"telprompt:%@" , strNumber]];
	if ([[UIApplication sharedApplication] canOpenURL:url]) {
		[[UIApplication sharedApplication] openURL:url];
		return YES;
	}else	{
		return NO;
	}
}
@end


@implementation UIView (frameMethods)

-(void)moveToSuperviewsCenter	{
	
	if (self.superview == nil) {
		NSLog(@"LOG:  self.superview == nil]");
		return;
	}
	
	CGRect rect = self.frame;
	rect.origin.x = (self.superview.frame.size.width -self.frame.size.width) *0.5;
	rect.origin.y = (self.superview.frame.size.height -self.frame.size.height) *0.5;
	
	[self setFrame:rect];
}

-(void)moveToThisviewsCenter:(UIView *)thisView	{
	
	if (thisView == nil) {
		NSLog(@"LOG:  thisView == nil]");
		return;
	}
	
	CGRect rect = self.frame;
	rect.origin.x = (thisView.frame.size.width -self.frame.size.width) *0.5;
	rect.origin.y = (thisView.frame.size.height -self.frame.size.height) *0.5;
	
	[self setFrame:rect];
}

-(void)moveToNewOrigin:(CGPoint)newOrigin	{
	
	[self setFrame:CGRectMake(newOrigin.x, newOrigin.y, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
}

-(void)setFrameSameAsSuperView	{
	UIView * superView = self.superview;
	if (superView == nil)	{
		NSLog(@"LOG:  (superView == nil)]");
		return;
	}
	
	CGRect rect = superView.frame;
	rect.origin = CGPointZero;
	[self setFrame:rect];
}

-(void)setFrameIntegral	{	//20120404
	[self setFrame:CGRectIntegral(self.frame)];
}

- (CGFloat)getTotalXFrom:(UIView *)view	{
	if ([self isEqual:view] || self.superview == nil) {
		return self.frame.origin.x;
	}else {
		return [self.superview getTotalXFrom:view] + self.frame.origin.x;
	}
}
- (CGFloat)getTotalYFrom:(UIView *)view	{
	if ([self isEqual:view] || self.superview == nil) {
		return self.frame.origin.y;
	}else {
		return [self.superview getTotalYFrom:view] + self.frame.origin.y;
	}
}


-(void)addSubviewAtTheSamePlaceTo:(UIView *)view	{
	CGRect rect;
	
	CGFloat x = [self getTotalXFrom:view];
	CGFloat y = [self getTotalYFrom:view];
	rect = CGRectMake(x, y, self.frame.size.width, self.frame.size.height);
	
	
	[self setFrame:rect];
	[view addSubview:self];
}

/* 另一方法！！
 // Convenient category method to find actual ViewController that contains a view
 // Adapted from: http://stackoverflow.com/questions/1340434/get-to-uiviewcontroller-from-uiview-on-iphone
 
 @implementation UIView (FindUIViewController)
 - (UIViewController *) containingViewController {
 UIView * target = self.superview ? self.superview : self;
 return (UIViewController *)[target traverseResponderChainForUIViewController];
 }
 
 - (id) traverseResponderChainForUIViewController {
 id nextResponder = [self nextResponder];
 BOOL isViewController = [nextResponder isKindOfClass:[UIViewController class]];
 BOOL isTabBarController = [nextResponder isKindOfClass:[UITabBarController class]];
 if (isViewController && !isTabBarController) {
 return nextResponder;
 } else if(isTabBarController){
 UITabBarController *tabBarController = nextResponder;
 return [tabBarController selectedViewController];
 } else if ([nextResponder isKindOfClass:[UIView class]]) {
 return [nextResponder traverseResponderChainForUIViewController];
 } else {
 return nil;
 }
 }
 
 */

-(UIViewController *)findNearestViewController	{
	
	UIViewController * targetViewController = nil;
	UIView * targetView = nil;
	
	targetView = self;
	do {
		
		if (targetView.superview == nil)
			break;
		
		targetView = targetView.superview;
		
	} while ( ![targetView.nextResponder isKindOfClass:[UIViewController class]] );
	
	
	if ([targetView.nextResponder isKindOfClass:[UIViewController class]]) {
		targetViewController = (UIViewController *)targetView.nextResponder;
		return targetViewController;
	}else	{
		return nil;
	}
}

-(UIView *)findNearestViewControllersView	{
	
	UIView * targetView = nil;
	
	targetView = self;
	do {
		
		if (targetView.superview == nil)
			break;
		
		targetView = targetView.superview;
		
	} while ( ![targetView.nextResponder isKindOfClass:[UIViewController class]] );
	
	
	return targetView;
}

-(void)resignAllResponder	{
	
    for (UIView* view in self.subviews) {
        
        if ([view isKindOfClass:[UITextField class]])
            
            [view resignFirstResponder];
        
    }
}

- (id)findFirstResponder	{
	id firstResponder = nil;
	
	for (UIView * subview in [self subviews]) {
		if ([subview isFirstResponder]) {
			firstResponder = subview;
			break;
		}
	}
	
	return firstResponder;
}

//+ (UIImage*)captureView:(UIView *)theView
//{
//	CGRect rect = theView.frame;
//	UIGraphicsBeginImageContext(rect.size);
//	CGContextRef context = UIGraphicsGetCurrentContext();
//	[theView.layer renderInContext:context];
//	UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
//	UIGraphicsEndImageContext();
//	return img;
//}


#pragma mark -


//
-(id)findNearestScrollView	{
	
	UIScrollView * scrollView = [self findNearestScrollViewStartFrom:self];
	
	return scrollView;
}
-(id)findNearestScrollViewStartFrom:(UIView *)view	{
	
	id targetScrollView = view;
	while (YES) {
		
		targetScrollView = [targetScrollView superview];
		if (targetScrollView == nil) {
			break;
		}
		if ([targetScrollView isKindOfClass:[UIScrollView class]]) {
			break;
		}
	}
	
	return targetScrollView;
}


-(void)showPoint:(CGPoint)pt	{
	
	UIView * centerPoint = [[UIView alloc] initWithFrame:(CGRectMake(0, 0, 10, 10))];
	[centerPoint setBackgroundColor:[UIColor whiteColor]];
	[centerPoint moveToNewOrigin:pt];
	[self addSubview:centerPoint];	//[centerPoint release];
	
}

static NSTimeInterval CAAnimDuraion = 0.0;
+ (void)setCAAnimationDuration:(NSTimeInterval)dura	{	//20120604
	CAAnimDuraion = dura;
}
+ (NSTimeInterval)getCAAnimationDuration	{	// 20130221
	return CAAnimDuraion;
}
- (void)addCAAnimationFromTop	{
	[self addCAAnimationBykCATransitionFrom:kCATransitionFromTop];
}
- (void)addCAAnimationFromBottom	{
	[self addCAAnimationBykCATransitionFrom:kCATransitionFromBottom];
}
- (void)addCAAnimationFromLeft	{
	[self addCAAnimationBykCATransitionFrom:kCATransitionFromLeft];
}
- (void)addCAAnimationFromRight	{
	[self addCAAnimationBykCATransitionFrom:kCATransitionFromRight];
}

- (void)addCAAnimationBykCATransitionFrom:(NSString *)from	{
	//使用動畫
	if ( [ALUtilities isIOS4Later] ) {
		UIView * targetView = self;
		CATransition* transition = [CATransition animation];
		transition.duration = (CAAnimDuraion == 0.0)?0.23:CAAnimDuraion;
		transition.type = kCATransitionPush;
		transition.subtype = from;
		
		[targetView.layer addAnimation:transition forKey:nil];
	}
}

- (void)drawBorder	{
	[self.layer setBorderColor:GetRandomColor.CGColor];
	[self.layer setBorderWidth:1];
	for ( UIView *subview in [self subviews]) {
		[subview drawBorder];
	}
}

// Return an exhaustive descent of the view's subviews
//NSArray *allSubviews(UIView *aView)
- (NSArray *)allSubviews
{
    NSArray *results = [self subviews];
    for (UIView *eachView in [self subviews]) {
		NSArray * riz = [eachView allSubviews];
        if (riz)
			results = [results arrayByAddingObjectsFromArray:riz];
    }
    return results;
}

// Return all views throughout the application
- (NSArray *)allApplicationViews
{
    NSArray *results = [[UIApplication sharedApplication] windows];
    for (UIWindow *window in [[UIApplication sharedApplication]windows]) {
        NSArray *riz = [window allSubviews];
        if (riz) results = [results arrayByAddingObjectsFromArray:riz];
    }
    return results;
}

// Return an array of parent views from the window down to the view
- (NSArray *)pathToView
{
    NSMutableArray *array = [NSMutableArray arrayWithObject:self];
    UIView *view = self;
    UIWindow *window = self.window;
    while (view != window)
    {
        view = [view superview];
        [array insertObject:view atIndex:0];
    }
    return array;
}

- (UIImage *)captureImage	{
	return [UIImage captureImageFromView:self];
}

@end


@implementation UIImage (ResizeMethods)
//自行定義的函式用來取得UIView中的UIImage
+ (UIImage *)captureImageFromView:(UIView *)theView {
	
	//設定邊界大小和影像透明度與比例
	//	UIGraphicsBeginImageContextWithOptions(theView.bounds.size, theView.opaque, 0.0);
	UIGraphicsBeginImageContextWithOptions(theView.bounds.size, NO, 0.0);
	[theView.layer renderInContext:UIGraphicsGetCurrentContext()];
	
	//取得影像
	UIImage *captureImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	return captureImage;
}

+ (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize	{
	
	UIGraphicsBeginImageContext(CGSizeMake(reSize.width, reSize.height));
	[image drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
	UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return reSizeImage;
	
//	return [image resizedImage:reSize interpolationQuality:(kCGInterpolationDefault)];
}

+ (UIImage *)imageWithContentsOfFileByPNGNamed:(NSString *)imgName	{
	NSString * path = [[NSBundle mainBundle] pathForResource:imgName ofType:@"png"];
	return [UIImage imageWithContentsOfFile:path];
}
+ (UIImage *)imageWithContentsOfFileByJPGNamed:(NSString *)imgName	{
	NSString * path = [[NSBundle mainBundle] pathForResource:imgName ofType:@"png"];
	return [UIImage imageWithContentsOfFile:path];
}
//- (UIImage *)imageWithCropToSquareScaleAspectFill	{
//	UIImage * image = [self croppedImage:[ALUtilities getSquareRect:CGRectMake(0, 0, self.size.width, self.size.height)]];
//	return image;
//}
//- (UIImage *)imageWithCropToSquare	{
- (UIImage *)imageWithCropToSquareScaleAspectFit	{
	
	CGFloat minSize = MIN(self.size.width, self.size.height);
	CGFloat maxSize = MAX(self.size.width, self.size.height);
	BOOL isLandscape = (maxSize == self.size.width);
	
	UIGraphicsBeginImageContext(CGSizeMake(maxSize, maxSize));
	CGContextRef ctx = UIGraphicsGetCurrentContext();
	CGContextTranslateCTM(ctx, 0, maxSize);
	CGContextScaleCTM(ctx, 1, -1);
	
	CGRect rect = CGRectMake(0, 0, maxSize, maxSize);
	CGFloat offset = (maxSize-minSize)*0.5;
	if (isLandscape)	{
		rect.origin.y = offset;
		rect.size.height -=offset*2;
	}else	{
		rect.origin.x = offset;
		rect.size.width -=offset*2;
	}
	//	NSLog(@"LOG:  rect:%@", NSStringFromCGRect(rect));
	
	//background color
	//	[[UIColor blackColor] set];
	//	CGContextFillRect(ctx, CGRectMake(0, 0, maxSize, maxSize));
	CGContextDrawImage(ctx, rect, self.CGImage);
	
	UIImage * cropedImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	return cropedImage;
}
+ (UIImage *)resizableImagebyName:(NSString *)imgName	{
	UIImage * img = [[UIImage imageNamed:imgName] resizableImageWithCapInsets:(UIEdgeInsetsMake(5, 5, 5, 5)) resizingMode:(UIImageResizingModeStretch)];
	return img;
}
@end

@implementation UIImageView (InitMethods)
+ (UIImageView *)imageViewWithPNGNamed:(NSString *)imageName	{
	NSString * correctImageName = imageName;
	if ([correctImageName hasSuffix:@".png"]) {
		correctImageName = [imageName substringToIndex:imageName.length-4];
	}
	return [UIImageView imageViewWithNamed:correctImageName AndType:@"png"];
}
+ (UIImageView *)imageViewWithJPGNamed:(NSString *)imageName	{
	NSString * correctImageName = imageName;
	if ([correctImageName hasSuffix:@".jpg"]) {
		correctImageName = [imageName substringToIndex:imageName.length-4];
	}
	return [UIImageView imageViewWithNamed:correctImageName AndType:@"jpg"];
}

+ (UIImageView *)imageViewWithNamed:(NSString *)imageName AndType:(NSString *)imageType	{
	
	NSString * path = [[NSBundle mainBundle] pathForResource:imageName ofType:imageType];
	UIImage * img = [UIImage imageWithContentsOfFile:path];
	
	UIImageView * imgView = [[UIImageView alloc] initWithImage:img];
	return imgView;
}
@end

@implementation UIColor (RGBMethods)
+ (UIColor *)colorWithHexRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha	{
	
	red /= 255.0;
	green /= 255.0;
	blue /= 255.0;
	
	return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}
@end

@implementation UITableView (reloadMethods)	//update:20120420
-(void)reloadDataWithRowAnimation:(UITableViewRowAnimation)rowAnimation	{
	
	NSString *osversion = [UIDevice currentDevice].systemVersion;
	if ([osversion floatValue] >=4.3) {
		[self reloadSections:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, [self numberOfSections])]
			withRowAnimation:rowAnimation
		 ];
	}else {
		//4.2及4.2以下 headerView上的UITextField裡的backgroundcolor或image 若用動畫,可能會有問題
		[self reloadData];
	}
}
@end


/*
 //---- setClickAction
 #import <objc/runtime.h>
 
 @implementation NSObject (BlockTargetAction)
 - (void)startBlock {
 (((void (^)(void)) self)());
 }
 - (id)copyWithOwner:(NSObject *)owner {
 // copy ourself to the heap
 self = [[self copy] autorelease];
 
 // this key is unique until self is deallocated,
 // so it should last as long as the owner does
 void *key = (void *) self;
 
 // automatically released when the owner object is deallocated
 objc_setAssociatedObject(owner, key, self, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
 return objc_getAssociatedObject(owner, key);
 }
 @end
 */
@implementation UIButton (BlockTargetAction)
- (void)setClickAction:(void (^)(id sender))action	{
	[self handleControlEvent:(UIControlEventTouchUpInside) withBlock:action];
}

- (void)removeClickAction	{
	[self removeHandlerForEvent:(UIControlEventTouchUpInside)];
}

-(void)clickAction	{	// 20130315
	[self performSelector:@selector(UIControlEventTouchUpInside)];
}

/*-(void)setClickAction:(void (^)(id sender))action	{
 
 [self removeClickAction];	//20120509
 
 [self addTarget:[action copyWithOwner:self]
 action:@selector(startBlock)
 forControlEvents:(UIControlEventTouchUpInside)
 ];
 }
 
 -(void)removeClickAction	{
 UIButton * bt = self;
 for (id target in [bt allTargets]) {
 if ([target isKindOfClass:NSClassFromString(@"__NSMallocBlock__")]) {
 [bt removeTarget:target action:NULL forControlEvents:(UIControlEventTouchUpInside)];
 
 //			void *key = (void *) target;
 void *key = (__bridge void *) target;
 
 objc_setAssociatedObject(bt, key, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
 }
 }
 }*/
@end
@implementation UIButton (ALRoundedButton)
+ (UIButton *)createRoundedButtonWithFrame:(CGRect)rect	{
	UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
	[button setFrame:rect];
	
	UIView * bgView = [[UIView alloc] initWithFrame:button.bounds];
//	[bgView setBackgroundColor:BackgroundPatternColor_gray_jean];
	UIView * blueView = [[UIView alloc] initWithFrame:bgView.bounds];
	[blueView setBackgroundColor:[UIColor colorWithRed:0.000 green:0.386 blue:0.991 alpha:1.000]];
	[blueView setAlpha:0.85];
	[bgView addSubview:blueView];
	[bgView.layer setCornerRadius:9];
	[bgView.layer setBorderWidth:1];
	[bgView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
	[bgView.layer setMasksToBounds:YES];
	UIImage * img = [UIImage captureImageFromView:bgView];
	
	[button setBackgroundImage:img forState:(UIControlStateHighlighted)];
//	[button setBackgroundColor:BackgroundPatternColor_gray_jean];
//	[button setTitleColor:ColorForUIRoundedButtonTitle forState:UIControlStateNormal];
	[button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
	[button.titleLabel setFont:[UIFont boldSystemFontOfSize:[UIFont systemFontSize]]];
	[button.layer setCornerRadius:9];
	[button.layer setBorderWidth:1];
	[button.layer setBorderColor:[UIColor lightGrayColor].CGColor];
	
	return button;
}
@end


@implementation NSMutableDictionary (formatVersion)
- (BOOL)writeToFile:(NSString *)path atomically:(BOOL)useAuxiliaryFile formatVersion:(NSString *)version	{
	
	[self setValue:version forKey:@"_formatVersion"];
	return [self writeToFile:path atomically:useAuxiliaryFile];
}
- (NSString *)getFormatVersion	{
	
	NSString * version = [self valueForKey:@"_formatVersion"];
	return version;
}
- (void)removeFormatVersion	{
	
	//	if ( [self isMemberOfClass:[NSMutableDictionary class]] ) {
	//
	//		[(NSMutableDictionary *)self removeObjectForKey:@"formatVersion"];
	//	}
	[self removeObjectForKey:@"_formatVersion"];
}
@end


@implementation NSArray (Unicode)
- (NSString*)description
{
    NSMutableString* __weak desc = [NSMutableString stringWithString:@"(\n"];
	indentLevelForLog++;
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [desc appendFormat:@"	%@,\n",[obj description]];
    }];
	indentLevelForLog--;
	
	for (int i=0; i<indentLevelForLog; i++)		[desc appendString:@"	"];
    [desc appendString:@")"];
    return desc;
}
@end

@implementation NSDictionary (Unicode)
- (NSString*)description
{
    NSMutableString* desc __weak = [NSMutableString stringWithString:@"{\n"];
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [desc appendFormat:@"%@ = %@,\n",key,[obj description]];
    }];
    [desc appendString:@"}"];
    return desc;
}
- (NSArray *)sortedKeys	{
	NSArray * keys = [[self allKeys] sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
		return [obj1 compare:obj2];
	}];
	return keys;
}
- (NSArray *)sortedKeysByDescending	{
	NSArray * keys = [[self allKeys] sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
		return [obj2 compare:obj1];
	}];
	return keys;
}
- (NSArray *)sortedKeysByAscending	{
	NSArray * keys = [[self allKeys] sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
		return [obj1 compare:obj2];
	}];
	return keys;
}
@end

@implementation NSString (verifyCheck)
- (NSString *)trim	{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

+ (NSString *)getTransformedNumberByAlphabet:(NSString *)alphabet	{
	NSDictionary * dic = [[NSDictionary alloc] initWithObjectsAndKeys:
						  @"10",@"A",
						  @"11",@"B",
						  @"12",@"C",
						  @"13",@"D",
						  @"14",@"E",
						  @"15",@"F",
						  @"16",@"G",
						  @"17",@"H",
						  
						  @"34",@"I",
						  
						  @"18",@"J",
						  @"19",@"K",
						  
						  @"21",@"M",
						  @"22",@"N",
						  @"35",@"O",
						  @"23",@"P",
						  @"24",@"Q",
						  
						  
						  @"27",@"T",
						  @"28",@"U",
						  @"29",@"V",
						  @"32",@"W",
						  @"30",@"X",
						  
						  @"33",@"Z",
						  
						  //已停發
						  @"20",@"L",
						  @"25",@"R",
						  @"26",@"S",
						  @"31",@"Y",
						  nil
						  ];
	
	NSString * number = [NSString stringWithString:[dic valueForKey:alphabet]];//		[dic release];
	
	return number;
}
- (BOOL)checkPID	{
	
	// 檢核身分證字號 或 統一証號
	BOOL isPID_OK = NO;
	NSString * strPID = [self uppercaseString];
	
	if ([strPID length] != 10) {
		isPID_OK = NO;
		
	}else if ([ALUtilities checkUnicharIsAlphabetic:[strPID characterAtIndex:0]]				//前一碼為英文，其餘為數字
			  && [ALUtilities checkStringIsAllNumeric: [strPID substringFromIndex:1] ] ) {
		
		//10碼中僅第一碼為字母者	可能為中華民國身分證統一編號,以身分證字號檢核規則進行檢核
		NSString * transformedNumber = [NSString getTransformedNumberByAlphabet:[strPID substringToIndex:1]];
		strPID = [transformedNumber stringByAppendingString:[strPID substringFromIndex:1]];
		int checkNumbers[11] = {1,9,8,7,6,5,4,3,2,1,1};
		
		int num = 0;
		for (int i = 0; i<11; i++) {
			num += [[strPID substringWithRange:NSMakeRange(i, 1)] intValue] * checkNumbers[i];
		}
		NSLog(@"LOG:  num: %i",num);
		if ( (num %10) == 0) {
			isPID_OK = YES;
		}
		
	} else if ( [ALUtilities checkUnicharIsAlphabetic:[strPID characterAtIndex:0]]			//前兩碼為英文，其餘為數字
			   && [ALUtilities checkUnicharIsAlphabetic:[strPID characterAtIndex:1]]
			   && [ALUtilities checkStringIsAllNumeric: [strPID substringFromIndex:2]] ) {
		//10碼中有字母、數字者		應為外籍人士之統一証號,以統一證號檢核規則進行檢核
		NSString * transformedNumber1 = [NSString getTransformedNumberByAlphabet:[strPID substringToIndex:1]];
		NSString * transformedNumber2 = [NSString getTransformedNumberByAlphabet:[strPID substringWithRange:NSMakeRange(1, 1)]];
		NSString * lastNumber = [strPID substringWithRange:NSMakeRange([strPID length]-1, 1)];
		if ([transformedNumber2 length]>=2) //取尾數
			transformedNumber2 = [transformedNumber2 substringWithRange:NSMakeRange([transformedNumber2 length]-1, 1)];
		
		strPID = [[transformedNumber1 stringByAppendingString:transformedNumber2] stringByAppendingString: [strPID substringWithRange:NSMakeRange(2, 7)] ];
		int checkNumbers[10] = {1,9,8,7,6,5,4,3,2,1};
		int num = 0;
		for (int i = 0; i<10; i++) {
			int tmp = [[strPID substringWithRange:NSMakeRange(i, 1)] intValue] * checkNumbers[i];
			tmp = tmp%10;	//只取個位數
			num += tmp;
		}
		NSLog(@"LOG:  num: %i",num);
		num = num%10;
		if (num !=0) {
			num = 10 -num;
		}
		
		if (num == [lastNumber intValue]) {
			isPID_OK = YES;
		}
		
	}// [END]  身分證 或 統一証號
	
	
	return isPID_OK;
}

#import <CommonCrypto/CommonDigest.h>
- (NSString*)stringFromSha256	{
	NSString * clear = self;
	const char *s=[clear cStringUsingEncoding:NSASCIIStringEncoding];
	NSData *keyData=[NSData dataWithBytes:s length:strlen(s)];
	
	uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
	CC_SHA256(keyData.bytes, keyData.length, digest);
	NSData *out=[NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
	NSString *hash=[out description];
	hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
	hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
	hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
	
	return hash;
}

@end


//#import "RuntimeReporter.h"
@implementation NSObject (descriptionMemberList)
//override//

//- (NSString *)descriptionMemberList	{
//	//	return [DescriptionBuilder reflectDescription:self];
//	return [DescriptionBuilder reflectDescriptionWithSuperClass:self style:(DescriptionStyleMultiLine)];
//}
/*
 - (NSString *)descriptionMemberList	{
 
 NSMutableString * iVarList = [NSMutableString string];
 for (NSString * iVarName in [RuntimeReporter iVarNamesForClass:[self class]]) {
 id iVarValue = nil;
 @try {
 iVarValue = [self valueForKey:iVarName];
 }@catch (NSException *exception) {	//c array
 iVarValue = @"未知";				//	 unsigned int ivarCount;			Ivar *ivars = class_copyIvarList([self class],&ivarCount);			iVarValue = object_getIvar(self, ivars[ivarCount--] );			NSLog(@"LOG:  exception:%@ \n,   value: %i", exception , iVarValue);
 }@finally {
 for (int i=0; i<indentLevelForLog; i++)		[iVarList appendString:@"	"];
 [iVarList appendFormat:@"└ %@ : %@\n", iVarName , [iVarValue description]];
 }
 }
 
 NSMutableString * description = [NSMutableString stringWithString:@"\n"];
 for (int i=0; i<indentLevelForLog; i++)		[description appendString:@"	"];
 [description appendFormat: @"<%@: %p> memberList:\n%@", NSStringFromClass([self class]),self , iVarList ];
 
 //	return [NSString stringWithFormat:@"\n<%@: %p> memberList:\n%@", NSStringFromClass([self class]),self , iVarList ];
 return description;
 }
 */

@end


/*@implementation MKMapView (zoomToFitMapAnnotations)

- (void)zoomToFitMapAnnotations	{
	[self zoomToFitMapAnnotations:self];
}

- (void)zoomToFitMapAnnotations:(MKMapView *)mapView {	// http://stackoverflow.com/a/7200744
    if ([mapView.annotations count] == 0) return;
	
    CLLocationCoordinate2D topLeftCoord;
    topLeftCoord.latitude = -90;
    topLeftCoord.longitude = 180;
	
    CLLocationCoordinate2D bottomRightCoord;
    bottomRightCoord.latitude = 90;
    bottomRightCoord.longitude = -180;
	
    for(id<MKAnnotation> annotation in mapView.annotations) {
        topLeftCoord.longitude = fmin(topLeftCoord.longitude, annotation.coordinate.longitude);
        topLeftCoord.latitude = fmax(topLeftCoord.latitude, annotation.coordinate.latitude);
        bottomRightCoord.longitude = fmax(bottomRightCoord.longitude, annotation.coordinate.longitude);
        bottomRightCoord.latitude = fmin(bottomRightCoord.latitude, annotation.coordinate.latitude);
    }
	
    MKCoordinateRegion region;
    region.center.latitude = topLeftCoord.latitude - (topLeftCoord.latitude - bottomRightCoord.latitude) * 0.5;
    region.center.longitude = topLeftCoord.longitude + (bottomRightCoord.longitude - topLeftCoord.longitude) * 0.5;
    region.span.latitudeDelta = fabs(topLeftCoord.latitude - bottomRightCoord.latitude) * 1.1;
	
    // Add a little extra space on the sides
    region.span.longitudeDelta = fabs(bottomRightCoord.longitude - topLeftCoord.longitude) * 1.1;
	
    region = [mapView regionThatFits:region];
	if (region.span.latitudeDelta >90.0 ) {
		region.span.latitudeDelta = 90.0;
	}else if (region.span.latitudeDelta < -90.0)	{
		region.span.latitudeDelta = -90.0;
	}
	if (region.span.longitudeDelta >180.0 ) {
		region.span.longitudeDelta = 180.0;
	}else if (region.span.longitudeDelta < -180.0)	{
		region.span.longitudeDelta = -180.0;
	}
	
    [mapView setRegion:region animated:YES];
}

- (void)moveToCoordinateWithAnimation:(CLLocationCoordinate2D)coor	{
	MKCoordinateSpan span = MKCoordinateSpanMake(0.005, 0.005);
	MKCoordinateRegion region = MKCoordinateRegionMake(coor, span);
	[self setRegion:region animated:YES];
}
@end*/



@implementation UILabel (alignTop)
//http://fstoke.me/blog/?p=2819
// adjust the height of a multi-line label to make it align vertical with top
- (void) alignLabelWithTop {
	UILabel * label = self;
	
	CGSize maxSize = CGSizeMake(label.frame.size.width, 999);
	label.adjustsFontSizeToFitWidth = NO;
	
	// get actual height
	CGSize actualSize = [label.text sizeWithFont:label.font constrainedToSize:maxSize lineBreakMode:label.lineBreakMode];
	CGRect rect = label.frame;
	rect.size.height = actualSize.height;
	label.frame = rect;
}
@end


@implementation NSDate (theSameDay)

//http://blog.sina.com.cn/s/blog_672af4e20100wbc7.html
- (BOOL)isSameDay:(NSDate*)date2
{
	NSDate * date1 = self;
	
    NSCalendar* calendar = [NSCalendar currentCalendar];
    
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    NSDateComponents* comp1 = [calendar components:unitFlags fromDate:date1];
    NSDateComponents* comp2 = [calendar components:unitFlags fromDate:date2];
    
    return [comp1 day]   == [comp2 day] &&
    [comp1 month] == [comp2 month] &&
    [comp1 year]  == [comp2 year];
}

@end


@implementation UIImagePickerController (ios6rotate)
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return UIInterfaceOrientationIsPortrait(interfaceOrientation);
	//	return YES;
}

- (NSUInteger)supportedInterfaceOrientations	{	//NS_AVAILABLE_IOS(6_0);
	//	return UIInterfaceOrientationMaskAll;
	return (UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskPortraitUpsideDown);
}
@end

/*@implementation MFMessageComposeViewController (ios6rotate)
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
	return YES;
}
- (NSUInteger)supportedInterfaceOrientations	{	//NS_AVAILABLE_IOS(6_0);
	return (UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskPortraitUpsideDown);
}
@end

@implementation ABPeoplePickerNavigationController (ios6rotate)
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
	return YES;
}
- (NSUInteger)supportedInterfaceOrientations	{	//NS_AVAILABLE_IOS(6_0);
	return (UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskPortraitUpsideDown);
}
@end
@implementation ABPersonViewController (ios6rotate)
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
	return YES;
}
- (NSUInteger)supportedInterfaceOrientations	{	//NS_AVAILABLE_IOS(6_0);
	return (UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskPortraitUpsideDown);
}
@end*/

@implementation UIActionSheet(ButtonState)
- (void)setButton:(NSInteger)buttonIndex toState:(BOOL)enabled {
    for (UIView* view in self.subviews)
    {
        if ([view isKindOfClass:[UIButton class]])
        {
            if (buttonIndex == 0) {
                if ([view respondsToSelector:@selector(setEnabled:)])
                {
                    UIButton* button = (UIButton*)view;
                    button.enabled = enabled;
                }
            }
            buttonIndex--;
        }
    }
}
@end