//
//  Define.h
//  
//
//  Created by Allen Lee on 2011/10/11.
//   
//

// release時去掉NSLog的方法
#ifndef __OPTIMIZE__
//#    define NSLog(...) NSLog(__VA_ARGS__)
//#	 define NSLog(FORMAT, ...) fprintf(stderr,"%s\n", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#	 define NSLog(fmt, ...) fprintf(stderr,"────────────────────────────────────────────────────────────────────────────\n%s\n", [[NSString stringWithFormat:(@"%s [Line %d] [%p]\n " fmt), __PRETTY_FUNCTION__, __LINE__, self, ##__VA_ARGS__] UTF8String]);
#else
#    define NSLog(...) {}
#endif


#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import "ALUtilities.h"

//#import "UIActionSheet+MKBlockAdditions.h"
//#import "UIAlertView+MKBlockAdditions.h"
#import "UIViewAdditions.h"
//#import "ActionSheetPicker.h"
//#import "NSObject+AutoCoding.h"
//#import "GCDSingleton.h"

//#import "SVProgressHUD.h"
//#import "UIImage+Tools.h"
//#import "UIView+Layout.h"
//#import "UIColor+Tools.h"
//#import "UIImage+Resize.h"
//#import "SYSlideSwitch.h"


#import "ALView.h"
#import "ALViewController.h"
#import "ALTabBarController.h"
//#import "ALTableViewController.h"
@class ALTableViewController;
#import "ALNavigationController.h"
#import "ALBarButtonItem.h"
//#import "AsyncImageView.h"
#import "BlockUI.h"
#import "ALBadgeView.h"
#import "ALTextField.h"


#define FACEBOOK_API_KEY @""

#define GetRandomFromTo(min,max) (arc4random()%(max-min) +min)
#define GetRandomColor [UIColor colorWithRed:(double)arc4random()/0x100000000 green:(double)arc4random()/0x100000000 blue:(double)arc4random()/0x100000000 alpha:1]
#define GetRandomColorWithAlpha(x) ([UIColor colorWithRed:(double)arc4random()/0x100000000 green:(double)arc4random()/0x100000000 blue:(double)arc4random()/0x100000000 alpha:x])

#define SafeStr(x) ((x==nil)?@"":x)
#define AppSupportDir	[NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define DocDir			[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

#define ACTIVITYVIEWKEY 888888


//---- Time

//----


//---- URL

//----


//---- COLOR

/*#define BackgroundPatternImage_black_twill [UIImage imageWithContentsOfFileByPNGNamed:@"black_twill"]
#define BackgroundPatternColor_black_twill [UIColor colorWithPatternImage: BackgroundPatternImage_black_twill ]

#define BackgroundPatternImage_subtle_carbon [UIImage imageWithContentsOfFileByPNGNamed:@"subtle_carbon"]
#define BackgroundPatternColor_subtle_carbon [UIColor colorWithPatternImage: BackgroundPatternImage_subtle_carbon ]

#define BackgroundPatternImage_noisygrid [UIImage imageWithContentsOfFileByPNGNamed:@"noisy_grid"]
#define BackgroundPatternColor_noisygrid [UIColor colorWithPatternImage: BackgroundPatternImage_noisygrid ]

#define BackgroundPatternImage_egg_shell [UIImage imageWithContentsOfFileByPNGNamed:@"egg_shell"]
#define BackgroundPatternColor_egg_shell [UIColor colorWithPatternImage: BackgroundPatternImage_egg_shell ]

#define BackgroundPatternImage_gray_jean [UIImage imageWithContentsOfFileByPNGNamed:@"gray_jean"]
#define BackgroundPatternColor_gray_jean [UIColor colorWithPatternImage: BackgroundPatternImage_gray_jean ]
*/

//----

#define CornerRadiusForView 4.5

// 判斷是否iPad 或 iPhone
#define isIPadUI (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define isIPadDevice ([[[UIDevice currentDevice] model] isEqualToString:@"iPad"])
#define isIPhoneUI (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define isIPhoneDevice ([[[UIDevice currentDevice] model] isEqualToString:@"iPhone"])
#define is4InchScreen ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

// 判斷是否模擬器
#define isSimulator (NSNotFound != [[[UIDevice currentDevice] model] rangeOfString:@"Simulator"].location )
//
#define IsIOS5Later	([ALUtilities isIOS5Later])
#define IsIOS6Later	([ALUtilities isIOS6Later])
#define degreesToRadians(x) ((x) * (M_PI / 180.0))
#define IsLandscape UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarFrame])
#define CanOpenGoogleMapsApp	[[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"comgooglemaps://"]]	//ios6

#define SaveLanguageSettings(langName) \
		[[NSUserDefaults standardUserDefaults] setValue:langName forKey:@"TransTableName"],[[NSUserDefaults standardUserDefaults] synchronize]
#define GetLanguageSettings \
	[[NSUserDefaults standardUserDefaults] valueForKey:@"TransTableName"]


//#define GetString(str) \
		NSLocalizedStringFromTable(str,	[[NSUserDefaults standardUserDefaults] valueForKey:@"TransTableName"] , nil)

#define GetString(str) NSLocalizedString(str, @"")
