//
//  SmartMadSKStoreProductViewController.m
//  SMAdDemo4
//
//  Created by Derek Lix on 14/12/29.
//  Copyright (c) 2014年 vinci. All rights reserved.
//

#import "SmartMadSKStoreProductViewController.h"

#define FAKE_BUTTON_WIDTH   72
#define NAVIGATION_BAR_HEIGHT_PORTRAIT  44
#define NAVIGATION_BAR_HEIGHT_LANDSCAPE 32
#define PAD_STORE_PRODUCT_VIEW_CONTROLLER_WIDTH     630
#define PAD_STORE_PRODUCT_VIEW_CONTROLLER_HEIGHT    674

static  CGRect   gstoreMaskRect;
static  CGRect   gcancelMaskRect;

@interface SmartMadSKStoreProductViewController ()<SmartMadUIViewButtonDelegate,SKStoreProductViewControllerDelegate>
{
    SmartMadUIViewButton *_smUIViewButtonCancel;
    SmartMadUIViewButton *_smUIViewButtonStore;
}

@property(nonatomic,strong)NSString*  itunesID;
@end

@implementation SmartMadSKStoreProductViewController


-(id)initWithItunesIdentifier:(NSString*)iTunesIdentifier
{
    if (self=[super init]) {
        self.itunesID = iTunesIdentifier;
        _smUIViewButtonCancel = [[SmartMadUIViewButton alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
        _smUIViewButtonCancel.smartmadDelegate = self;
        _smUIViewButtonCancel.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.02];
        
        _smUIViewButtonStore = [[SmartMadUIViewButton alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
        _smUIViewButtonStore.smartmadDelegate = self;
        _smUIViewButtonStore.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.02];
        self.delegate =self;
        [self hideStoreCover:YES];
        if (iTunesIdentifier) {
            NSDictionary *parameters =
            @{SKStoreProductParameterITunesItemIdentifier:
                  [NSNumber numberWithInteger:[iTunesIdentifier integerValue]]}
            ;
            [self loadProductWithParameters:parameters
                                            completionBlock:^(BOOL result, NSError *error) {
                                                
                                                if (result) {
                                                    NSLog(@"loadProductWithParameters OK");
                                                    [self hideStoreCover:NO];
                                                }
                                                else {
                                                    NSLog(@"loadProductWithParameters Fail");
                                                }
                                            }];
        }

    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (void)hideStoreCover:(BOOL)hide {
    if (hide) {
        _smUIViewButtonStore.hidden = YES;
    }
    else {
        _smUIViewButtonStore.hidden = NO;
    }
    
}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [self layoutTheCovers];
}

- (BOOL)prefersStatusBarHidden {
    return self.statusBarNeedHidden;
}

- (void)layoutTheCovers {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        [self coverOnPhone];
    }
    else {
        [self coverOnPad];
    }
}

- (void)coverOnPad {
    NSInteger portraitWidth=self.view.frame.size.width;
    NSInteger portraitHeight=self.view.frame.size.height;
    
    CGRect frameCancel,frameStore;
    
    if (UIInterfaceOrientationIsPortrait(self.interfaceOrientation)) {
        frameCancel = CGRectMake(portraitWidth/2-PAD_STORE_PRODUCT_VIEW_CONTROLLER_WIDTH/2,
                                 portraitHeight/2-PAD_STORE_PRODUCT_VIEW_CONTROLLER_HEIGHT/2, FAKE_BUTTON_WIDTH, NAVIGATION_BAR_HEIGHT_PORTRAIT);
        frameStore = CGRectMake(portraitWidth/2+PAD_STORE_PRODUCT_VIEW_CONTROLLER_WIDTH/2-FAKE_BUTTON_WIDTH,
                                portraitHeight/2-PAD_STORE_PRODUCT_VIEW_CONTROLLER_HEIGHT/2, FAKE_BUTTON_WIDTH, NAVIGATION_BAR_HEIGHT_PORTRAIT);
    }
    else {
        frameCancel = CGRectMake(portraitHeight/2-PAD_STORE_PRODUCT_VIEW_CONTROLLER_WIDTH/2,
                                 portraitWidth/2-PAD_STORE_PRODUCT_VIEW_CONTROLLER_HEIGHT/2, FAKE_BUTTON_WIDTH, NAVIGATION_BAR_HEIGHT_PORTRAIT);
        frameStore = CGRectMake(portraitHeight/2+PAD_STORE_PRODUCT_VIEW_CONTROLLER_WIDTH/2-FAKE_BUTTON_WIDTH,
                                portraitWidth/2-PAD_STORE_PRODUCT_VIEW_CONTROLLER_HEIGHT/2, FAKE_BUTTON_WIDTH, NAVIGATION_BAR_HEIGHT_PORTRAIT);
    }
    
    _smUIViewButtonCancel.frame = frameCancel;
    [_smUIViewButtonCancel removeFromSuperview];
    [self.view addSubview:_smUIViewButtonCancel];
    
    _smUIViewButtonStore.frame = frameStore;
    [_smUIViewButtonStore removeFromSuperview];
    [self.view addSubview:_smUIViewButtonStore];
    
    
    gstoreMaskRect = [self.view convertRect:_smUIViewButtonStore.frame toView:nil];
    gcancelMaskRect = [self.view convertRect:_smUIViewButtonCancel.frame toView:nil];
}


- (void)coverOnPhone {
    NSInteger portraitWidth=self.view.frame.size.width;
    NSInteger portraitHeight=self.view.frame.size.height;
    
    CGRect frameCancel,frameStore;
    
    if (UIInterfaceOrientationIsPortrait(self.interfaceOrientation)) {
        frameCancel = CGRectMake(0, 0, FAKE_BUTTON_WIDTH, NAVIGATION_BAR_HEIGHT_PORTRAIT);
        frameStore = CGRectMake(portraitWidth-FAKE_BUTTON_WIDTH, 0, FAKE_BUTTON_WIDTH, NAVIGATION_BAR_HEIGHT_PORTRAIT);
    }
    else {
        frameCancel = CGRectMake(0, 0, FAKE_BUTTON_WIDTH, NAVIGATION_BAR_HEIGHT_LANDSCAPE);
        frameStore = CGRectMake(portraitHeight-FAKE_BUTTON_WIDTH, 0, FAKE_BUTTON_WIDTH, NAVIGATION_BAR_HEIGHT_LANDSCAPE);
    }
    
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        frameCancel.origin.y += [self statusBarHeight];
        frameStore.origin.y += [self statusBarHeight];
    }
    
    _smUIViewButtonCancel.frame = frameCancel;
    [_smUIViewButtonCancel removeFromSuperview];
    [self.view addSubview:_smUIViewButtonCancel];
    
    _smUIViewButtonStore.frame = frameStore;
    [_smUIViewButtonStore removeFromSuperview];
    [self.view addSubview:_smUIViewButtonStore];
    
    
    gstoreMaskRect = [self.view convertRect:_smUIViewButtonStore.frame toView:nil];
    gcancelMaskRect = [self.view convertRect:_smUIViewButtonCancel.frame toView:nil];
    
}

- (CGFloat)statusBarHeight {
    if ([UIApplication sharedApplication].statusBarHidden) {
        return 0;
    }
    CGSize size = [[UIApplication sharedApplication] statusBarFrame].size;
    return MIN(size.width, size.height);
}


#pragma mark SmartMadUIViewButtonDelegate
- (void)onTouchUpInsideEvent:(UIView*)view {
    if (view == _smUIViewButtonCancel) {
        if (self.smartmadDelegate && [self.smartmadDelegate respondsToSelector:@selector(viewControllerDidClickCancel:)]) {
            [self.smartmadDelegate viewControllerDidClickCancel:self];
        }
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else if (view == _smUIViewButtonStore) {
        if (self.smartmadDelegate && [self.smartmadDelegate respondsToSelector:@selector(viewControllerDidClickStore:)]) {
            [self.smartmadDelegate viewControllerDidClickStore:self];
        }

        NSString *string = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/us/app/id%@?mt=8",self.itunesID];//temp
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:string]];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}


#pragma mark  SKStoreProductViewControllerDelegate
-(void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController {
    NSLog(@"productViewControllerDidFinish");
    if (self.smartmadDelegate&&[self.smartmadDelegate respondsToSelector:@selector(productViewControllerDidFinish:)]) {
        [self.smartmadDelegate productViewControllerDidFinish:self];
    }
}



@end


@interface  SmartMadUIViewButton ()

@end

@implementation SmartMadUIViewButton


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (self.smartmadDelegate && [self.smartmadDelegate respondsToSelector:@selector(onTouchUpInsideEvent:)]) {
        [self.smartmadDelegate onTouchUpInsideEvent:self];
    }
}
@end
