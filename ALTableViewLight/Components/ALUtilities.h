//
//  ALUtilities.h
//
//
//  Created by AllenLion on 12/9/18.
//  Copyright (c) 2012年 AllenLee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Define.h"

UIKIT_EXTERN NSString *NSStringFromInt(NSInteger num);
UIKIT_EXTERN NSString *NSStringFromFloat(CGFloat num);
UIKIT_EXTERN double km2mile(double km);

@interface ALUtilities : NSObject	// 20120918

//判斷iOS版本
+(BOOL)isIOS4;
+(BOOL)isIOS5;
+(BOOL)isIOS4Later;
+(BOOL)isIOS5Later;
+(BOOL)isIOS6Later;

//delay
+(void)runBlockAfterDelay:(NSTimeInterval)delay block:(void (^)(void))block;

//background task
+ (void)beginBackgroundTask;
+ (void)beginBackgroundTaskWithUnlimitedTime;
+ (void)endBackgroundTask;

//檢核用
+ (BOOL)checkUnicharIsNumeric:(unichar)c;
+ (BOOL)checkUnicharIsAlphabetic:(unichar)c;
+ (BOOL)checkStringIsAllNumeric:(NSString *)str;
+ (BOOL)checkStringIsAllAlphabetic:(NSString *)str;
+ (NSString *)KG2LB:(NSString *)kg;

+ (void)activityStartAnimating;
+ (void)activityStopAnimating;

+ (id)creatViewByName:(NSString *)className;
+ (id)creatViewControllerByStoryboardID:(NSString *)stroyboardID;
+ (id)creatViewControllerByStoryboardID:(NSString *)stroyboardID andStoryboardName:(NSString *)stroyboardName;

+ (NSString *)NSDateToStrDate:(NSDate *)date;
+ (NSString *)NSDateToStrTime:(NSDate *)date;
+ (NSString *)NSDateToStrDateAndTime:(NSDate *)date;
+ (NSDate *)NSStringToNSDate:(NSString *)strDate;
+ (NSDate *)NSStringToNSDateTime:(NSString *)strDate;
+ (CGRect)getSquareRect:(CGRect)rect;

extern NSString* CTSettingCopyMyPhoneNumber();	//CoreTelephony.framework
//+ (NSString *)MyPhoneNumber;
+ (BOOL)call:(NSString *)strNumber;
@end

@interface UIView (frameMethods)
-(void)moveToSuperviewsCenter;
-(void)moveToThisviewsCenter:(UIView *)thisView;
-(void)moveToNewOrigin:(CGPoint)newOrigin;
-(void)setFrameSameAsSuperView;
-(void)setFrameIntegral;

-(void)addSubviewAtTheSamePlaceTo:(UIView *)view;

-(UIViewController *)findNearestViewController;
-(UIView *)findNearestViewControllersView;
-(void)resignAllResponder;
- (id)findFirstResponder;

//+ (UIImage*)captureView:(UIView *)theView;
-(id)findNearestScrollView;
-(id)findNearestScrollViewStartFrom:(UIView *)view;

-(void)showPoint:(CGPoint)pt;
+ (void)setCAAnimationDuration:(NSTimeInterval)dura;
+ (NSTimeInterval)getCAAnimationDuration;
- (void)addCAAnimationFromTop;
- (void)addCAAnimationFromBottom;
- (void)addCAAnimationFromLeft;
- (void)addCAAnimationFromRight;
- (void)addCAAnimationBykCATransitionFrom:(NSString *)from;

- (void)drawBorder;

// 20120927 http://code4app.com/snippets/one/查询子视图/50164d0a6803fa4c15000000#s0
- (NSArray *)allSubviews;
- (NSArray *)allApplicationViews;
- (NSArray *)pathToView;
@end

@interface UIImage (ResizeMethods)
+ (UIImage *)captureImageFromView:(UIView *)theView;
+ (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize;
+ (UIImage *)imageWithContentsOfFileByPNGNamed:(NSString *)imgName;
+ (UIImage *)imageWithContentsOfFileByJPGNamed:(NSString *)imgName;
//- (UIImage *)imageWithCropToSquare;
- (UIImage *)imageWithCropToSquareScaleAspectFill;
//- (UIImage *)imageWithCropToSquareScaleAspectFit;	// 20130325
+ (UIImage *)resizableImagebyName:(NSString *)imgName;
@end

@interface UIImageView (InitMethods)
+ (UIImageView *)imageViewWithPNGNamed:(NSString *)imageName;
+ (UIImageView *)imageViewWithJPGNamed:(NSString *)imageName;
+ (UIImageView *)imageViewWithNamed:(NSString *)imageName AndType:(NSString *)imageType;
@end

@interface UIColor (RGBMethods)
+ (UIColor *)colorWithHexRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;
@end

@interface UITableView (reloadMethods)
-(void)reloadDataWithRowAnimation:(UITableViewRowAnimation)rowAnimation;
@end


//---- setClickAction
@interface UIButton (BlockTargetAction)
-(void)setClickAction:(void (^)(id sender))action;
-(void)removeClickAction;// 20121101
-(void)clickAction;
@end
@interface UIButton (ALRoundedButton)
+ (UIButton *)createRoundedButtonWithFrame:(CGRect)rect;
@end

@interface NSMutableDictionary (formatVersion)
- (BOOL)writeToFile:(NSString *)path atomically:(BOOL)useAuxiliaryFile formatVersion:(NSString *)version;
- (NSString *)getFormatVersion;
- (void)removeFormatVersion;
@end

@interface NSArray (Unicode)
- (NSString*)description;
@end

@interface NSDictionary (Unicode)
- (NSString*)description;
- (NSArray *)sortedKeys;
- (NSArray *)sortedKeysByDescending;
- (NSArray *)sortedKeysByAscending;
@end

@interface NSString (verifyCheck)

- (NSString *)trim;
- (BOOL)checkPID;
- (NSString*)stringFromSha256;
@end

@interface NSObject (descriptionMemberList)
//- (NSString *)descriptionMemberList;
@end

/*#import <MapKit/MapKit.h>
@interface MKMapView (zoomToFitMapAnnotations)

- (void)zoomToFitMapAnnotations;
- (void)zoomToFitMapAnnotations:(MKMapView *)mapView;	// http://stackoverflow.com/a/7200744
- (void)moveToCoordinateWithAnimation:(CLLocationCoordinate2D)coor;
@end*/

@interface UILabel (alignTop)
//http://fstoke.me/blog/?p=2819
// adjust the height of a multi-line label to make it align vertical with top
- (void) alignLabelWithTop;
@end

@interface NSDate (theSameDay)
- (BOOL)isSameDay:(NSDate*)date2;
@end

@interface UIImagePickerController (ios6rotate)
@end

/*#import <MessageUI/MessageUI.h>
@interface MFMessageComposeViewController (ios6rotate)
@end

#import <AddressBookUI/AddressBookUI.h>
@interface ABPeoplePickerNavigationController (ios6rotate)
@end
@interface ABPersonViewController (ios6rotate)
@end*/

@interface UIActionSheet(ButtonState)	//http://stackoverflow.com/a/9380142
- (void)setButton:(NSInteger)buttonIndex toState:(BOOL)enbaled;
@end