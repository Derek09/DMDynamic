//
//  ViewController.m
//  DMDynamic
//
//  Created by Derek Lix on 14-3-7.
//  Copyright (c) 2014年 Derek Lix. All rights reserved.
//

#import "ViewController.h"
#include <objc/runtime.h>
#import "SmartMadSKStoreProductViewController.h"
#import "DeCollectionViewController.h"

@interface ViewController ()<SmartMadSKStoreProductViewControllerDelegate>


@property(strong)NSString* dynamicString;
@property(strong)SmartMadSKStoreProductViewController* storeViewController;

@end

@implementation ViewController

@dynamic dynamicString;
- (IBAction)btnClicked:(id)sender {
    
//    DeCollectionViewController* collectionViewController = [[DeCollectionViewController alloc] init];
//     [self presentViewController:collectionViewController animated:YES completion:nil];
//    return;
    _storeViewController = [[SmartMadSKStoreProductViewController alloc] initWithItunesIdentifier:@"529479190"];//508314963
  //  self.storeViewController.smartmadDelegate = self;
    self.storeViewController.statusBarNeedHidden = [UIApplication sharedApplication].statusBarHidden;
    [self presentViewController:self.storeViewController animated:YES completion:nil];
   // https://itunes.apple.com/cn/app/squares-challenging-puzzle/id910510217?mt=8
    
    //https://itunes.apple.com/cn/app/bu-luo-chong-tu-clash-of-clans/id529479190?mt=8
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
//    self.dynamicString=@"this is dynamic";
//    NSLog(@"get :%@",self.dynamicString);
}

+(BOOL)resolveInstanceMethod:(SEL)name
{
    if ([NSStringFromSelector(name) isEqualToString:@"setDynamicString:"]) {
        class_addMethod([self class],name, (IMP)dynamicMethodIMP, "v@:@");
        return YES;
    }
    if ([NSStringFromSelector(name) isEqualToString:@"dynamicString"]) {
        class_addMethod([self class],name, (IMP)getdynamicMethodIMP, "@@:@");
        return YES;
    }
    
    return [super resolveInstanceMethod:name];
}

id getdynamicMethodIMP(id obj,SEL _cmd,id str ) //str is the value of dynamicString
{
    
    //how to access function of objective-c
    int (*computeNum)(id,SEL,int);
    computeNum = (int (*)(id,SEL,int))[obj methodForSelector:@selector(doComputeWithNum:)];
    computeNum(obj,@selector(doComputeWithNum:),1);
    return str;
    
}
void dynamicMethodIMP(id obj, SEL _cmd,char* str )
{
}

-(void)doComputeWithNum:(NSInteger)value
{
    NSLog(@"doComputeWithNum :%d",value);
}




@end
