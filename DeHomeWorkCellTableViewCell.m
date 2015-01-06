//
//  DeHomeWorkCellTableViewCell.m
//  DMDynamic
//
//  Created by Derek Lix on 15/1/6.
//  Copyright (c) 2015年 Derek Lix. All rights reserved.
//

#import "DeHomeWorkCellTableViewCell.h"


#define ContentImageHeight  (100)
#define ContentImageWidth   (100)

@interface DeHomeWorkCellTableViewCell ()

@property(nonatomic,assign)CGFloat  cellHeight;
@property(nonatomic,strong)NSArray* dataArray;

@end

@implementation DeHomeWorkCellTableViewCell


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier  data:(NSArray*)data
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.dataArray = data;
    }
    return self;
}

-(void)addTitle{
    //add date
    CGFloat  labelHeight  = 28.f;
    CGFloat  labelWidth   = 150.f;
    CGFloat  labelY  = 0.f;
    CGFloat  labelX = 10.f;
    UILabel* dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(labelX, labelY, labelWidth, labelHeight)];
    dateLabel.text = @"11月20号";
    [self addSubview:dateLabel];
    
    labelX = self.frame.size.width - labelWidth-labelX;
    UILabel* finishedStatusLabel = [[UILabel alloc] initWithFrame:CGRectMake(labelX, labelY, labelWidth, labelHeight)];
    finishedStatusLabel.text = @"finished";
    [self addSubview:finishedStatusLabel];
    
    //add line
}
-(void)addContent{
    
    NSArray* array = [NSArray arrayWithObjects:@"1",@"2",@"3", nil];
    for (NSInteger i = 0 ;i < [array count]; i++) {
        CGFloat  rectX = (self.frame.size.width - ContentImageWidth*2)/3;
       // CGRect rect4CurrentImage =  CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
        
    }
    
}

-(CGFloat)cellHeight
{
    return self.cellHeight;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
