//
//  UIColor+Extend.m
//  NashWorkApp
//
//  Created by 郭榜 on 2017/8/30.
//  Copyright © 2017年 com.Mad_bg.init. All rights reserved.
//

#import "UIColor+Extend.h"
#define DEFAULT_VOID_COLOR [UIColor whiteColor]

@implementation UIColor (Extend)
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    
    if ([cString length] < 6)
        return DEFAULT_VOID_COLOR;
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return DEFAULT_VOID_COLOR;
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}
+(UIColor *)getColorFromHexStr:(NSString *)hexColorStr
{
    
    //    UIColor *tarColor = [UIColor purpleColor];
    UIColor *tarColor = UIColorFromRGB(0x6cccf9);
    
    NSString *colorStr = hexColorStr;
    if (hexColorStr) {
        //处理字符串
        NSRange tagRange = [hexColorStr rangeOfString:@"#"];
        if (tagRange.location!=NSNotFound) {
            if (hexColorStr.length>tagRange.location+1) {
                colorStr = [hexColorStr substringFromIndex:tagRange.location+1];
            }
            
            NSUInteger colorValue = strtoul([colorStr UTF8String], 0, 16);
            tarColor = UIColorFromRGB(colorValue);
        }
    }
    
    
    return tarColor;
}

@end
