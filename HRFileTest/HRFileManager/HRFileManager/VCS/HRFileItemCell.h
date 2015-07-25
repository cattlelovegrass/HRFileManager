//
//  HRFileItemCell.h
//  HRFileManager
//
//  Created by ZhangHeng on 15/7/25.
//  Copyright (c) 2015年 ZhangHeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HRFileItem.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface HRFileItemCell : UITableViewCell

@property(nonatomic,strong)HRFileItem *fileItem;

@end
