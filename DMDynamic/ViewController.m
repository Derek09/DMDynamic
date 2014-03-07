//
//  ViewController.m
//  DMDynamic
//
//  Created by Derek Lix on 14-3-7.
//  Copyright (c) 2014年 Derek Lix. All rights reserved.
//

#import "ViewController.h"
#include <objc/runtime.h>

@interface ViewController ()


@property(strong)NSString* dynamicString;

@end

@implementation ViewController

@dynamic dynamicString;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.dynamicString=@"this is dynamic";
    NSLog(@"get :%@",self.dynamicString);
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
    computeNum(obj,@selector(doComputeWithNum:),str);
    return str;
    
}
void dynamicMethodIMP(id obj, SEL _cmd,char* str )
{
}

-(void)doComputeWithNum:(NSString*)string
{
    NSLog(@"doComputeWithNum :%@",string);
}




@end
