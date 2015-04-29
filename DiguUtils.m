//
//  DiguUtils.m
//  digu_Iphone
//
//  Created by Riley on 11-11-11.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "DiguUtils.h"

@implementation DiguUtils

+ (UIColor *)ColorWithRGB:(int)colorValue
{
    int b = colorValue & 0xff;
    int g = (colorValue >> 8) & 0xff;
    int r = (colorValue >> 16) & 0xff;
    int a = (colorValue >> 24) & 0xff;
    return [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a/255.0f];
}

+ (UIColor *)ColorWithString:(NSString *)s 
{
//    LogDebug(@"Parse Color:%@", s);
    if (s == nil || [s isEqualToString:@""]) {
        return [UIColor clearColor];
    }
    uint temp;
    if ([s hasPrefix:@"#"]) {
        [[NSScanner scannerWithString:[s substringFromIndex:1]] scanHexInt:&temp];
        temp = temp | 0xff000000;
    }
    return [DiguUtils ColorWithRGB:temp];
}
+(NSString *)getStringSeperaByCommaWithStrArr:(NSArray *)stringArr
                                 withSperaStr:(NSString *)speraStr
{
	NSMutableString *varListString=[NSMutableString string];
	for (int i = 0; i < [stringArr count]; i++) {
		if (i!=0) {
			[varListString appendString:speraStr];
		}
		[varListString appendString:[stringArr objectAtIndex:i]];
	}
//	DLog(@"varListString:%@",varListString);
	return varListString;
}
+(NSString *)makeUlrParamStr:(NSDictionary *)parameDic
{
    if (parameDic == nil) {
        return  nil;
    }
    NSMutableArray *keyAndValueArr = [NSMutableArray array];
    
    NSArray *keyArr = [parameDic allKeys];
    for (NSString *key in keyArr) {
        NSString *value = [parameDic objectForKey:key];
        NSArray *keyAndValue = [NSArray arrayWithObjects:key,value, nil];
        NSString *keyAndValueStr = [DiguUtils getStringSeperaByCommaWithStrArr:keyAndValue withSperaStr:@"="];
        [keyAndValueArr addObject:keyAndValueStr];
        
    }
    NSString *outStr = [DiguUtils getStringSeperaByCommaWithStrArr:keyAndValueArr withSperaStr:@"&"];
//    DLog(@"outStr : %@", outStr);
    return outStr;
}

+(NSString *)makeUlrWithPartUrl:(NSString *)partUrl
                     parameDict:(NSDictionary *)parameDict
{
    if (partUrl == nil) {
        return nil;
    }
    NSString *parameStr = [DiguUtils  makeUlrParamStr:parameDict];
    if (parameStr == nil) {
        return partUrl;
    }
    NSString *url = [NSString stringWithFormat:@"%@?%@",partUrl,parameStr];
//    DLog(@"url : %@", url);
    return url;
}
#pragma url参数解析器
+(NSDictionary *)getVauleByKeyValueString:(NSString *)keyValueString
{
    if (keyValueString == nil) {
        return nil;
    }
    NSArray *arr = [keyValueString componentsSeparatedByString:@"="];
    NSString *key = [arr objectAtIndex:0];
    NSString *value = [arr objectAtIndex:1];
    return [NSDictionary dictionaryWithObject:value forKey:key];
}

+(NSArray *)getUrlParameArrWithPartUrl:(NSString *)string
{
    if (string == nil) {
        return nil;
    }
    NSMutableArray *parameArr = [NSMutableArray array];
    NSArray *arr = [string componentsSeparatedByString:@"&"];
    for (NSString *keyValueStirng in arr) {
        [parameArr addObject:[DiguUtils getVauleByKeyValueString:keyValueStirng]];
    }
    return parameArr;
}

