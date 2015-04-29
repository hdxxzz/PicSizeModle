//
//  PicSizeModel.m
//  DiguFocus
//
//  Created by FLYGo on 14-1-3.
//  Copyright (c) 2014年 joffeec. All rights reserved.
//

#import "PicSizeModel.h"

#import "DiguUtils.h"

@implementation PicSizeModel


/**
 *  根据宽和高初始化对象
 *
 *  @param imageWidth  图片宽度
 *  @param imageHeight 图片高度
 *
 *  @return 返回初始化好的对象
 */
-(id) initWithImageWith:(int) imageWidth imageHeight:(int)imageHeight
{
    self = [super init];
    if (self) {
        _imageWidth = imageWidth;
        _imageHeight = imageHeight;
    }
    
    return self;
}

/**
 *  根据宽和高初始化对象
 *
 *  @param imageWidth     图片的宽度
 *  @param imageHeight    图片的高度
 *  @param topImageWidth  头条图片的宽度
 *  @param topImageHeight 头条图片的高度
 *
 *  @return 返回初始化好的对象
 */
-(id) initWithImageWith:(int)imageWidth imageHeight:(int)imageHeight topImageWidth:(int) topImageWidth topImageHeight:(int) topImageHeight
{
    self = [super init];
    if (self) {
        _imageWidth = imageWidth;
        _imageHeight = imageHeight;
        _topImageWidth = topImageWidth;
        _topImageHeight = topImageHeight;
    }
    
    return self;
}

/**
 *  根据头条的宽个高初始化
 *
 *  @param topImageWidth  头条新闻图片的宽度
 *  @param topImageHeight 头条新闻图片的高度
 *
 *  @return 返回初始化好的对象
 */
-(id) initWithTopImageWidth:(int) topImageWidth topImageHeight:(int) topImageHeight
{
    self = [super init];
    
    if (self) {
        _topImageWidth = topImageWidth;
        _topImageHeight = topImageHeight;
    }
    
    return self;
}


+ (NSURL *) ordinaryFixedURLFromWidth:(NSString *)picUrl picWidth:(NSInteger)width picHeight:(NSInteger) height
{
    return [NSURL URLWithString:[DiguUtils ordinaryFixedURLFromWidth:picUrl picWidth:width picHeight:height]];
}


@end
