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

static NSString * const AladinAPIItemSearchString = @"/ttb/api/ItemSearch.aspx";
static NSString * const AladinAPIItemListString = @"/ttb/api/ItemList.aspx";
static NSString * const AladinAPIItemLookUpString = @"/ttb/api/ItemLookUp.aspx";

#pragma mark - URL Generator Methods

+ (NSURL *)aladinAPIURLWithPathName:(AladinAPIPathName)pathName parameters:(NSDictionary<NSString *, NSString *> *)additionalParameters {
    NSString *aladinBaseURLString = AladinConfig.aladinBaseURLString;
    NSURLComponents *aladinAPIURLComponent = [NSURLComponents componentsWithString:aladinBaseURLString];
    
    NSMutableArray<NSURLQueryItem *> *queryItems = [[NSMutableArray alloc] init];
    
    NSDictionary<NSString *, NSString *> *baseParameters = @{@"ttbKey": AladinConfig.ttbKey,
                                                             @"output": AladinConfig.output,
                                                             @"Version": AladinConfig.aladinVersion};
    
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
    
    [aladinAPIURLComponent setPath:[self pathStringFromPathName:pathName]];
    [aladinAPIURLComponent setQueryItems:queryItems];
    NSURL *aladinAPIURL = aladinAPIURLComponent.URL;
    
    return aladinAPIURL;
}

#pragma mark - Book Parser Methods

+ (DGBBook *)bookParsingFromJSONData:(NSData *)data {
    NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                   options:0
                                                                     error:nil];
    NSArray *items = jsonDictionary[@"item"];
    NSDictionary *item = items[0];
    
    DGBBook *book = [[DGBBook alloc] initWithJSON:item];
    
    return book;
}

+ (NSArray<DGBBook *> *)bookListParsingFromJSONData:(NSData *)data {
    NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                   options:0
                                                                     error:nil];
    NSArray *items = jsonDictionary[@"item"];
    
    NSLog(@"%@", items);
    
    NSMutableArray<DGBBook *> *bookList = [[NSMutableArray alloc] init];
    
    [items enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSDictionary class]]) {
            DGBBook *book = [[DGBBook alloc] initWithJSON:obj];
            [bookList addObject:book];
        }
    }];
    
    return bookList;
}

#pragma mark - Private Class Methods

+ (NSString *)pathStringFromPathName:(AladinAPIPathName)pathName {
    NSString *pathString;
    
    switch (pathName) {
        case AladinAPIItemSearch:
            pathString = AladinAPIItemSearchString;
            break;
        case AladinAPIItemList:
            pathString = AladinAPIItemListString;
            break;
        case AladinAPIItemLookUp:
            pathString = AladinAPIItemLookUpString;
            break;
        default:
            pathString = [[NSString alloc] init];
            break;
    }
    
    return pathString;
}

@end
