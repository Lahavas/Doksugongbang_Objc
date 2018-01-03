//
//  AladinAPI.h
//  Doksugongbang
//
//  Created by USER on 2018. 1. 2..
//  Copyright © 2018년 USER. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DGBBook;

typedef NS_ENUM(NSUInteger, AladinApiPathName) {
    AladinApiItemSearch = 0,
    AladinApiItemList = 1,
    AladinApiItemLookUp = 2
};

@interface AladinAPI : NSObject

#pragma mark - URL Generator Methods

+ (NSURL *)aladinApiURLWithPathName:(AladinApiPathName)pathName parameters:(NSDictionary<NSString *, NSString *> *)additionalParameters;

#pragma mark - Book Parser Methods

+ (DGBBook *)bookParsingFromJSONData:(NSData *)data;
+ (NSArray<DGBBook *> *)bookListParsingFromJSONData:(NSData *)data;

@end
