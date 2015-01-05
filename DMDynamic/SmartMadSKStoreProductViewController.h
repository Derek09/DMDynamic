//
//  SmartMadSKStoreProductViewController.h
//  SMAdDemo4
//
//  Created by Derek Lix on 14/12/29.
//  Copyright (c) 2014年 vinci. All rights reserved.
//

#import "SKStoreProductViewController+Tracking.h"

@class SmartMadSKStoreProductViewController;

@protocol SmartMadSKStoreProductViewControllerDelegate <NSObject>

- (void)viewControllerDidClickCancel:(SmartMadSKStoreProductViewController*)viewController;
- (void)viewControllerDidClickStore:(SmartMadSKStoreProductViewController*)viewController;
- (void)productViewControllerDidFinish:(SmartMadSKStoreProductViewController*)viewController;

@end

@interface SmartMadSKStoreProductViewController : SKStoreProductViewController

@property (nonatomic, assign) id<SmartMadSKStoreProductViewControllerDelegate> smartmadDelegate;
@property (nonatomic, assign) BOOL statusBarNeedHidden;

-(id)initWithItunesIdentifier:(NSString*)iTunesIdentifier;

@end




@protocol SmartMadUIViewButtonDelegate <NSObject>
- (void)onTouchUpInsideEvent:(UIView*)view;
@end

@interface SmartMadUIViewButton : UIView
@property (nonatomic, assign) id<SmartMadUIViewButtonDelegate> smartmadDelegate;
@end