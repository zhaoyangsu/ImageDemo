//
//  ASloadImageOperation.m
//  ImageDemo
//
//  Created by xiu on 12-6-9.
//  Copyright (c) 2012年 AlphaStudio. All rights reserved.
//

#import "ASloadImageOperation.h"

@implementation ASloadImageOperation
@synthesize page;
@synthesize imagePath;
@synthesize delegate;

-(void)main
{
    NSData* data = [[NSData alloc]initWithContentsOfFile:imagePath];

    image = [[UIImage alloc]initWithData:data];
    [data release];
    
    
    pthread_mutex_t tallyMutex;
    pthread_mutex_init( &tallyMutex, NULL );
    pthread_mutex_lock(&tallyMutex);
    if (!self.isCancelled)
    {
        [delegate loadImage:image atPage:page];
    }
    pthread_mutex_unlock(&tallyMutex);
    [image release];
    
}

@end
