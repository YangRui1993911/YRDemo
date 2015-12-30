//
//  NewsCell.h
//  MeiShi
//
//  Created by qianfeng007 on 15/12/16.
//  Copyright © 2015年 YangRui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsModel.h"
@interface NewsCell : UITableViewCell

- (void)updateModel:(ResultModel *)model index:(NSInteger)row;
@end