+ (NSString*) stringFromCreatTime:(NSDate *)creatDate
{
    
    NSCalendar *chineseCalendar = [[[NSCalendar alloc] initWithCalendarIdentifier:NSChineseCalendar] autorelease];
    NSDate *nowDate = [NSDate date];
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit |NSSecondCalendarUnit;
    NSDateComponents *dateComponents = [chineseCalendar components:unitFlags fromDate:creatDate toDate:nowDate options:NSWrapCalendarComponents];
    int year = dateComponents.year;
    int month = dateComponents.month;
    int day = dateComponents.day;
    int hour = dateComponents.hour;
    int minute = dateComponents.minute;
    int second = dateComponents.second;
    if (year != 0) {
        NSString* creatTime = [[NSString alloc] initWithFormat:@"%d年前",year];
        return [creatTime autorelease];
    }
    if (month != 0) {
        NSString* creatTime = [[NSString alloc] initWithFormat:@"%d月前",month];
        return [creatTime autorelease];
    }
    if (day != 0) {
        NSString* creatTime = [[NSString alloc] initWithFormat:@"%d天前",day];
        return [creatTime autorelease];
    }
    NSMutableString *tmpTimeStr = [[NSMutableString alloc] init];
    if (hour != 0) {
        [tmpTimeStr appendFormat:@"%d小时前",hour];
        return [tmpTimeStr autorelease];
    }
    if (minute != 0) {
        [tmpTimeStr appendFormat:@"%d分钟前",minute];
        return [tmpTimeStr autorelease];
    }
    if (second != 0 && hour == 0) {
        [tmpTimeStr appendFormat:@"%d秒前",second];
        return [tmpTimeStr autorelease];
    }
#pragma mark - mouwenbin
    return [tmpTimeStr autorelease];
}

+ (NSString *)ordinaryURLWithThumbnailURL:(NSString *)thumbnailURL picWidth:(NSInteger)width
{
    if (!thumbnailURL) {
        return nil;
    }
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\/[a-z]*\/[0-9]*\/" options:0 error:&error];
    NSString *result = [regex stringByReplacingMatchesInString:thumbnailURL options:0 range:NSMakeRange(0, thumbnailURL.length) withTemplate:[NSString stringWithFormat:@"/width/%d/", width]];
    NSRange theRange =[@"fixed" rangeOfString:thumbnailURL];
    if (theRange.location > 0 ) {
        regex = [NSRegularExpression regularExpressionWithPattern:@"\/fixed\/[0-9]*x[0-9]*\/" options:0 error:&error];
        result = [regex stringByReplacingMatchesInString:result options:0 range:NSMakeRange(0, result.length) withTemplate:[NSString stringWithFormat:@"/width/%d/", width]];
    }
    return result;
}
+ (NSDictionary *)dictionaryWithURLParameterString:(NSString*)string
{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    NSArray *keyValues = [string componentsSeparatedByString:@"&"];
    for (NSString *keyValue in keyValues) {
        NSArray *keys = [keyValue componentsSeparatedByString:@"="];
        if (keys.count >1) {
            [para setObject:[keys objectAtIndex:1] forKey:[keys objectAtIndex:0]];
        }
    }
    return para;
}

+ (NSString *)getOriginalPicURL:(NSString *)picUrl
{
    if (!picUrl) {
        return nil;
    }
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\/[a-z]*\/[0-9]*\/" options:0 error:&error];
    NSString *result = [regex stringByReplacingMatchesInString:picUrl options:0 range:NSMakeRange(0, picUrl.length) withTemplate:@"/"];
    NSRange theRange =[@"fixed" rangeOfString:result];
    if (theRange.location > 0 ) {
        regex = [NSRegularExpression regularExpressionWithPattern:@"\/fixed\/[0-9]*x[0-9]*\/" options:0 error:&error];
        result = [regex stringByReplacingMatchesInString:result options:0 range:NSMakeRange(0, result.length) withTemplate:@"/"];
    }
    
    return result;
}

