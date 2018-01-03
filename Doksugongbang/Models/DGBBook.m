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
    [descriptionString appendFormat:@"\nPubdate : %@", _pubdate];
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
    return [self initFromJSON:nil];
}

- (instancetype)initFromJSON:(NSDictionary<NSString *, id> *)json {
    self = [super init];
    
    if (self) {
        NSDictionary *subInfo = json[@"subInfo"];
        
        _isbn = json[@"isbn13"];
        
        _title = json[@"title"];
        _author = json[@"author"];
        _publisher = json[@"publisher"];
        _pubdate = json[@"pubdate"];
        
        _page = [subInfo[@"itemPage"] unsignedIntegerValue];
        _category = json[@"categoryName"];
        _bookDescription = json[@"description"];
        
        _linkURL = json[@"link"];
        _coverURL = json[@"cover"];
    }
    
    return self;
}

@end
