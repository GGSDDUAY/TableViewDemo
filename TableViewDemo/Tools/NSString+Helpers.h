//
//  NSString+Helpers.h
//
//  Created by Bogdan Stasjuk on 4/16/14.
//
//

@interface NSString (Helpers)

+ (NSString *)trim:(NSString *)string;

+ (BOOL)isEmpty:(NSString *)string;
+ (BOOL)isUInteger:(NSString *)string;

- (BOOL)isMatchesRegExp:(NSString *)regExp;
- (CGSize)sizeWithFont:(UIFont *)font inScopeOfSize:(CGSize)constrainedSize lineBreakMode:(NSLineBreakMode )lineBreakMode;
- (id)jsonObject;

+ (NSString *)md5:(NSString *)string;

@end