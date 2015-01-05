//
//  SKStoreProductViewController+Tracking.m
//  DMDynamic
//
//  Created by Derek Lix on 15/1/5.
//  Copyright (c) 2015年 Derek Lix. All rights reserved.
//

#import "SKStoreProductViewController+Tracking.h"

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

@end
