//
//  HRFile.h
//  HRFileManager
//
//  Created by ZhangHeng on 15/7/25.
//  Copyright (c) 2015年 ZhangHeng. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum{
    HRFileTypeFile = 0,
    HRFileTypeFolder
}HRFileType;

@interface HRFileItem : NSObject

@property(nonatomic,strong)NSString *fileName;
@property(nonatomic,strong)NSString *filePath;
@property(nonatomic,assign)HRFileType fileType;
@property(nonatomic,strong)NSString *fileSize;

@end