+ (NSString *)getSquarePicURL:(NSString *)picUrl picSquare:(NSInteger)square
{
    if (!picUrl) {
        return nil;
    }
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\/[a-z]*\/[0-9]*\/" options:0 error:&error];
    
    NSString *result = [regex stringByReplacingMatchesInString:picUrl options:0 range:NSMakeRange(0, picUrl.length) withTemplate:[NSString stringWithFormat:@"/square/%d/", square]];
    NSRange theRange =[@"fixed" rangeOfString:picUrl];
    if (theRange.location > 0 ) {
        regex = [NSRegularExpression regularExpressionWithPattern:@"\/fixed\/[0-9]*x[0-9]*\/" options:0 error:&error];
        result = [regex stringByReplacingMatchesInString:result options:0 range:NSMakeRange(0, result.length) withTemplate:[NSString stringWithFormat:@"/square/%d/",square]];
    }

    return result;
}


+ (NSString *)ordinaryFixedURLFromWidth:(NSString *)picUrl picWidth:(NSInteger)width picHeight:(NSInteger) height
{
    if (!picUrl) {
        return nil;
    }
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\/[a-z]*\/[0-9]*\/" options:0 error:&error];
    NSString *result = [regex stringByReplacingMatchesInString:picUrl options:0 range:NSMakeRange(0, picUrl.length) withTemplate:[NSString stringWithFormat:@"/fixed/%dx%d/", width,height]];
    
    NSRange theRange =[@"fixed" rangeOfString:result];
    if (theRange.location > 0 ) {
        regex = [NSRegularExpression regularExpressionWithPattern:@"\/fixed\/[0-9]*x[0-9]*\/" options:0 error:&error];
        result = [regex stringByReplacingMatchesInString:result options:0 range:NSMakeRange(0, result.length) withTemplate:[NSString stringWithFormat:@"/fixed/%dx%d/", width,height]];
    }
    return result;
}

/**
 *  根据原图获得图片    转为 /fixed/ xxx xxx/
 *
 *  @param originalPicURL   不到尺寸的原图
 *
 *  @return
 */
+ (NSString *)getFixedPicURLWithOriginalPicURL:(NSString *)originalPicURL picWidth:(NSInteger)width picHeight:(NSInteger) height
{
    NSString *fixedResult = @"";
    if (originalPicURL && [originalPicURL length] > 0) {
        originalPicURL = [DiguUtils getOriginalPicURL:originalPicURL];
        NSRange range = [originalPicURL rangeOfString:@"/" options:NSBackwardsSearch];
        NSString *replaceString = [NSString stringWithFormat:@"/fixed/%dx%d/", width,height];
        if (range.location != NSNotFound) {
            fixedResult = [originalPicURL stringByReplacingCharactersInRange:range withString:replaceString];
        }
    }

    return fixedResult;
}

/**
 * 做成表格
 * @param dataList 要处理的数据集
 * @param withColCount 列数
 * @ return 表格
 */
+ (NSMutableArray *) makeTable:(NSMutableArray *) dataList withColCount:(NSInteger) colCount
{
    NSMutableArray *rows = [NSMutableArray array];
    
    if (dataList != nil && [dataList count]>0) {
        NSMutableArray * cols = nil;
        int len = [dataList count];
        for (int i = 1 ; i <= len ; i++) {
            if (cols == nil) {
                cols = [NSMutableArray array ];
            }
            [cols addObject:[dataList objectAtIndex:i-1]];
            if (i%colCount != 0 &&  i==len) {
                [rows addObject:cols];
            } else if(i%colCount == 0 ) {
                [rows addObject:cols];
                if (i != 1) {
                    cols = nil;
                }
            }
        }
    }
    
    return rows;
}

/**
 * 获得机型
 */
