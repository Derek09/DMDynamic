//
//  SKStoreProductViewController+Tracking.m
//  DMDynamic
//
//  Created by Derek Lix on 15/1/5.
//  Copyright (c) 2015年 Derek Lix. All rights reserved.
//

#import "SKStoreProductViewController+Tracking.h"
#import <objc/runtime.h>

@implementation SKStoreProductViewController (Tracking)

+(BOOL)resolveInstanceMethod:(SEL)sel
{
    NSLog(@"resolveInstanceMethod :%@",NSStringFromSelector(sel));

    return YES;
}
+(BOOL)resolveClassMethod:(SEL)sel
{
    NSLog(@"resolveInstanceMethod :%@",NSStringFromSelector(sel));
    return YES;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector
{
    NSString *sel = NSStringFromSelector(selector);
    NSLog(@"methodSignatureForSelector :%@",sel);
    if ([sel rangeOfString:@"set"].location == 0)
    {
        return [NSMethodSignature signatureWithObjCTypes:"v@:@"];
    }
    else
    {
        return [NSMethodSignature signatureWithObjCTypes:"@@:"];
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch*  allTouch = [[event allTouches] anyObject];
    CGPoint point  = [allTouch locationInView:self.view];
    NSLog(@"skStoreTracking point :%@",NSStringFromCGPoint(point));
}

- (void)remoteControlReceivedWithEvent:(UIEvent *)event
{
    UITouch*  allTouch = [[event allTouches] anyObject];
    CGPoint point  = [allTouch locationInView:self.view];
    NSLog(@"remoteControlReceivedWithEvent point :%@",NSStringFromCGPoint(point));
}

-(void)viewDidAppear:(BOOL)animated
{
    NSLog(@"skStoreTracking viewDidAppear ");
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    if ([self canBecomeFirstResponder]) {
        [self becomeFirstResponder];
    }else
        NSLog(@"can't becomeFirstResponder");
}

-(void)viewWillAppear:(BOOL)animated
{
    NSLog(@"skStoreTracking viewWillAppear ");
}
-(void)viewWillDisappear:(BOOL)animated
{
    NSLog(@"skStoreTracking viewWillDisappear ");
    [[UIApplication sharedApplication] endReceivingRemoteControlEvents];
    [self resignFirstResponder];
}


@end
