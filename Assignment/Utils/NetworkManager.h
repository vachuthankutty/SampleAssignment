//
//  NetworkManager.h
//  Assignment
//
//  Created by Admin on 19/04/16.
//  Copyright © 2016 Infosys. All rights reserved.
//

#ifndef NetworkManager_h
#define NetworkManager_h
#import <UIKit/UIKit.h>

@interface NetworkManager : NSObject

@property(nonatomic, weak) NSURLSessionDownloadTask *downloadPhotoTask;

- (void)fetchImageWithURLString:(NSString *)urlString completionHandler:( void (^)(UIImage *))completionBlock;
- (void)cancelDataTask;
@end

#endif /* NetworkManager_h */
