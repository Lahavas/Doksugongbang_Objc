//
//  AladinAPI.m
//  Doksugongbang
//
//  Created by USER on 2018. 1. 2..
//  Copyright © 2018년 USER. All rights reserved.
//

#import "AladinAPI.h"

#import "AladinConfig.h"

@implementation AladinAPI

#pragma mark - Class Methods

+ (NSURL *)aladinApiURLWithMethod:(NSString *)method parameters:(NSDictionary<NSString *, NSString *> *)additionalParameters {
    
    // Using urlComponent for generate URL
    
    NSMutableString *urlString = [[AladinConfig aladinBaseURLString] mutableCopy];
    [urlString appendString:method];
    
    NSURLComponents *urlComponent = [NSURLComponents componentsWithString:urlString];
    
    NSMutableArray<NSURLQueryItem *> *queryItems = [[NSMutableArray alloc] init];
    
    NSDictionary<NSString *, NSString *> *baseParameters = @{@"ttbKey": [AladinConfig ttbKey],
                                                             @"output": @"js",
                                                             @"Version": [AladinConfig aladinVersion],
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
    
    [urlComponent setQueryItems:queryItems];
    NSURL *url = urlComponent.URL;
    
    return url;
}

@end
