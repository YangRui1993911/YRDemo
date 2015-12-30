//
//  CakeCell.m
//  MeiShi
//
//  Created by qianfeng007 on 15/12/15.
//  Copyright © 2015年 YangRui. All rights reserved.
//

#import "CakeCell.h"
#import "UIView+Common.h"
#import <UIImageView+WebCache.h>
@implementation CakeCell{
    UIImageView *_imageView;
    UILabel *_titleLabel;
    UILabel *_contentLabel;
    UILabel *_dataLabel;


}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self customViews];
    }
    return self;
}
- (void)customViews
{
    _imageView = [[UIImageView alloc]init];
    _imageView.layer.cornerRadius = 20;
    _imageView.clipsToBounds = YES;
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.font = [UIFont boldSystemFontOfSize:16];
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.numberOfLines = 2;
    
    _contentLabel = [[UILabel alloc]init];
    _contentLabel.font = [UIFont systemFontOfSize:14];
    _contentLabel.numberOfLines = 0;
    _contentLabel.textColor = [UIColor blackColor];
    _dataLabel = [[UILabel alloc]init];
    _dataLabel.font = [UIFont systemFontOfSize:13];
    
    [self.contentView addSubview:_imageView];
    [self.contentView addSubview:_titleLabel];
    [self.contentView addSubview:_contentLabel];
    [self.contentView addSubview:_dataLabel];

}
-(void)layoutSubviews
{
    
    [super layoutSubviews];
    CGFloat topPadding = 20;
    CGFloat leftPadding = 20;
    CGFloat Padding = 10;
    _imageView.frame = CGRectMake(leftPadding, topPadding, 80, 80);
    _titleLabel.frame = CGRectMake(Padding+maxX(_imageView), 2*topPadding, 250, 40);
    _contentLabel.frame = CGRectMake(leftPadding, Padding+maxY(_imageView), self.contentView.frame.size.width-2*leftPadding,60);
    _dataLabel.frame = CGRectMake(leftPadding, self.contentView.frame.size.height-20, 200, 10);

}
- (void)setModel:(PostsModel *)model
{
    _model = model;
    [_imageView sd_setImageWithURL:[NSURL URLWithString:model.thumbnail] placeholderImage:nil];
    _titleLabel.text = model.title;
    
    
    NSString *nstring = model.excerpt;
    NSArray *array = [nstring componentsSeparatedByString:@"&"];
    NSString *str = array[0];
    NSArray *arr = [str componentsSeparatedByString:@"“"];
    _contentLabel.text = arr[1];
    
    //_contentLabel.text = model.excerpt;
    _dataLabel.text = model.date;

}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
