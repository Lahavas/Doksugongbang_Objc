//
//  DGBBook.m
//  Doksugongbang
//
//  Created by USER on 2018. 1. 2..
//  Copyright © 2018년 USER. All rights reserved.
//

#import "DGBBook.h"

@implementation DGBBook

#pragma mark - Description

- (NSString *)description {
    NSMutableString *descriptionString = [[super description] mutableCopy];
    
    [descriptionString appendFormat:@"\nBook Title : %@", _title];
    [descriptionString appendFormat:@"\nAuthor : %@", _author];
    [descriptionString appendFormat:@"\nPublisher : %@", _publisher];
    [descriptionString appendFormat:@"\nPublishing Date : %@", _pubDate];
    [descriptionString appendFormat:@"\nISBN : %@", _isbn];
    [descriptionString appendFormat:@"\nBook Page : %ld", _page];
    [descriptionString appendFormat:@"\nCategory : %@", _category];
    [descriptionString appendFormat:@"\nDescription : %@", _bookDescription];
    [descriptionString appendFormat:@"\nLink URL : %@", _linkURL];
    [descriptionString appendFormat:@"\nCover URL : %@", _coverURL];
    
    return descriptionString;
}

#pragma mark - Initialization

- (instancetype)init {
    return [self initWithJSON:nil];
}

- (instancetype)initWithJSON:(NSDictionary *)json {
    self = [super init];
    
    if (self) {
        static NSDateFormatter *dateFormatter = nil;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        });
        
        NSDictionary *subInfo = json[@"subInfo"];
        NSString *pubDateString = json[@"pubDate"];
        
        _isbn = json[@"isbn"];
        
        _title = json[@"title"];
        _author = json[@"author"];
        _publisher = json[@"publisher"];
        _pubDate = [dateFormatter dateFromString:pubDateString];
        
        _page = [subInfo[@"itemPage"] unsignedIntegerValue];
        _category = json[@"categoryName"];
        _bookDescription = json[@"description"];
        
        _linkURL = json[@"link"];
        _coverURL = json[@"cover"];
    }
    
    return self;
}

@end