//<<<<<<< HEAD
//+ (DeviceVesionType) getDviceVersion
//{
//    size_t size;
//    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
//=======
//<<<<<<< HEAD
//+ (DeviceVesionType) getDviceVersion
//{
//=======
//+ (DeviceVesionType) getDviceVersion
//{
//>>>>>>> a7edec12f7495e0fdeb6ee2f204b4a8995aaf5db
//    size_t size;sysctlbyname("hw.machine", NULL, &size, NULL, 0);
//>>>>>>> 2b56f7fddb9dcd287062e7a54937774a6ef8d983
//    char *name = malloc(size);
//    sysctlbyname("hw.machine", name, &size, NULL, 0);
//    
//    NSString *machine = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
//    
//    free(name);
//<<<<<<< HEAD
//<<<<<<< HEAD
//    DeviceVesionType type  = DeviceVesionTypeOhter; 
//=======
//    DeviceVesionType type  = DeviceVesionTypeOhter;
//=======
//    DeviceVesionType type  = DeviceVesionTypeOhter;
//=======
//    DeviceVesionType type  = DeviceVesionTypeOhter;
//>>>>>>> a7edec12f7495e0fdeb6ee2f204b4a8995aaf5db
//>>>>>>> 2b56f7fddb9dcd287062e7a54937774a6ef8d983
//    if( [machine isEqualToString:@"i386"] || [machine isEqualToString:@"x86_64"] )
//    {
//        machine = @"ios_Simulator";
//    } else if( [machine isEqualToString:@"iPhone1,1"] ){
//        type = DeviceVesionTypeIphone1G; 
//    }else if( [machine isEqualToString:@"iPhone1,2"] ){
//        type = DeviceVesionTypeIphone3G; 
//    }else if( [machine isEqualToString:@"iPhone2,1"] ){
//        type = DeviceVesionTypeIphone3GS; 
//    } else if( [machine isEqualToString:@"iPhone3,1"] ){
//        type = DeviceVesionTypeIphone4; 
//    }else if( [machine isEqualToString:@"iPhone5,2"] ){
//        type = DeviceVesionTypeIphone5;
//    }else if( [machine isEqualToString:@"iPod1,1"] ) {
//        type  = DeviceVesionTypeOhter; 
//    }else if( [machine isEqualToString:@"iPod2,1"] ){
//        type  = DeviceVesionTypeOhter; 
//    }else if( [machine isEqualToString:@"iPod3,1"] ) {
//        type  = DeviceVesionTypeOhter; 
//    }
//    else if( [machine isEqualToString:@"iPod4,1"] ) {
//         type  = DeviceVesionTypeOhter; 
//    }
//    else if( [machine isEqualToString:@"iPad1,1"] ) {
//        type  = DeviceVesionTypeOhter; 
//    }
//    else if( [machine isEqualToString:@"iPad2,1"] ) {
//       type  = DeviceVesionTypeOhter; 
//    }
//    
//<<<<<<< HEAD
//<<<<<<< HEAD
//    return type;
//}
//=======
//    return type;
//}
//=======
////    return type;
////}
//=======
//    return type;
//}
//>>>>>>> a7edec12f7495e0fdeb6ee2f204b4a8995aaf5db
//>>>>>>> 2b56f7fddb9dcd287062e7a54937774a6ef8d983

#pragma mark - headPic UIImageView 设置描边效果方法

/**
    统一设置头像描边效果
 */
+(UIImageView *) setHeadPicLayerStroke:(UIImageView *) headImageView
{
    CALayer *layer=[headImageView layer];
    //是否设置边框以及是否可见
    [layer setMasksToBounds:YES];
    //设置边框线的宽
    [layer setBorderWidth:1];
    // 设置边框线的颜色
    [layer setBorderColor:[[DiguUtils ColorWithString:@"#BBBBBBB"] CGColor]];
    
    return headImageView;
}
#pragma mark -- 统一获得整个应用的背景颜色

//获取整个应用通用的背景色
+ (UIColor *)getAppCommonBackgroundColor
{
    UIImage *image = [UIImage imageNamed:@"contact_bg.png"];
    UIColor *backgroundColor = [UIColor colorWithPatternImage:image];
    return backgroundColor;
}

/**
 *  获得方正字体
 *
 *  @param size 大小
 *
 *  @return 字体
 */
