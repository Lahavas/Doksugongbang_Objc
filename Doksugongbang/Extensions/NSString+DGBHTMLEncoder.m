//
//  NSString+DGBHTMLEncoder.m
//  Doksugongbang
//
//  Created by USER on 2018. 1. 9..
//  Copyright © 2018년 USER. All rights reserved.
//

#import "NSString+DGBHTMLEncoder.h"

@implementation NSString (DGBHTMLEncoder)

#pragma mark - Class Methods

+ (NSString *)stringWithHTMLEncodedString:(NSString *)htmlEncodedString {
    NSData *data = [htmlEncodedString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary<NSAttributedStringDocumentReadingOptionKey, id> *options = @{NSDocumentTypeDocumentOption: NSHTMLTextDocumentType,
                                                                              NSCharacterEncodingDocumentAttribute: @(NSUTF8StringEncoding)};
    
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:data
                                                                            options:options
                                                                 documentAttributes:nil
                                                                              error:nil];
    
    return attributedString.string;
}

@end
