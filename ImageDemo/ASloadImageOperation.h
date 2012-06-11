//
//  ASloadImageOperation.h
//  ImageDemo
//
//  Created by xiu on 12-6-9.
//  Copyright (c) 2012年 AlphaStudio. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol   ASloadImageOperationDelegate

-(void)loadImage:(UIImage*)image atPage:(NSUInteger)page;

@end

@interface ASloadImageOperation : NSOperation<ASloadImageOperationDelegate>
{
    NSString* imagePath;
    NSUInteger page;
    UIImage* image;
    id<ASloadImageOperationDelegate> delegate;
}

@property (nonatomic, retain) NSString* imagePath;
@property (nonatomic, assign) NSUInteger page;
@property (nonatomic, retain) id<ASloadImageOperationDelegate> delegate;

@end
