//
//  AladinAPI.m
//  Doksugongbang
//
//  Created by USER on 2018. 1. 2..
//  Copyright © 2018년 USER. All rights reserved.
//

#import "AladinAPI.h"
#import "AladinConfig.h"
#import "DGBBook.h"

@implementation AladinAPI

#pragma mark - Class Methods

+ (NSURL *)aladinApiURLWithPath:(NSString *)path parameters:(NSDictionary<NSString *, NSString *> *)additionalParameters {
    NSString *urlBaseString = AladinConfig.aladinBaseURLString;
    NSURLComponents *urlComponent = [NSURLComponents componentsWithString:urlBaseString];
    
    NSMutableArray<NSURLQueryItem *> *queryItems = [[NSMutableArray alloc] init];
    
    NSDictionary<NSString *, NSString *> *baseParameters = @{@"ttbKey": AladinConfig.ttbKey,
                                                             @"output": @"js",
                                                             @"Version": AladinConfig.aladinVersion,
                                                             @"Cover": @"Big"};
    
    [baseParameters enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSString * _Nonnull obj, BOOL * _Nonnull stop) {
        NSURLQueryItem *queryItem = [NSURLQueryItem queryItemWithName:key
                                                                value:obj];
        
        [queryItems addObject:queryItem];
    }];
    
    if (additionalParameters) {
        [additionalParameters enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSString * _Nonnull obj, BOOL * _Nonnull stop) {
            NSURLQueryItem *queryItem = [NSURLQueryItem queryItemWithName:key
                                                                    value:obj];
            
            [queryItems addObject:queryItem];
        }];
    }
    
    [urlComponent setPath:path];
    [urlComponent setQueryItems:queryItems];
    NSURL *url = urlComponent.URL;
    
    return url;
}

+ (DGBBook *)bookParsingFromJSONData:(NSData *)data {
    NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                   options:0
                                                                     error:nil];
    NSArray *items = jsonDictionary[@"item"];
    NSDictionary *item = items[0];
    
    DGBBook *book = [[DGBBook alloc] initFromJSON:item];
    
    return book;
}

+ (NSArray<DGBBook *> *)bookListParsingFromJSONData:(NSData *)data {
    NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                   options:0
                                                                     error:nil];
    NSArray *items = jsonDictionary[@"item"];
    
    NSMutableArray<DGBBook *> *bookList = [[NSMutableArray alloc] init];
    
    [items enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSDictionary class]]) {
            DGBBook *book = [[DGBBook alloc] initFromJSON:obj];
            [bookList addObject:book];
        }
    }];
    
    return bookList;
}

@end