+ (UIFont*) getFZWithSize:(CGFloat) size
{
    return [UIFont fontWithName:@"FZLTZHK--GBK1-0" size:size];
}

/**
 *  设置整个应用的单元格的分割线样式
 *
 *  @param cellSeparatorView 分割线
 *
 *  @return 原样设置好的返回分割线
 */
+ (UIView *) setCellSeparatorView:(UIView *) cellSeparatorView
{
    if (cellSeparatorView) {
        cellSeparatorView.backgroundColor = [UIColor grayColor];
        CGRect separatorFrame = cellSeparatorView.frame;
        CGSize separatorSize = separatorFrame.size;
        separatorSize.height = 1;
        separatorFrame.size = separatorSize;
        cellSeparatorView.frame = separatorFrame;
    }
    return cellSeparatorView;
}

/**
 *  视图左，右上角画圆角
 *
 *  @param needDrectRoundedView 需要画圆角的视图
 *  @param roundSize            圆角的弧度大小
 *
 *  @return 返回画好圆角的视图
 */
+(UIView *) drectViewRoundedTop:(UIView *) needDrectRoundedView cornerRadii:(CGSize) roundSize
{
    if (needDrectRoundedView) {
        CAShapeLayer *styleLayer = [[CAShapeLayer alloc]init];
        UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRoundedRect:needDrectRoundedView.bounds byRoundingCorners:(UIRectCornerTopLeft|UIRectCornerTopRight) cornerRadii:roundSize];
        styleLayer.path = shadowPath.CGPath;
        
        needDrectRoundedView.layer.mask = styleLayer;
    }
    return needDrectRoundedView;
}

/**
 *  视图左，右下角画圆角
 *
 *  @param needDrectRoundedView 需要画圆角的视图
 *  @param roundSize            圆角的弧度大小
 *
 *  @return 返回画好圆角的视图
 */
+(UIView *) drectViewRoundedBottom:(UIView *) needDrectRoundedView cornerRadii:(CGSize) roundSize
{
    if (needDrectRoundedView) {
        CAShapeLayer *styleLayer = [[CAShapeLayer alloc]init];
        UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRoundedRect:needDrectRoundedView.bounds byRoundingCorners:(UIRectCornerBottomLeft|UIRectCornerBottomRight) cornerRadii:roundSize];
        styleLayer.path = shadowPath.CGPath;
        
        needDrectRoundedView.layer.mask = styleLayer;
    }
    return needDrectRoundedView;
}

/**
 *  个人设置红点
 *
 *  @param imageName  tab图片名称
 *  @param redDotRect 画红点的大小和位置
 *
 *  @return 返回添加了红点的图片
 */
+(UIImage *) tabBarBgImageAddRedDot:(NSString*)imageName redDotRect:(CGRect) redDotRect
{
    
    UIImage* originalImage = [UIImage imageNamed:imageName];
    
    // Tab图标的大小
    CGRect rect = CGRectMake(0, 0, 28, 28);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 原始图片的大小
    [originalImage drawInRect:CGRectMake(0, 0, 28, 28)];
    
    // 红点的位置和大小
    CGRect borderRect = CGRectMake(21.0, 0.0, 8.0, 8.0);
    
    CGContextSetRGBStrokeColor(context, 1.0, 1.0, 1.0, 1.0);
    
    CGContextSetFillColorWithColor(context,[UIColor redColor].CGColor);
    CGContextSetLineWidth(context, 1.0);
    CGContextFillEllipseInRect (context, borderRect);
    
    // 画白边的线
    //    CGContextStrokeEllipseInRect(context, borderRect);
    
    CGContextFillPath(context);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return theImage;
}

/**
 *  从一个视图生成图片
 *
 *  @param orgView 要生成图片的视图
 *
 *  @return 返回生成好的图片
 */
+(UIImage *) makeImageFromView:(UIView *) orgView
{
    UIGraphicsBeginImageContextWithOptions(orgView.bounds.size, YES, [[UIScreen mainScreen] scale]);
    [orgView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return image;
}


@end
