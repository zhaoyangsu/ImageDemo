//
//  ASThumbnailImageOperation.m
//  ImageDemo
//
//  Created by xiu on 12-6-8.
//  Copyright (c) 2012年 AlphaStudio. All rights reserved.
//

#import "ASThumbnailImageOperation.h"

@implementation ASThumbnailImageOperation
@synthesize imageName;
- (id)init {
    self = [super init];
    if (self) {
    }
    return self;
}



-(void)main
{
    if (!imageName) {
        return;
    }
    NSString* path = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]stringByAppendingPathComponent:imageName];
    NSData* imageData = [[NSData alloc]initWithContentsOfFile:path];
    UIImage* image = [[UIImage alloc]initWithData:imageData];
    [imageData release];
    
    
    
//    CGSize size = CGSizeMake(80, image.size.height * 80 / image.size.width);
//    UIGraphicsBeginImageContext(size);
//    [image drawInRect:CGRectMake(0, 0, 80, 80)];
//    UIImage*newImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    [image release];
    UIImage* newImage;
    CGSize asize = CGSizeMake(320/4, 460/4);
    
    if (nil == image) {
        
        return;
        
    }
    
    else{
        
//        CGSize oldsize = image.size;
        
//        CGRect rect;
        
//        if (asize.width/asize.height > oldsize.width/oldsize.height) {
//            
//            rect.size.width = asize.height*oldsize.width/oldsize.height;
//            
//            rect.size.height = asize.height;
//            
//            rect.origin.x = (asize.width - rect.size.width)/2;
//            
//            rect.origin.y = 0;
//            
//        }
//        
//        else{
//            
//            rect.size.width = asize.width;
//            
//            rect.size.height = asize.width*oldsize.height/oldsize.width;
//            
//            rect.origin.x = 0;
//            
//            rect.origin.y = (asize.height - rect.size.height)/2;
//            
//        }
        
        if (NULL != UIGraphicsBeginImageContextWithOptions)
        {
            UIGraphicsBeginImageContextWithOptions(asize, YES, 0);
        }
        else
            UIGraphicsBeginImageContext(asize);        
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
        
        UIRectFill(CGRectMake(0, 0, asize.width, asize.height));//clear background
        
        [image drawInRect:CGRectMake(0, 0, asize.width, asize.height)];
        
        newImage = UIGraphicsGetImageFromCurrentImageContext();
        [image release];
        
        UIGraphicsEndImageContext();
        
    }
    
    
    
    
    
    
    
    NSData* newData = UIImagePNGRepresentation(newImage);
    NSString* newPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"tmp"]stringByAppendingPathComponent:imageName];
    [newData writeToFile:newPath atomically:YES];
    
}



-(void)dealloc
{
    [super dealloc];
}

@end
