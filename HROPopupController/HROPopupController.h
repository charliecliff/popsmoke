//
//  HROPopupController.h
//  HROPopupController
//

#import <UIKit/UIKit.h>

#define HRO_PRESENT_POPUP @"HRO_PRESENT_POPUP"
#define HRO_DISMISS_POPUP @"HRO_DISMISS_POPUP"

@protocol HROPopupControllerDelegate;
@class HROPopupTheme, HROPopupButton;

@interface HROPopupController : NSObject

@property (nonatomic, strong, readonly) UIView *_Nonnull popupView;
@property (nonatomic, strong, readwrite) HROPopupTheme *_Nonnull theme;
@property (nonatomic, weak, readwrite) id <HROPopupControllerDelegate> _Nullable delegate;

- (nonnull instancetype) init __attribute__((unavailable("You cannot initialize through init - please use initWithContents:")));
- (nonnull instancetype)initWithContents:(nonnull NSArray<UIView *> *)contents NS_DESIGNATED_INITIALIZER;

- (void)presentPopupControllerAnimated:(BOOL)flag;
- (void)dismissPopupControllerAnimated:(BOOL)flag;

@end

@protocol HROPopupControllerDelegate <NSObject>

@optional
- (void)popupControllerWillPresent:(nonnull HROPopupController *)controller;
- (void)popupControllerDidPresent:(nonnull HROPopupController *)controller;
- (void)popupControllerWillDismiss:(nonnull HROPopupController *)controller;
- (void)popupControllerDidDismiss:(nonnull HROPopupController *)controller;

@end

typedef void(^SelectionHandler) (HROPopupButton *_Nonnull button);

@interface HROPopupButton : UIButton

@property (nonatomic, copy) SelectionHandler _Nullable selectionHandler;

@end

// HROPopupStyle: Controls how the popup looks once presented
typedef NS_ENUM(NSUInteger, HROPopupStyle) {
    HROPopupStyleActionSheet = 0, // Displays the popup similar to an action sheet from the bottom.
    HROPopupStyleCentered, // Displays the popup in the center of the screen.
    HROPopupStyleFullscreen // Displays the popup similar to a fullscreen viewcontroller.
};

// HROPopupPresentationStyle: Controls how the popup is presented
typedef NS_ENUM(NSInteger, HROPopupPresentationStyle) {
    HROPopupPresentationStyleFadeIn = 0,
    HROPopupPresentationStyleSlideInFromTop,
    HROPopupPresentationStyleSlideInFromBottom,
    HROPopupPresentationStyleSlideInFromLeft,
    HROPopupPresentationStyleSlideInFromRight
};

// HROPopupMaskType
typedef NS_ENUM(NSInteger, HROPopupMaskType) {
    HROPopupMaskTypeClear,
    HROPopupMaskTypeDimmed,
	HROPopupMaskTypeWhite
};

NS_ASSUME_NONNULL_BEGIN
@interface HROPopupTheme : NSObject

@property (nonatomic, strong) UIColor *backgroundColor; // Background color of the popup content view (Default white)
@property (nonatomic, assign) CGFloat cornerRadius; // Corner radius of the popup content view (Default 4.0)
@property (nonatomic, assign) UIEdgeInsets popupContentInsets; // Inset of labels, images and buttons on the popup content view (Default 16.0 on all sides)
@property (nonatomic, assign) HROPopupStyle popupStyle; // How the popup looks once presented (Default centered)
@property (nonatomic, assign) HROPopupPresentationStyle presentationStyle; // How the popup is presented (Defauly slide in from bottom. NOTE: Only applicable to HROPopupStyleCentered)
@property (nonatomic, assign) HROPopupMaskType maskType; // Backgound mask of the popup (Default dimmed)
@property (nonatomic, assign) BOOL dismissesOppositeDirection; // If presented from a direction, should it dismiss in the opposite? (Defaults to NO. i.e. Goes back the way it came in)
@property (nonatomic, assign) BOOL shouldDismissOnBackgroundTouch; // Popup should dismiss on tapping on background mask (Default yes)
@property (nonatomic, assign) BOOL movesAboveKeyboard; // Popup should move up when the keyboard appears (Default yes)
@property (nonatomic, assign) CGFloat contentVerticalPadding; // Spacing between each vertical element (Default 12.0)
@property (nonatomic, assign) CGFloat maxPopupWidth; // Maxiumum width that the popup should be (Default 300)
@property (nonatomic, assign) CGFloat animationDuration; // Duration of presentation animations (Default 0.3s)

// Factory method to help build a default theme
+ (HROPopupTheme *)defaultTheme;

@end
NS_ASSUME_NONNULL_END
