//
//  NSString+DGBHTMLEncoder.h
//  Doksugongbang
//
//  Created by USER on 2018. 1. 9..
//  Copyright © 2018년 USER. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString (DGBHTMLEncoder)

#pragma mark - Class Methods

+ (NSString *)stringWithHTMLEncodedString:(NSString *)htmlEncodedString;

@end
