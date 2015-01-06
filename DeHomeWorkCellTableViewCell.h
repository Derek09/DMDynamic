//
//  DeHomeWorkCellTableViewCell.h
//  DMDynamic
//
//  Created by Derek Lix on 15/1/6.
//  Copyright (c) 2015年 Derek Lix. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DeHomeWorkCellTableViewCell : UITableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier  data:(NSArray*)data;

-(CGFloat)cellHeight;


@end
