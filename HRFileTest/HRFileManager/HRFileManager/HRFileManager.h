//
//  HRManager.h
//  HRFileManager
//
//  Created by ZhangHeng on 15/7/25.
//  Copyright (c) 2015年 ZhangHeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HRFileManager : NSObject

/**
 *  @author Henry
 *
 *  新建文件夹
 *
 *  @param folderName 文件夹名
 *  @param path       路径名
 */
+(void)createNewFolder:(NSString *)folderName atPath:(NSString *)path;

/**
 *  @author Henry
 *
 *  移动文件到指定路径
 *
 *  @param fromPath        原始文件路径
 *  @param destinationPath 目标路径
 */
+(void)moveFileFromPath:(NSString *)fromPath ToDestinationPath:(NSString *)destinationPath;

/**
 *  @author Henry
 *
 *  复制文件到指定目录
 *
 *  @param path            原始路径
 *  @param destinationPath 目标路径
 */
+(void)copyItemFromPath:(NSString *)path toDestinatonPath:(NSString *)destinationPath;

/**
 *  @author Henry
 *
 *  获取指定目录下的一级文件列表
 *
 *  @param path 文件路径，当传nil时默认取Documents目录
 */
+(NSArray *)getFileListUnderPath:(NSString *)path;

/**
 *  @author Henry
 *
 *  取指定目录下的文件夹列表
 *
 *  @param path 路径，可为空，当传空时默认取Documents目录
 *
 *  @return 以HRFileItem组成的数组
 */
+(NSArray *)getFolderListUnderPath:(NSString *)path;

/**
 *  @author Henry
 *
 *  取指定目录下的所有项目，包含文件和文件夹
 *
 *  @param path 路径，可为空，当为空时默认为Documents目录
 *
 *  @return 以HRFileItem组成的数组
 */

+(NSArray *)getAllItemsListUnderPath:(NSString *)path;

/**
 *  @author Henry
 *
 *  搜索指定目录下特定的关键字
 *
 *  @param keyString 关键名字
 *  @param path      指定路径
 *
 *  @return 文件和文件夹列表
 */
+(NSArray *)searchForItemWithName:(NSString *)keyString AtPath:(NSString *)path;


/**
 *  @author Henry
 *
 *  删除指定目录下的文件
 *
 *  @param path 文件路径
 *
 *  @return 以HRFileItem组成的数组
 */
+(void)deleteFileAtPath:(NSString *)path;

/**
 *  @author Henry
 *
 *  重命名文件
 *
 *  @param fileName 新文件名
 *  @param path     文件路径
 */
+(void)renameFileWithName:(NSString *)fileName atPath:(NSString *)path;

/**
 *  @author Henry
 *
 *  获取框架内bundle包的资源图片
 *
 *  @param imageName 图片名
 *
 *  @return 图片对象
 *
 */
+(UIImage *)getMyBundleImageWithName:(NSString *)imageName;
@end
