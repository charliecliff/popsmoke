//
//  HROPopupController.m
//  HROPopupController
//

#import "HROPopupController.h"

#define HRO_SYSTEM_VERSION_LESS_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define HRO_IS_IPAD   (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

static inline UIViewAnimationOptions UIViewAnimationCurveToAnimationOptions(UIViewAnimationCurve curve)
{
    return curve << 16;
}

@interface HROPopupController () <UIGestureRecognizerDelegate>

@property (nonatomic, strong, readwrite) UIView *popupView;
@property (nonatomic, strong) UIWindow *applicationWindow;
@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) UITapGestureRecognizer *backgroundTapRecognizer;
@property (nonatomic, strong) NSArray <UIView *> *views;
@property (nonatomic) BOOL dismissAnimated;

@end

@implementation HROPopupController


- (instancetype)initWithContents:(NSArray <UIView *> *)contents {
    self = [super init];
    if (self) {
        
        self.views = contents;
        
        self.popupView = [[UIView alloc] initWithFrame:CGRectZero];
        self.popupView.backgroundColor = [UIColor whiteColor];
        self.popupView.clipsToBounds = YES;
        
        self.maskView = [[UIView alloc] initWithFrame:self.applicationWindow.bounds];
        self.maskView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.7];
        self.backgroundTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleBackgroundTapGesture:)];
        self.backgroundTapRecognizer.delegate = self;
        [self.maskView addGestureRecognizer:self.backgroundTapRecognizer];
        [self.maskView addSubview:self.popupView];
        
        self.theme = [HROPopupTheme defaultTheme];

        [self addPopupContents];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
        
        [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(orientationWillChange)
                                                     name:UIApplicationWillChangeStatusBarOrientationNotification
                                                   object:nil];
		[[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(orientationChanged)
                                                     name:UIApplicationDidChangeStatusBarOrientationNotification
                                                   object:nil];
		[[NSNotificationCenter defaultCenter] addObserver:self
												 selector:@selector(dismissPopupController)
													 name:@"HRO_DISMISS_POPUP"
												   object:nil];
    }
    return self;
}

- (instancetype)init {
    self = [self initWithContents:@[]];
    return self;
}

