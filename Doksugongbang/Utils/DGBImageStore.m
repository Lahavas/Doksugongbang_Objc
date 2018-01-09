//
//  DGBImageStore.m
//  Doksugongbang
//
//  Created by USER on 2018. 1. 8..
//  Copyright © 2018년 USER. All rights reserved.
//

#import "DGBImageStore.h"

@interface DGBImageStore ()

#pragma mark - Private Properties

@property (strong, nonatomic) NSCache<NSString *, UIImage *> *imageCache;

@end

#pragma mark -

@implementation DGBImageStore

#pragma mark - Singleton Methods

+ (instancetype)sharedInstance {
    static DGBImageStore *imageStore = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        imageStore = [[DGBImageStore alloc] initWithPrivate];
    });
    return imageStore;
}

#pragma mark - Initialization

- (instancetype)init {
    @throw [NSException exceptionWithName:@"Singleton"
                                   reason:@"Use [DGBImageStore sharedInstance]"
                                 userInfo:nil];
    
    return nil;
}

- (instancetype)initWithPrivate {
    self = [super init];
    
    if (self) {
        _imageCache = [[NSCache alloc] init];
    }
    
    return self;
}

#pragma mark - Image Methods

- (void)setImage:(UIImage *)image forKey:(NSString *)key {
    [self.imageCache setObject:image
                        forKey:key];
}

- (UIImage *)imageForKey:(NSString *)key {
    return [self.imageCache objectForKey:key];
}

- (void)deleteImageForKey:(NSString *)key {
    if (!key) {
        return;
    }
    
    [self.imageCache removeObjectForKey:key];
}

@end
