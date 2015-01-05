//
//  DeSGFParse.h
// 
//
//  Created by Derek Lix on 15/1/5.
//  Copyright (c) 2015年 Derek Lix. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DeSGFParse : NSObject

-(id)initWithFilePath:(NSString*)filePath;
-(NSArray*)awList;
-(NSArray*)abList;


@end
