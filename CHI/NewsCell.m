//
//  NewsCell.m
//  MeiShi
//
//  Created by qianfeng007 on 15/12/16.
//  Copyright © 2015年 YangRui. All rights reserved.
//

#import "NewsCell.h"
#import "UIView+Common.h"
@implementation NewsCell{
    UILabel *_label1;
    UILabel *_label2;

}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self customViews];
    }
    return self;
}
- (void)customViews
{
    _label1 = [[UILabel alloc]init];
    _label1.textAlignment = NSTextAlignmentCenter;
    _label1.layer.cornerRadius = 15;
    _label1.clipsToBounds = YES;
    _label1.backgroundColor = [UIColor colorWithRed:174/256.0 green:238/256.0 blue:238/256.0 alpha:1.0];
    _label2 = [[UILabel alloc]init];
    _label2.font = [UIFont systemFontOfSize:18];
    _label2.textColor = [UIColor redColor];
    [self.contentView addSubview:_label1];
    [self.contentView addSubview:_label2];

}
- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat topPadding = 10;
    CGFloat leftPadding = 10;
    CGFloat Padding = 10;
    _label1.frame = CGRectMake(leftPadding, topPadding, 30, 30);
    _label2.frame = CGRectMake(maxX(_label1)+Padding, topPadding, 300, 30);
    
}
- (void)updateModel:(ResultModel *)model index:(NSInteger)row;
{
    _label1.text = [NSString stringWithFormat:@"%ld",row];
    _label2.text = model.title;
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
