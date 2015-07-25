//
//  HRSelectPathVC.h
//  HRFileManager
//
//  Created by ZhangHeng on 15/7/25.
//  Copyright (c) 2015年 ZhangHeng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    HRSelectFileOnly = 0,
    HRSelectFilePathOnly
}HRSelectFileType;


@protocol HRSelectPathDelegate <NSObject>

-(void)didSelectFilePath:(NSString *)path;

@end


@interface HRSelectPathVC : UIViewController

@property(nonatomic,weak)id<HRSelectPathDelegate> delegate;
@property(nonatomic,strong)NSString *path;

//当将文件夹复制到自身时会出现问题，需要排除
@property(nonatomic,strong)NSString *excludePath;

//使用此方法初始化
-(id)initWithSelectType:(HRSelectFileType )selectType andPath:(NSString *)path;

@end
