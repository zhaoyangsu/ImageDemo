//
//  ASloadImageView.m
//  ImageDemo
//
//  Created by xiu on 12-6-10.
//  Copyright (c) 2012年 AlphaStudio. All rights reserved.
//

#import "ASloadImageView.h"


@interface ASloadImageView(hidden)
-(void)loadThunbnailImage;

@end


@implementation ASloadImageView
@dynamic imagePath;
@synthesize isThumbnailIamge;

-(NSString*)imagePath
{
    return imagePath;
}


-(void)setImagePath:(NSString *)aImagePath
{
    if ([imagePath  isEqualToString:aImagePath]) {
        return;
    }
    [thumbnailImage release];
    thumbnailImage = nil;
    [imagePath release];
   
    imagePath = [aImagePath retain];
//    [self performSelector:@selector(loadThunbnailImage) withObject:nil afterDelay:0.0];
    [self loadThunbnailImage];
    
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
    }
    return self;
}

-(void)loadThunbnailImage
{
   
    NSString* path = [[NSHomeDirectory() stringByAppendingPathComponent:@"tmp"]stringByAppendingPathComponent:[imagePath lastPathComponent]];
    
    NSData* data = [[NSData alloc]initWithContentsOfFile:path];
    if (thumbnailImage) {
        [thumbnailImage release];
        thumbnailImage = nil;
    }
    thumbnailImage = [[UIImage alloc]initWithData:data];
    [data release];
    [self setNeedsDisplay];
//    UIImage* tempImage = [UIImage imageWithData:data];
//    [data release];
//    CGSize size = CGSizeMake(self.frame.size.width / 4, self.frame.size.height / 4);
//    if (NULL != UIGraphicsBeginImageContextWithOptions)
//    {
//        UIGraphicsBeginImageContextWithOptions(size, YES, 0);
//    }
//    else
//        UIGraphicsBeginImageContext(size);
//    [tempImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
//    thumbnailImage = [UIGraphicsGetImageFromCurrentImageContext() retain];
//    UIGraphicsEndImageContext();
//    [self setNeedsDisplay];
//    isThumbnailIamge = YES;
    
   
}

-(void)loadCurrentImageDelay
{
    if (!isThumbnailIamge) {
        return;
    }
    NSData* data = [[NSData alloc]initWithContentsOfFile:imagePath];
    UIImage* tempImage = [UIImage imageWithData:data];
    [data release];
    CGSize size = CGSizeMake(self.frame.size.width , self.frame.size.height);
    if (NULL != UIGraphicsBeginImageContextWithOptions)
    {
        UIGraphicsBeginImageContextWithOptions(size, YES, 0);
    }
    else
        UIGraphicsBeginImageContext(size);
    [tempImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
    if (isThumbnailIamge) {
        thumbnailImage = [UIGraphicsGetImageFromCurrentImageContext() retain];
        isThumbnailIamge = NO;
        
        [self setNeedsDisplay];
    }
    UIGraphicsEndImageContext();
}


-(void)loadCurrentImage
{
    [self performSelector:@selector(loadCurrentImageDelay)withObject:nil afterDelay:0.5];
    
    
    
    
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    [thumbnailImage drawInRect:CGRectMake(0, 0, 320 , 460)];
//    CGContextRef ctx = UIGraphicsGetCurrentContext();
//    CGLayerRef cg = CGLayerCreateWithContext(ctx, CGSizeMake(320, 460), NULL);
//    CGContextRef layercontext = CGLayerGetContext(cg);
//    CGContextDrawImage(layercontext, CGRectMake(0, 0, 320, 460),[thumbnailImage CGImage] );
//    CGContextDrawLayerAtPoint(ctx, CGPointMake(0, 0), cg);
//    CGLayerRelease(cg);
    [thumbnailImage release];
    thumbnailImage = nil;

}


@end
