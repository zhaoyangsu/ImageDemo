//
//  ASThumbnailImageOperation.h
//  ImageDemo
//
//  Created by xiu on 12-6-8.
//  Copyright (c) 2012年 AlphaStudio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ASThumbnailImageOperation : NSOperation
{
    NSString* imageName;
}


@property (nonatomic, retain)NSString* imageName;

@end
