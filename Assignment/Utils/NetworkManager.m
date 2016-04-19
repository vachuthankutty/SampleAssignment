//
//  NetworkManager.m
//  Assignment
//
//  Created by Admin on 19/04/16.
//  Copyright © 2016 Infosys. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkManager.h"

#define MB * 1024 * 1024

@implementation NetworkManager

- (id)init {
    if (self = [super init]) {
        _downloadPhotoTask = nil;
       [self setSharedCacheForImages];
    }
    return self;
}

//Utility method that will fetch the image in non blocking mode once the URL is provided.
- (void)fetchImageWithURLString:(NSString *)urlString completionHandler:( void (^)(UIImage *))completionBlock {
    //Start in background queue so as to ensure the fetching takes place without blocking UI
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    NSURL *photoURL = [[NSURL alloc] initWithString:urlString];
    self.downloadPhotoTask = [[NSURLSession sharedSession]
                              downloadTaskWithURL:photoURL completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
                                  
                                  [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                                  UIImage *downloadedImage = [UIImage imageWithData:
                                                              [NSData dataWithContentsOfURL:location]];
                                  dispatch_async(dispatch_get_main_queue(), ^{
                                      completionBlock(downloadedImage);
                                  });
                                  
                              }];
    
    [self.downloadPhotoTask resume];});
}

//Set a custom cache with higher size
- (void)setSharedCacheForImages
{
    NSUInteger cashSize = 250 MB;
    NSUInteger cashDiskSize = 250 MB;
    NSURLCache *imageCache = [[NSURLCache alloc] initWithMemoryCapacity:cashSize diskCapacity:cashDiskSize diskPath:@"someCachePath"];
    [NSURLCache setSharedURLCache:imageCache];
}

//Cancel already resumed service
- (void)cancelDataTask {
    [self.downloadPhotoTask cancel];
}

@end