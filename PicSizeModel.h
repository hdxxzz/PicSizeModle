//
//  PicSizeModel.h
//  DiguFocus
//  Created by FLYGo on 14-1-3.
//  Copyright (c) 2014年 joffeec. All rights reserved.
//

#import <Foundation/Foundation.h>

// 好友动态正方形的图片图片大小
#define kFriends_DyncFeed_Pic_Square_Size_160           160

// 好友动态 【混合使用300x190】（长图最大尺寸 300x190,宽图 最大尺寸200x300）
#define kFriends_DyncFeed_Pic_Size_300                  300

// 好友动态 【混合使用300x190】（长图最大尺寸 300x190,宽图 最大尺寸200x300）
#define kFriends_DyncFeed_Pic_Size_190                  190

// 好友动态 【混合使用200x300】（长图最大尺寸 300x190,宽图 最大尺寸200x300）
#define kFriends_DyncFeed_Pic_Size_200                  200

// 好友动态 一张图片的正方形图片【可单独使用】
#define kFriends_DyncFeed_Pic_Size_360                  360

// 图片大小：560【混合使用560x372】
#define kDigu_Pic_Size_560                              560

// 图片大小：372【混合使用560x372】
#define kDigu_Pic_Size_372                              372

// 图片大小：184【混合使用184x244，184x244】
#define kDigu_Pic_Size_184                              184

// 图片大小：244【混合使用244x184，184x244】
#define kDigu_Pic_Size_244                              244

// 图片大小：120【可单独使用】
#define kDigu_Pic_Size_120                              120

// 图片大小：100【可单独使用】
#define kDigu_Pic_Size_100                              100

// 图片大小：72【可单独使用】
#define kDigu_Pic_Size_72                               72

// 图片大小：640【可单独使用】
#define kDigu_Pic_Size_640                              640

// 图片大小：488【混合使用640x488】
#define kDigu_Pic_Size_488                              488

// 图片大小：736【可单独使用】
#define kDigu_Pic_Size_736                              736

// 图片大小：50【可单独使用】
#define kDigu_Pic_Size_50                               50

// 图片大小：274【可单独使用】
#define kDigu_Pic_Size_274                              274

// 图片大小：178【可单独使用】
#define kDigu_Pic_Size_178                              178

// 图片大小：300【混合使用578x300】
#define kDigu_Pic_Size_300                              300

// 图片大小：578 【联合使用578x300】
#define kDigu_Pic_Size_578                              578

// 图片大小：540 【联合使用540x304】
#define kDigu_Pic_Size_540                              540

// 图片大小：300 【联合使用540x304】
#define kDigu_Pic_Size_304                              304

// 图片大小：196 【可单独使用】
#define kDigu_Pic_Size_196                              196

// 图片大小：160 【可单独使用】
#define kDigu_Pic_Size_160                              160

// 图片大小：60 【可单独使用】
#define kDigu_Pic_Size_60                               60

// 图片大小：48
#define kDigu_Pic_Size_48                               48

// 图片大小：32
#define kDigu_Pic_Size_32                               32



@interface PicSizeModel : NSObject

// 到服务器取图片的宽度
@property(assign,nonatomic) int imageWidth;

// 到服务器取图片的高度
@property(assign,nonatomic) int imageHeight;

// 到服务器取头条新闻图片的宽度
@property(assign,nonatomic) int topImageWidth;

// 到服务器取头条新闻图片的高度
@property(assign,nonatomic) int topImageHeight;

/**
 *  根据宽和高初始化对象
 *
 *  @param imageWidth  图片宽度
 *  @param imageHeight 图片高度
 *
 *  @return 返回初始化好的对象
 */
-(id) initWithImageWith:(int) imageWidth imageHeight:(int)imageHeight;

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
-(id) initWithImageWith:(int)imageWidth imageHeight:(int)imageHeight topImageWidth:(int) topImageWidth topImageHeight:(int) topImageHeight;

/**
 *  根据头条的宽个高初始化
 *
 *  @param topImageWidth  头条新闻图片的宽度
 *  @param topImageHeight 头条新闻图片的高度
 *
 *  @return 返回初始化好的对象
 */
-(id) initWithTopImageWidth:(int) topImageWidth topImageHeight:(int) topImageHeight;


+ (NSURL *) ordinaryFixedURLFromWidth:(NSString *)picUrl picWidth:(NSInteger)width picHeight:(NSInteger) height;

@end
