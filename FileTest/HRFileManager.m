//
//  HRManager.m
//  HRFileManager
//
//  Created by ZhangHeng on 15/7/25.
//  Copyright (c) 2015年 ZhangHeng. All rights reserved.
//

#import "HRFileManager.h"
#import "HRFileItem.h"

@implementation HRFileManager

+(NSFileManager *)fileManager{
    return [NSFileManager defaultManager];
}

+(NSString *)getDocumentPath{
    return [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
}

+(void)deleteFileAtPath:(NSString *)path{
    if(!path)
        return;
    [[self fileManager] removeItemAtPath:path error:nil];
}

+(void)renameFileWithName:(NSString *)fileName atPath:(NSString *)path{
    if(!path)
        return;
    [[self fileManager] moveItemAtPath:path toPath:[[path stringByDeletingLastPathComponent] stringByAppendingPathComponent:fileName] error:nil];
}

+(void)copyItemFromPath:(NSString *)path toDestinatonPath:(NSString *)destinationPath{
    if(!path || !destinationPath)
        return;
    [[self fileManager] copyItemAtPath:path toPath:destinationPath error:nil];
}

+(void)moveFileFromPath:(NSString *)fromPath ToDestinationPath:(NSString *)destinationPath{
    if(!fromPath || !destinationPath)
        return;
    [[self fileManager] moveItemAtPath:fromPath toPath:destinationPath error:nil];
}

+(NSArray *)getAllItemsListUnderPath:(NSString *)path{
    if(!path)
        path = [self getDocumentPath];
    NSMutableArray *itemsArray = [NSMutableArray new];
    
    NSArray *items = [[self fileManager] contentsOfDirectoryAtPath:path error:nil];
    for(NSString *itemPath in items){
        HRFileItem *item = [HRFileItem new];
        item.fileName = [itemPath lastPathComponent];
        item.filePath = [path stringByAppendingPathComponent:itemPath];
        
        NSDictionary * attributes = [[self fileManager] attributesOfItemAtPath:item.filePath error:nil];
        unsigned long long fileSize = [[attributes objectForKey:NSFileSize] unsignedLongLongValue];
        item.fileSize  = [NSByteCountFormatter stringFromByteCount:fileSize countStyle:NSByteCountFormatterCountStyleFile];
        BOOL isDirectory;
        if([[self fileManager] fileExistsAtPath:item.filePath isDirectory:&isDirectory]){
            if(isDirectory)
                item.fileType = HRFileTypeFolder;
            else
                item.fileType = HRFileTypeFile;
        }
        
        [itemsArray addObject:item];
    }
    
    return itemsArray;
}

+(NSArray *)getFileListUnderPath:(NSString *)path{
    if(!path)
        path = [self getDocumentPath];
    
    NSMutableArray *fileList = [NSMutableArray new];
    
    NSArray *items = [[self fileManager] contentsOfDirectoryAtPath:path error:nil];
    for(NSString *itemPath in items){
        HRFileItem *item = [HRFileItem new];
        item.fileName = [itemPath lastPathComponent];
        item.filePath = [path stringByAppendingPathComponent:itemPath];
        
        NSDictionary * attributes = [[self fileManager] attributesOfItemAtPath:item.filePath error:nil];
        unsigned long long fileSize = [[attributes objectForKey:NSFileSize] unsignedLongLongValue];
        item.fileSize  = [NSByteCountFormatter stringFromByteCount:fileSize countStyle:NSByteCountFormatterCountStyleFile];
        
        BOOL isDirectory;
        //只加入非目录情况
        if([[self fileManager] fileExistsAtPath:item.filePath isDirectory:&isDirectory]){
            if(!isDirectory){
                item.fileType = HRFileTypeFile;
                [fileList addObject:item];
            }
        }
    }
    
    return fileList;
}

+(NSArray *)getFolderListUnderPath:(NSString *)path{
    if(!path)
        path = [self getDocumentPath];
    
    NSMutableArray *folderList = [NSMutableArray new];
    
    NSArray *items = [[self fileManager] contentsOfDirectoryAtPath:path error:nil];
    for(NSString *itemPath in items){
        HRFileItem *item = [HRFileItem new];
        item.fileName = [itemPath lastPathComponent];
        item.filePath = [path stringByAppendingPathComponent:itemPath];
        
        NSDictionary * attributes = [[self fileManager] attributesOfItemAtPath:item.filePath error:nil];
        unsigned long long fileSize = [[attributes objectForKey:NSFileSize] unsignedLongLongValue];
        item.fileSize  = [NSByteCountFormatter stringFromByteCount:fileSize countStyle:NSByteCountFormatterCountStyleFile];
        
        BOOL isDirectory;
        //只加入非目录情况
        if([[self fileManager] fileExistsAtPath:item.filePath isDirectory:&isDirectory]){
            if(isDirectory){
                item.fileType = HRFileTypeFile;
                [folderList addObject:item];
            }
        }
    }
    
    return folderList;
}

+(NSArray *)searchForItemWithName:(NSString *)keyString AtPath:(NSString *)path{
    NSMutableArray *results = [NSMutableArray new];
    
    
    
    return results;
}

@end
