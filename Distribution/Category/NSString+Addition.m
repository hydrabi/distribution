//
//  NSString+Addition.m
//  Distribution
//
//  Created by Hydra on 15/12/18.
//  Copyright © 2015年 毕志锋. All rights reserved.
//

#import "NSString+Addition.h"

#import <CommonCrypto/CommonDigest.h>


@implementation NSString(Addition)


+ (BOOL)isEmpty:(NSString *)string{
    if (string) {
        if (string.length >0) {
            return NO;
        }
    }
    return  YES;
}


- (BOOL)isStringOnlyContainCharacters:(NSString *)characters{
    NSCharacterSet *cs = [NSCharacterSet characterSetWithCharactersInString:characters];
    NSCharacterSet *allowedCharacters = [cs invertedSet];
    return ([self rangeOfCharacterFromSet:allowedCharacters].location == NSNotFound);
}

- (NSString *)trimWithoutCharacters:(NSString *)characters{
    NSCharacterSet *cs = [NSCharacterSet characterSetWithCharactersInString:characters];
    NSCharacterSet *allowedCharacters = [cs invertedSet];
    return [self stringByTrimmingCharactersInSet:allowedCharacters];
}


- (NSString *)stringByReplacingCharacterSet:(NSCharacterSet *)characters{
    return [[self componentsSeparatedByCharactersInSet:characters] componentsJoinedByString:@""];
}

- (NSString *)md5 {
    // Create pointer to the string as UTF8
    const char *ptr = [self UTF8String];
    
    // Create byte array of unsigned chars
    unsigned char md5Buffer[CC_MD5_DIGEST_LENGTH];
    
    // Create 16 bytes MD5 hash value, store in buffer
    CC_MD5(ptr, (CC_LONG)strlen(ptr), md5Buffer);
    
    // Convert unsigned char buffer to NSString of hex values
    NSMutableString *output =
    [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", md5Buffer[i]];
    
    return [output uppercaseString];
    
}

+(NSString*)transformDateToString:(NSDate*)date{
    NSString *result = @"";
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitYear;
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    NSDateComponents *transformCmps = [calendar components:unit fromDate:date];
    NSDateFormatter *formatt=[[NSDateFormatter alloc] init];
    
    //小于一天
    if(nowCmps.year==transformCmps.year && nowCmps.month==transformCmps.month && nowCmps.day==transformCmps.day){
        [formatt setDateFormat:@"HH:mm"];
    }
    //小于一年
    else if (nowCmps.year==transformCmps.year){
        [formatt setDateFormat:@"MM/dd"];
    }
    //大于一年
    else{
        [formatt setDateFormat:@"yyyy-MM"];
    }
    result = [formatt stringFromDate:date];
    return result;
}

-(CGSize)stringSizeWithLableHeight:(CGFloat)height width:(CGFloat)width font:(UIFont*)fontSize{
    
    CGSize textSize=CGSizeZero;
    if(self.length==0)
    {
        return textSize;
    }
    NSMutableAttributedString *attStr=[[NSMutableAttributedString alloc]initWithString:self];
    [attStr addAttribute:NSFontAttributeName value:fontSize range:NSMakeRange(0, attStr.length)];
    NSRange range=NSMakeRange(0, attStr.length);
    NSDictionary *dic=[attStr attributesAtIndex:0 effectiveRange:&range];
    textSize=[self boundingRectWithSize:CGSizeMake(width, height) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:dic context:nil].size;
    return textSize;
}

-(BOOL)validateMobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^(0|86|17951)?(13[0-9]|15[012356789]|18[0-9]|14[57])[0-9]{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:self];
}

@end
