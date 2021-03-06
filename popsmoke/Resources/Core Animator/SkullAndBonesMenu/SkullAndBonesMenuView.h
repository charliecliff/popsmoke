//
// SkullAndBonesMenuView.h
// Generated by Core Animator version 1.3.1 on 2/2/17.
//
// DO NOT MODIFY THIS FILE. IT IS AUTO-GENERATED AND WILL BE OVERWRITTEN
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface SkullAndBonesMenuView : UIView

@property (strong, nonatomic) NSDictionary *viewsByName;

// Skull Appear
- (void)addSkullAppearAnimation;
- (void)addSkullAppearAnimationWithCompletion:(void (^)(BOOL finished))completionBlock;
- (void)addSkullAppearAnimationAndRemoveOnCompletion:(BOOL)removedOnCompletion;
- (void)addSkullAppearAnimationAndRemoveOnCompletion:(BOOL)removedOnCompletion completion:(void (^)(BOOL finished))completionBlock;
- (void)addSkullAppearAnimationWithBeginTime:(CFTimeInterval)beginTime andFillMode:(NSString *)fillMode andRemoveOnCompletion:(BOOL)removedOnCompletion completion:(void (^)(BOOL finished))completionBlock;
- (void)removeSkullAppearAnimation;

- (void)removeAllAnimations;

@end