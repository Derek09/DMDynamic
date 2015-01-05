//
//  DeSGFParse.m
//
//
//  Created by Derek Lix on 15/1/5.
//  Copyright (c) 2015年 Derek Lix. All rights reserved.
//

#import "DeSGFParse.h"


#define  AB_STR            @"AB"
#define  AW_STR            @"AW"
#define  AR_STR            @"AR"
#define  AP_STR            @"AP"
#define  CA_STR            @"CA"
#define  Left_Bracket      @"["
#define  Right_Bracket     @"]"
#define  PreFix_Len        2

#define useThread  @"useThread"

@interface DeSGFParse ()

@property(nonatomic,strong)NSMutableArray*   wList;
@property(nonatomic,strong)NSMutableArray*   bList;

@end

typedef NS_ENUM(NSInteger, StoneType)
{
    W_Stone=0,
    B_Stone=1
};

@implementation DeSGFParse

-(id)initWithFilePath:(NSString*)filePath{
    if (self= [super init]) {
        _wList = [[NSMutableArray alloc] init];
        _bList = [[NSMutableArray alloc] init];
        [self parse:filePath];
    }
    return self;
}

-(void)parse:(NSString*)filePath
{
    if (!filePath) return;
    
    __block NSString*  fileContent = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
#ifdef useThread
    __block NSInteger  contentLen = [fileContent length];
    if (contentLen>0){
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            [self doParse:fileContent];
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"w :%@",self.wList);
                NSLog(@"b :%@",self.bList);
            });
        });
    }
#else
    [self doParse:fileContent];
#endif

}

-(void)doParse:(NSString*)string
{
    if (!string || ([string length] <1) ) return ;
    
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString* prefix_2Len = [string substringToIndex:PreFix_Len];
    if ([prefix_2Len isEqualToString:AB_STR]) {
        string = [string substringFromIndex:[AB_STR length]];
        string = [self getStones:string type:B_Stone];
        if ([string length] >2) {
            [self doParse:string];
        }
        
    }else if ([prefix_2Len isEqualToString:AW_STR]) {
        string = [string substringFromIndex:[AW_STR length]];
        string = [self getStones:string type:W_Stone];
        if ([string length] >2) {
            [self doParse:string];
        }
    }else{
        string = [string substringFromIndex:1]; //subtrace one character everytime
        if ([string length]>2) {
            [self doParse:string];
        }
        
    }
}


-(NSString*)getStones:(NSString*)string type:(StoneType)type
{
    if (!string || ([string length]<1)) return string;
    NSString*  fstr = [string substringWithRange:NSMakeRange(0, 1)];
    if ([fstr isEqualToString:Left_Bracket]) {
        string = [string substringFromIndex:[Left_Bracket length]];
        NSRange  rightBra =  [string rangeOfString:Right_Bracket];
        if (rightBra.length<1) {
            NSLog(@"error sgf format");
            return string;
        }
        NSString* stoneCoordinate = [string substringToIndex:(rightBra.location)];
        NSLog(@"stoneAccordinate :%@",stoneCoordinate);
        switch (type) {
            case W_Stone:{
                if (self.wList) {
                    [self.wList addObject:stoneCoordinate];
                }
            }
                break;
            case B_Stone:{
                if (self.bList) {
                    [self.bList addObject:stoneCoordinate];
                }
            }
                break;
            default:
                break;
        }
        if ([string length]<=rightBra.location+1) return string;
        
        string =[string substringFromIndex:(rightBra.location+1)];
        string =[self getStones:string type:type];
    }
    return string;
}

-(NSArray*)awList{
    return self.wList;
}

-(NSArray*)abList{
    return self.bList;
}

@end