- (void)dealloc {
    [[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIApplicationWillChangeStatusBarOrientationNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillHideNotification object:nil];
	[[NSNotificationCenter defaultCenter]removeObserver:self name:@"HRO_DISMISS_POPUP" object:nil];
}

- (void)orientationWillChange {
    
    [UIView animateWithDuration:self.theme.animationDuration animations:^{
        self.maskView.frame = self.applicationWindow.bounds;
        self.popupView.center = [self endingPoint];
    }];
}

- (void)orientationChanged {
    
    UIInterfaceOrientation statusBarOrientation = [UIApplication sharedApplication].statusBarOrientation;
    CGFloat angle = HRO_UIInterfaceOrientationAngleOfOrientation(statusBarOrientation);
    CGAffineTransform transform = CGAffineTransformMakeRotation(angle);
    
    [UIView animateWithDuration:self.theme.animationDuration animations:^{
        self.maskView.frame = self.applicationWindow.bounds;
        self.popupView.center = [self endingPoint];
        if (HRO_SYSTEM_VERSION_LESS_THAN(@"8.0")) {
            self.popupView.transform = transform;
        }
    }];
}

CGFloat HRO_UIInterfaceOrientationAngleOfOrientation(UIInterfaceOrientation orientation)
{
    CGFloat angle;
    
    switch (orientation)
    {
        case UIInterfaceOrientationPortraitUpsideDown:
            angle = M_PI;
            break;
        case UIInterfaceOrientationLandscapeLeft:
            angle = -M_PI_2;
            break;
        case UIInterfaceOrientationLandscapeRight:
            angle = M_PI_2;
            break;
        default:
            angle = 0.0;
            break;
    }
    
    return angle;
}


#pragma mark - Theming

- (void)applyTheme {
    if (self.theme.popupStyle == HROPopupStyleFullscreen) {
        self.theme.presentationStyle = HROPopupPresentationStyleFadeIn;
    }
    if (self.theme.popupStyle == HROPopupStyleActionSheet) {
        self.theme.presentationStyle = HROPopupPresentationStyleSlideInFromBottom;
    }
    self.popupView.layer.cornerRadius = self.theme.popupStyle == HROPopupStyleCentered?self.theme.cornerRadius:0;
    self.popupView.backgroundColor = self.theme.backgroundColor;
    UIColor *maskBackgroundColor;
    if (self.theme.popupStyle == HROPopupStyleFullscreen) {
        maskBackgroundColor = self.popupView.backgroundColor;
    }
    else {
		switch (self.theme.maskType) {
			case HROPopupMaskTypeClear:
				maskBackgroundColor = [UIColor clearColor];
				break;
			case HROPopupMaskTypeDimmed:
				maskBackgroundColor = [UIColor colorWithWhite:0.0 alpha:0.7];
				break;
			case HROPopupMaskTypeWhite:
				maskBackgroundColor = [UIColor colorWithWhite:1.0 alpha:1.0];
				break;
			default:
				maskBackgroundColor = [UIColor clearColor];
				break;
		}
    }
	self.maskView.backgroundColor = maskBackgroundColor;
}

#pragma mark - Popup Building

- (void)addPopupContents {
    for (UIView *view in self.views)
    {
        [self.popupView addSubview:view];
    }
}

- (CGSize)calculateContentSizeThatFits:(CGSize)size andUpdateLayout:(BOOL)update
{
    UIEdgeInsets inset = self.theme.popupContentInsets;
    size.width -= (inset.left + inset.right);
    size.height -= (inset.top + inset.bottom);
    
    CGSize result = CGSizeMake(0, inset.top);
    for (UIView *view in self.popupView.subviews)
    {
        view.autoresizingMask = UIViewAutoresizingNone;
        if (!view.hidden)
        {
            CGSize _size = view.frame.size;
            if (CGSizeEqualToSize(_size, CGSizeZero))
            {
                _size = [view sizeThatFits:size];
                _size.width = size.width;
                if (update) view.frame = CGRectMake(inset.left, result.height, _size.width, _size.height);
            }
            else {
                if (update) {
                    view.frame = CGRectMake(0, result.height, _size.width, _size.height);
                }
            }
            result.height += _size.height + self.theme.contentVerticalPadding;
            result.width = MAX(result.width, _size.width);
        }
    }
    
    result.height -= self.theme.contentVerticalPadding;
    result.width += inset.left + inset.right;
    result.height = MIN(INFINITY, MAX(0.0f, result.height + inset.bottom));
    if (update) {
        for (UIView *view in self.popupView.subviews) {
            view.frame = CGRectMake((result.width - view.frame.size.width) * 0.5, view.frame.origin.y, view.frame.size.width, view.frame.size.height);
        }
        self.popupView.frame = CGRectMake(0, 0, result.width, result.height);
    }
    return result;
}

- (CGSize)sizeThatFits:(CGSize)size
{
    return [self calculateContentSizeThatFits:size andUpdateLayout:NO];
}

#pragma mark - Keyboard 

- (void)keyboardWillShow:(NSNotification*)notification
{
    if (self.theme.movesAboveKeyboard) {
        CGRect frame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
        frame = [self.popupView convertRect:frame fromView:nil];
        NSTimeInterval duration = [(notification.userInfo)[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
        UIViewAnimationCurve curve = [(notification.userInfo)[UIKeyboardAnimationCurveUserInfoKey] integerValue];
        
        [self keyboardWithEndFrame:frame willShowAfterDuration:duration withOptions:UIViewAnimationCurveToAnimationOptions(curve)];
    }
}

- (void)keyboardWithEndFrame:(CGRect)keyboardFrame willShowAfterDuration:(NSTimeInterval)duration withOptions:(UIViewAnimationOptions)options
{
    CGRect popupViewIntersection = CGRectIntersection(self.popupView.frame, keyboardFrame);
    
    if (popupViewIntersection.size.height > 0) {
        CGRect maskViewIntersection = CGRectIntersection(self.maskView.frame, keyboardFrame);
        
        [UIView animateWithDuration:duration delay:0.0f options:options animations:^{
            self.popupView.center = CGPointMake(self.popupView.center.x, (CGRectGetHeight(self.maskView.frame) - maskViewIntersection.size.height) / 2);
        } completion:nil];
    }
}

- (void)keyboardWillHide:(NSNotification*)notification
{
    if (self.theme.movesAboveKeyboard) {
        CGRect frame = [notification.userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
        frame = [self.popupView convertRect:frame fromView:nil];
        NSTimeInterval duration = [(notification.userInfo)[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
        UIViewAnimationCurve curve = [(notification.userInfo)[UIKeyboardAnimationCurveUserInfoKey] integerValue];
        
        [self keyboardWithStartFrame:frame willHideAfterDuration:duration withOptions:UIViewAnimationCurveToAnimationOptions(curve)];
    }
}

- (void)keyboardWithStartFrame:(CGRect)keyboardFrame willHideAfterDuration:(NSTimeInterval)duration withOptions:(UIViewAnimationOptions)options
{
    [UIView animateWithDuration:duration delay:0.0f options:options animations:^{
        self.popupView.center = [self endingPoint];
    } completion:nil];
}

#pragma mark - Presentation

- (void)presentPopupControllerAnimated:(BOOL)flag {
    
    if ([self.delegate respondsToSelector:@selector(popupControllerWillPresent:)]) {
        [self.delegate popupControllerWillPresent:self];
    }
    
    // Keep a record of if the popup was presented with animation
    self.dismissAnimated = flag;
    
    [self applyTheme];
    [self calculateContentSizeThatFits:CGSizeMake([self popupWidth], self.maskView.bounds.size.height) andUpdateLayout:YES];
	self.popupView.center = [self originPoint];
    [self.applicationWindow addSubview:self.maskView];
	
	self.maskView.alpha = 0.0;
	
	dispatch_async(dispatch_get_main_queue(), ^{
		[UIView animateWithDuration:flag?self.theme.animationDuration:0.0 animations:^{
			self.maskView.alpha = 1.0;
			self.popupView.center = [self endingPoint];
		} completion:^(BOOL finished) {
			self.popupView.userInteractionEnabled = YES;
			if ([self.delegate respondsToSelector:@selector(popupControllerDidPresent:)]) {
				[self.delegate popupControllerDidPresent:self];
			}
		}];
	});
}

- (void)dismissPopupController {
	[self dismissPopupControllerAnimated:self.dismissAnimated];
}

- (void)dismissPopupControllerAnimated:(BOOL)flag {
	//TODO: All these "self" referneces in the block should cause a memory leak, so fix them
    if ([self.delegate respondsToSelector:@selector(popupControllerWillDismiss:)]) {
        [self.delegate popupControllerWillDismiss:self];
    }
	dispatch_async(dispatch_get_main_queue(), ^{
		[UIView animateWithDuration:flag?self.theme.animationDuration:0.0 animations:^{
			self.maskView.alpha = 0.0;
			self.popupView.center = [self dismissedPoint];;
		} completion:^(BOOL finished) {
			[self.maskView removeFromSuperview];
			if ([self.delegate respondsToSelector:@selector(popupControllerDidDismiss:)]) {
				[self.delegate popupControllerDidDismiss:self];
			}
		}];
	});
}

- (CGPoint)originPoint {
    CGPoint origin;
    switch (self.theme.presentationStyle) {
        case HROPopupPresentationStyleFadeIn:
            origin = self.maskView.center;
            break;
        case HROPopupPresentationStyleSlideInFromBottom:
            origin = CGPointMake(self.maskView.center.x, self.maskView.bounds.size.height + self.popupView.bounds.size.height);
            break;
        case HROPopupPresentationStyleSlideInFromLeft:
            origin = CGPointMake(-self.popupView.bounds.size.width, self.maskView.center.y);
            break;
        case HROPopupPresentationStyleSlideInFromRight:
            origin = CGPointMake(self.maskView.bounds.size.width+self.popupView.bounds.size.width, self.maskView.center.y);
            break;
        case HROPopupPresentationStyleSlideInFromTop:
            origin = CGPointMake(self.maskView.center.x, -self.popupView.bounds.size.height);
            break;
        default:
            origin = self.maskView.center;
            break;
    }
    return origin;
}

- (CGPoint)endingPoint {
    CGPoint center;
    if (self.theme.popupStyle == HROPopupStyleActionSheet) {
        center = CGPointMake(self.maskView.center.x, self.maskView.bounds.size.height-(self.popupView.bounds.size.height * 0.5));
    }
    else {
        center = self.maskView.center;
    }
    return center;
}

- (CGPoint)dismissedPoint {
    CGPoint dismissed;
    switch (self.theme.presentationStyle) {
        case HROPopupPresentationStyleFadeIn:
            dismissed = self.maskView.center;
            break;
        case HROPopupPresentationStyleSlideInFromBottom:
            dismissed = self.theme.dismissesOppositeDirection?CGPointMake(self.maskView.center.x, -self.popupView.bounds.size.height):CGPointMake(self.maskView.center.x, self.maskView.bounds.size.height + self.popupView.bounds.size.height);
            if (self.theme.popupStyle == HROPopupStyleActionSheet) {
                dismissed = CGPointMake(self.maskView.center.x, self.maskView.bounds.size.height + self.popupView.bounds.size.height);
            }
            break;
        case HROPopupPresentationStyleSlideInFromLeft:
            dismissed = self.theme.dismissesOppositeDirection?CGPointMake(self.maskView.bounds.size.width+self.popupView.bounds.size.width, self.maskView.center.y):CGPointMake(-self.popupView.bounds.size.width, self.maskView.center.y);
            break;
        case HROPopupPresentationStyleSlideInFromRight:
            dismissed = self.theme.dismissesOppositeDirection?CGPointMake(-self.popupView.bounds.size.width, self.maskView.center.y):CGPointMake(self.maskView.bounds.size.width+self.popupView.bounds.size.width, self.maskView.center.y);
            break;
        case HROPopupPresentationStyleSlideInFromTop:
            dismissed = self.theme.dismissesOppositeDirection?CGPointMake(self.maskView.center.x, self.maskView.bounds.size.height + self.popupView.bounds.size.height):CGPointMake(self.maskView.center.x, -self.popupView.bounds.size.height);
            break;
        default:
            dismissed = self.maskView.center;
            break;
    }
    return dismissed;
}

- (CGFloat)popupWidth {
    CGFloat width = self.theme.maxPopupWidth;
    if ((self.theme.popupStyle == HROPopupStyleActionSheet && !HRO_IS_IPAD ) || self.theme.popupStyle == HROPopupStyleFullscreen) {
        width = self.maskView.bounds.size.width;
    }
    return width;
}

#pragma mark - UIGestureRecognizerDelegate 

- (void)handleBackgroundTapGesture:(id)sender {
    if (self.theme.shouldDismissOnBackgroundTouch) {
        [self.popupView endEditing:YES];
        [self dismissPopupControllerAnimated:self.dismissAnimated];
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([touch.view isDescendantOfView:self.popupView])
        return NO;
    return YES;
}

- (UIWindow *)applicationWindow {
	return [[[UIApplication sharedApplication] delegate] window];
}

@end

#pragma mark - HROPopupButton Methods

@implementation HROPopupButton

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addTarget:self action:@selector(buttonTouched) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)buttonTouched {
    if (self.selectionHandler) {
        self.selectionHandler(self);
    }
}

@end

#pragma mark - HROPopupTheme Methods

@implementation HROPopupTheme

+ (HROPopupTheme *)defaultTheme {
    HROPopupTheme *defaultTheme = [[HROPopupTheme alloc] init];
    defaultTheme.backgroundColor = [UIColor whiteColor];
    defaultTheme.cornerRadius = 4.0f;
    defaultTheme.popupContentInsets = UIEdgeInsetsMake(16.0f, 16.0f, 16.0f, 16.0f);
    defaultTheme.popupStyle = HROPopupStyleCentered;
    defaultTheme.presentationStyle = HROPopupPresentationStyleSlideInFromBottom;
    defaultTheme.dismissesOppositeDirection = NO;
    defaultTheme.maskType = HROPopupMaskTypeDimmed;
    defaultTheme.shouldDismissOnBackgroundTouch = YES;
    defaultTheme.movesAboveKeyboard = YES;
    defaultTheme.contentVerticalPadding = 16.0f;
    defaultTheme.maxPopupWidth = 300.0f;
    defaultTheme.animationDuration = 0.3f;
    return defaultTheme;
}

@end
