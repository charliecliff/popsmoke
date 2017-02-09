//
//  HROProgressPopup.m
//  CNPPopupControllerExampleSwift
//
//  Created by Charles Cliff on 12/22/16.
//  Copyright © 2016 Carson Perrotti. All rights reserved.
//

#import "HROProgressPopupController.h"

@interface HROProgressPopupController ()

@property (nonatomic, strong) UIImageView *spinnerImageView;

@end

@implementation HROProgressPopupController

- (nonnull instancetype)initWithIconImage:(nonnull UIImage *)image {
	
	UIImageView *iconImageView = [[UIImageView alloc] initWithImage:image];
	self = [super initWithContents:@[iconImageView]];
	if (self != nil) {
		self.theme = [HROPopupTheme defaultTheme];
		self.theme.popupStyle = HROPopupStyleCentered;
		self.theme.presentationStyle = HROPopupPresentationStyleFadeIn;
		self.theme.backgroundColor = [UIColor clearColor];
		self.theme.shouldDismissOnBackgroundTouch = NO;
	}
	return self;
}

#pragma mark - Over Ride

- (void)presentPopupControllerAnimated:(BOOL)flag {
	[super presentPopupControllerAnimated:flag];
	[self addSpinnerView];
	[self startRotatingSpinner];
}

- (void)dismissPopupControllerAnimated:(BOOL)flag {
	[super dismissPopupControllerAnimated:flag];
	[self stopRotatingSpinner];
}

#pragma mark - Spinner

- (void)addSpinnerView {
	UIImage *spinnerImage = [UIImage imageNamed:@"loading_spinner"];
	self.spinnerImageView = [[UIImageView alloc] initWithImage:spinnerImage];
	[self.spinnerImageView setFrame:CGRectMake(0, 0, self.popupView.frame.size.width, self.popupView.frame.size.height)];
	[self.popupView addSubview:self.spinnerImageView];
}

- (void)startRotatingSpinner {
	dispatch_async(dispatch_get_main_queue(), ^{
		CABasicAnimation *spinAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
		spinAnimation.duration = 3.0;
		spinAnimation.repeatCount = INFINITY;
		spinAnimation.fromValue = [NSNumber numberWithFloat:0.0];
		spinAnimation.toValue = [NSNumber numberWithFloat:(M_PI * 2.0)];
		[self.spinnerImageView.layer addAnimation:spinAnimation forKey:@"spin"];
	});
}

- (void)stopRotatingSpinner {
	dispatch_async(dispatch_get_main_queue(), ^{
		if ([self.spinnerImageView.layer animationForKey:@"spin"]  != nil) {
			[self.spinnerImageView.layer removeAnimationForKey:@"spin"];
		}
	});
}

@end
