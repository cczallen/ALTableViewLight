//
//  ALView.m
//  
//
//  Created by 李 亞霖 on 2011/11/6.
//   
//

#import "ALView.h"
#import "Define.h"
#import <QuartzCore/QuartzCore.h>

@implementation ALView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
		[self myInit];
    }
    return self;
}

-(void)awakeFromNib 
{
	[super awakeFromNib];
	// Initialization code
	[self myInit];
}

-(void)myInit	{
	
	// please override & call super first
}


#pragma mark - 


#pragma mark - 

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(void)dealloc	{

//	NSLog(@"LOG:  dealloc: View[%p] %@", self , NSStringFromClass([self class]));
//	[super dealloc];
}

@end



#pragma mark - ALButton

@interface ALButton ()	{
	ALBorderSet m_borderSets[2];
}
- (void)drawBorderSet:(ALBorderSet)borderset withCGContext:(CGContextRef)ctx Rect:(CGRect)rect;
@end

@implementation ALButton


#pragma mark - Init
+ (id)buttonWithImage:(UIImage *)buttonImage	{
	id bt = [self buttonWithType:(UIButtonTypeCustom)];
	[bt setImage:buttonImage forState:(UIControlStateNormal)];
	[bt setFrame:CGRectMake(0, 0, buttonImage.size.width, buttonImage.size.height)];
	return bt;
}

- (id)initWithFrame:(CGRect)frame	{
    self = [super initWithFrame:frame];
    if (self) {
		[self myInit];
    }    return self;
}
-(void)awakeFromNib {
	[super awakeFromNib];
	[self myInit];
}
-(void)myInit	{
	int len=sizeof(m_borderSets)/sizeof(ALBorderSet);
	for (int i=0; i<len; ++i) {
		//init ALBorderSetEmpty
		m_borderSets[i] = ALBorderSetEmpty();
	}
}

- (void)dealloc	{
//	[self removeClickAction];		會導致ViewController 的NavigationItem 的BarButtonItem裡的ALButton 出問題		2012-10-19 12:28:41.677 BabyDiary[12077:c07] *** -[BabyItemManagerViewController release]: message sent to deallocated instance 0x9d474a0
}

#pragma mark - 
- (void)addBorderSet:(ALBorderSet)borderset	{
	
	m_borderSets[0] = borderset;
	[self setNeedsDisplay];
}
- (void)addAnotherBorderSet:(ALBorderSet)borderset	{
	
	m_borderSets[1] = borderset;
	[self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect	{
	
	CGContextRef ctx = UIGraphicsGetCurrentContext();	
	CGContextSaveGState(ctx);

	int len=sizeof(m_borderSets)/sizeof(ALBorderSet);
	for (int i=0; i<len; ++i) {
		if (!ALBorderSetIsEmpty(m_borderSets[i])) {
			[self drawBorderSet:m_borderSets[i] withCGContext:ctx Rect:rect];
		}
	}
	
	CGContextRestoreGState(ctx);	
}

- (void)drawBorderSet:(ALBorderSet)borderset withCGContext:(CGContextRef)ctx Rect:(CGRect)rect	{
	
	CGFloat cgfHeight = CGRectGetHeight(rect) - 0;
	CGFloat cgfWidth  = CGRectGetWidth(rect) - 0;
	
	CGContextSetStrokeColorWithColor(ctx, borderset.borderColor);
	
	//top
	CGContextBeginPath(ctx);	{
		CGContextSetLineWidth(ctx, borderset.top);
		CGContextMoveToPoint(ctx, 0 +borderset.offset.horizontal, 0 +borderset.offset.vertical);
		CGContextAddLineToPoint(ctx, cgfWidth +borderset.offset.horizontal , 0+borderset.offset.vertical);
		CGContextClosePath(ctx);	
	}CGContextStrokePath(ctx);
	
	//right
	CGContextBeginPath(ctx);	{
		CGContextSetLineWidth(ctx, borderset.right);
		CGContextMoveToPoint(ctx, cgfWidth +borderset.offset.horizontal , 0+borderset.offset.vertical);
		CGContextAddLineToPoint(ctx, cgfWidth +borderset.offset.horizontal, cgfHeight +borderset.offset.vertical);
		CGContextClosePath(ctx);	
	}CGContextStrokePath(ctx);
	
	//bottom
	CGContextBeginPath(ctx);	{
		CGContextSetLineWidth(ctx, borderset.bottom);
		CGContextMoveToPoint(ctx, cgfWidth +borderset.offset.horizontal, cgfHeight +borderset.offset.vertical);
		CGContextAddLineToPoint(ctx, 0 +borderset.offset.horizontal, cgfHeight +borderset.offset.vertical);
		CGContextClosePath(ctx);	
	}CGContextStrokePath(ctx);
	
	//left
	CGContextBeginPath(ctx);	{
		CGContextSetLineWidth(ctx, borderset.left);
		CGContextMoveToPoint(ctx, 0 +borderset.offset.horizontal, cgfHeight +borderset.offset.vertical);
		CGContextAddLineToPoint(ctx, 0 +borderset.offset.horizontal, 0 +borderset.offset.vertical);	
		CGContextClosePath(ctx);	
	}CGContextStrokePath(ctx);
	
}
@end


@implementation UIButton (BackgroundStyle)

- (void)setBackgroundStyleDefault	{
	NSString * bgImgName = @"blackButton";
	[self setBackgroundStyleByName:bgImgName];
}
- (void)setBlackBackgroundAndRedFont	{
	[self setBackgroundStyleDefault];
	[self setTitleColor:[UIColor colorWithRed:0.988 green:0.323 blue:0.347 alpha:1.000] forState:(UIControlStateNormal)];
}

- (void)setBackgroundStyleByName:(NSString *)bgImgName	{
//	NSString * bgImgName = @"blackButton";
	NSString * bgImgNameHighLighted = [bgImgName stringByAppendingString:@"Highlight"];//@"blackButtonHighlight";
	
	UIImage * img;
	//BackgroundImage
	img = [UIImage resizableImagebyName:bgImgName];
	[self setBackgroundImage:img forState:(UIControlStateNormal)];

	//BackgroundImage highlighted
	img = [UIImage resizableImagebyName:bgImgNameHighLighted];
	[self setBackgroundImage:img forState:(UIControlStateHighlighted)];
	
	[self setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
	[self.titleLabel.layer setShadowColor:[UIColor lightGrayColor].CGColor];
	[self.titleLabel.layer setShadowOffset:CGSizeMake(0, 0)];
	[self.titleLabel.layer setShadowOpacity:0.2];
}

@end

