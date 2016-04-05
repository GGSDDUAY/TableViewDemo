//
//  NSString+Helpers.m
//
//  Created by Bogdan Stasjuk on 4/16/14.
//
//

#import "NSString+Helpers.h"
#import <CommonCrypto/CommonDigest.h>

#define ALog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)


@implementation NSString (Helpers)

#pragma mark - Public methods

#pragma mark -Static

+ (BOOL)isEmpty:(NSString *)string
{
    return (!string || ![self trim:string].length);
}

+ (NSString *)trim:(NSString *)string
{
    return [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

+ (BOOL)isUInteger:(NSString *)string
{
    if ([self isEmpty:string])
        return NO;
    string = [self trim:string];
    return [string isMatchesRegExp:@"^\\d+$"];
}

#pragma mark -Nonstatic

- (BOOL)isMatchesRegExp:(NSString *)regExp
{
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regExp
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    if (error) {
        ALog("Error: %@", error);
        return NO;
    }
    
    NSUInteger numberOfMatches = [regex numberOfMatchesInString:self
                                                        options:0
                                                          range:NSMakeRange(0, self.length)];
    return numberOfMatches;
}

- (CGSize)sizeWithFont:(UIFont *)font inScopeOfSize:(CGSize)constrainedSize lineBreakMode:(NSLineBreakMode )lineBreakMode
{
    CGSize size = CGSizeZero;
    UIFont *measuringFont = [UIFont fontWithName:font.fontName size:font.pointSize ];
    if ([[[UIDevice currentDevice] systemVersion] compare:@"7.0" options:NSNumericSearch] == NSOrderedAscending) {
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
        size = [self sizeWithFont:measuringFont
                constrainedToSize:constrainedSize
                    lineBreakMode:NSLineBreakByWordWrapping];
#pragma GCC diagnostic pop
    } else {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
            paragraphStyle.lineBreakMode = lineBreakMode;
        NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy};
        
        size = [self boundingRectWithSize:constrainedSize
                                  options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                               attributes:attributes
                                  context:nil].size;
    }
    return CGSizeMake(ceilf(size.width) , ceilf(size.height));
}

- (id)jsonObject
{
    id object = nil;
    if (self && ![self isEqualToString:@" "]) {
        NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
        if (data) {
            if ([data length] > 0)
            {
                object = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            }
        }
    }
    return object;
}

+ (NSString *)md5:(NSString *)string
{
    const char *cStr = [string UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (unsigned int)strlen(cStr), digest );
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02X", digest[i]];
    
    return output;
}

@end