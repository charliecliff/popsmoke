//
//  HROProgressPopup.h
//  CNPPopupControllerExampleSwift
//

#import "HROPopupController.h"

@interface HROProgressPopupController : HROPopupController

- (nonnull instancetype)initWithContents:(nonnull NSArray<UIView *> *)contents __attribute__((unavailable("You cannot initialize through init - please use initWithIconImage:")));
- (nonnull instancetype)initWithIconImage:(nonnull UIImage *)image NS_DESIGNATED_INITIALIZER;

@end
 
