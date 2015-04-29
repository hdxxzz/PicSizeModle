//
//  DiguUtils.h
//  digu_Iphone
//
//  Created by Riley on 11-11-11.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef struct Padding_ {
    CGFloat padding_top;
    CGFloat padding_bottom;
    CGFloat padding_left;
    CGFloat padding_right;
} Padding;


typedef enum : NSUInteger
{
    DeviceVesionTypeIphone1G,
    DeviceVesionTypeIphone3G,
    DeviceVesionTypeIphone3GS,
    DeviceVesionTypeIphone4,
    DeviceVesionTypeIphone4s,
    DeviceVesionTypeIphone5,
    DeviceVesionTypeOhter
} DeviceVesionType;

@interface DiguUtils : NSObject

+ (UIColor *)ColorWithRGB:(int)colorValue;
+ (UIColor *)ColorWithString:(NSString *)s;
+ (NSString *)getStringSeperaByCommaWithStrArr:(NSArray *)stringArr
                                  withSperaStr:(NSString *)speraStr;
+ (NSString *)makeUlrParamStr:(NSDictionary *)parameDic;
+ (NSString *)makeUlrWithPartUrl:(NSString *)partUrl
                      parameDict:(NSDictionary *)parameDict;
+ (NSArray *)getUrlParameArrWithPartUrl:(NSString *)string;
+ (NSString*) stringFromCreatTime:(NSDate *)creatDate;
+ (NSString *)ordinaryURLWithThumbnailURL:(NSString *)thumbnailURL picWidth:(NSInteger)width;

+ (NSDictionary *)dictionaryWithURLParameterString:(NSString*)string;

+ (id)loadNibWithName:(NSString *)name owner:(id)owner viewIndex:(NSInteger)index;

// 获得原始图片
+ (NSString *)getOriginalPicURL:(NSString *)picUrl;

// 获得正方形
+ (NSString *)getSquarePicURL:(NSString *)picUrl picSquare:(NSInteger)square;


// 由/width/xxx 转为 /fixed/ xxx xxx/
+ (NSString *)ordinaryFixedURLFromWidth:(NSString *)picUrl picWidth:(NSInteger)width picHeight:(NSInteger) height;

/**
 *  根据原图获得图片    转为 /fixed/ xxx xxx/
 *
 *  @param originalPicURL   不到尺寸的原图
 *
 *  @return
 */
+ (NSString *)getFixedPicURLWithOriginalPicURL:(NSString *)originalPicURL picWidth:(NSInteger)width picHeight:(NSInteger) height;

/**
 * 做成表格
 * @param dataList 要处理的数据集
 * @param withColCount 列数
 * @ return 表格
 */
+ (NSMutableArray *) makeTable:(NSMutableArray *) dataList withColCount:(NSInteger) colCount;

/**
 * 获得机型
 */
+ (DeviceVesionType) getDviceVersion;

#pragma mark - headPic UIImageView 设置描边效果方法

/**
 统一设置头像描边效果 (主要用于没有继承UIbaseViewController的时候)
 */
+ (UIImageView *) setHeadPicLayerStroke:(UIImageView *) headImageView;

//获取整个应用通用的背景色
+ (UIColor *)getAppCommonBackgroundColor;


/**
 *  获得方正字体
 *
 *  @param size 大小
 *
 *  @return 字体
 */
+ (UIFont*) getFZWithSize:(CGFloat) size;

/**
 *  设置整个应用的单元格的分割线样式
 *
 *  @param cellSeparatorView 分割线
 *
 *  @return 原样设置好的返回分割线
 */
+ (UIView *) setCellSeparatorView:(UIView *) cellSeparatorView;

/**
 *  视图左，右上角画圆角
 *
 *  @param needDrectRoundedView 需要画圆角的视图
 *  @param roundSize            圆角的弧度大小
 *
 *  @return 返回画好圆角的视图
 */
+(UIView *) drectViewRoundedTop:(UIView *) needDrectRoundedView cornerRadii:(CGSize) roundSize;

/**
 *  视图左，右下角画圆角
 *
 *  @param needDrectRoundedView 需要画圆角的视图
 *  @param roundSize            圆角的弧度大小
 *
 *  @return 返回画好圆角的视图
 */
+(UIView *) drectViewRoundedBottom:(UIView *) needDrectRoundedView cornerRadii:(CGSize) roundSize;

/**
 *  个人设置红点
 *
 *  @param imageName  tab图片名称
 *  @param redDotRect 画红点的大小和位置
 *
 *  @return 返回添加了红点的图片
 */
+(UIImage *) tabBarBgImageAddRedDot:(NSString*)imageName redDotRect:(CGRect) redDotRect;

/**
 *  从一个视图生成图片
 *
 *  @param orgView 要生成图片的视图
 *
 *  @return 返回生成好的图片
 */
+(UIImage *) makeImageFromView:(UIView *) orgView;


@end
