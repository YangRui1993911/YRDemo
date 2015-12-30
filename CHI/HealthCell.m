//
//  HealthCell.m
//  CHI
//
//  Created by qianfeng007 on 15/12/17.
//  Copyright © 2015年 YangRui. All rights reserved.
//

#import "HealthCell.h"
#import <UIImageView+WebCache.h>
@implementation HealthCell
{
    UIImageView *_imageView;
    UILabel *_titleLabel;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self coustoms];
    }
    return self;
}
- (void)coustoms
{
    _imageView = [[UIImageView alloc]init];
    _imageView.layer.cornerRadius = 13;
    _imageView.clipsToBounds = YES;
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.font = [UIFont boldSystemFontOfSize:15];
    _titleLabel.numberOfLines = 2;
    _titleLabel.layer.cornerRadius = 8;
    _titleLabel.clipsToBounds = YES;
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.backgroundColor = [UIColor colorWithRed:240/256.0 green:255/256.0 blue:240/256.0 alpha:1.0];
    
    [self.contentView addSubview:_imageView];
    [self.contentView addSubview:_titleLabel];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat topPadding = 5;
    CGFloat leftPadding = 5;
    CGFloat Padding = 10;
    _imageView.frame = CGRectMake(leftPadding, topPadding, self.contentView.frame.size.width-Padding/2, 200);
    _titleLabel.frame = CGRectMake(leftPadding, CGRectGetMaxY(_imageView.frame), self.contentView.frame.size.width-Padding/2, 40);
    
    
}
- (void)setModel:(TngouModel *)model
{
    NSString *str = [NSString stringWithFormat:@"http://tnfs.tngou.net/image%@",model.img];
    [_imageView sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:nil];
    _titleLabel.text = model.name;
    
}

@end
