//
//  ALView.h
//  
//
//  Created by 李 亞霖 on 2011/11/6.
//   
//

#import <UIKit/UIKit.h>

@interface ALView : UIView

-(void)myInit;

@end



#pragma mark - ALButton
typedef struct ALBorderSet {
    CGFloat top, left, bottom, right;
	UIOffset offset;
	CGColorRef borderColor;
} ALBorderSet;

UIKIT_STATIC_INLINE ALBorderSet ALBorderSetMake(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right , UIOffset offset , UIColor * color) {
    ALBorderSet borderSet = {top, left, bottom, right , offset, color.CGColor};
    return borderSet;
}
UIKIT_STATIC_INLINE ALBorderSet ALBorderSetEmpty() {
    ALBorderSet borderSet = ALBorderSetMake(NSNotFound, NSNotFound, NSNotFound, NSNotFound, UIOffsetZero, nil);
    return borderSet;
}
UIKIT_STATIC_INLINE BOOL ALBorderSetIsEmpty(ALBorderSet set) {
	BOOL isEmpty = NO;
	if (set.top == NSNotFound && set.bottom == NSNotFound && set.left == NSNotFound && set.right == NSNotFound && UIOffsetEqualToOffset(set.offset, UIOffsetZero) ) {
		isEmpty = YES;
	}
    return isEmpty;
}

@interface ALButton : UIButton

+ (id)buttonWithImage:(UIImage *)buttonImage;

-(void)myInit;
- (void)addBorderSet:(ALBorderSet)borderset;
- (void)addAnotherBorderSet:(ALBorderSet)borderset;
@end

@interface UIButton (BackgroundStyle)

- (void)setBackgroundStyleDefault;
- (void)setBlackBackgroundAndRedFont;
- (void)setBackgroundStyleByName:(NSString *)bgImgName;

@end


