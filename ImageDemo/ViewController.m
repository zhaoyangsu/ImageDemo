//
//  ViewController.m
//  ImageDemo
//
//  Created by xiu on 12-6-7.
//  Copyright (c) 2012年 AlphaStudio. All rights reserved.
//





#import "ViewController.h"
#import "ASThumbnailImageOperation.h"
#import "ASShowImageViewController.h"


@implementation ViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString* documentPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    filesArray = [[NSArray alloc]initWithArray: [[NSFileManager defaultManager]contentsOfDirectoryAtPath:documentPath error:nil]];
    thumbnailImageQueue = [[NSOperationQueue alloc]init];
    thumbnailImageQueue.maxConcurrentOperationCount = 20;
    NSThread* thread = [[NSThread alloc]initWithTarget:self selector:@selector(prepareTheThumImage:) object:filesArray];
    [thread start];
    
    
}

- (void)viewDidUnload
{
    [filesArray release];
    [thumbnailImageQueue cancelAllOperations];
    [thumbnailImageQueue release];
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

-(void)prepareTheThumImage:(NSArray *)ImageArray
{
    NSAutoreleasePool* pool = [[NSAutoreleasePool alloc]init];
    
    
    NSArray* array = [[NSArray alloc]initWithArray:ImageArray];
    NSArray* tmpArray = [[NSFileManager defaultManager]contentsOfDirectoryAtPath:[NSHomeDirectory() stringByAppendingPathComponent:@"tmp"] error:nil];
    
    
    for (NSString* imageName in array)
    {
        
        if ( NSNotFound == [tmpArray indexOfObject:imageName])
        {
            ASThumbnailImageOperation* operation = [[ASThumbnailImageOperation alloc]init];
            operation.imageName = imageName;
            [thumbnailImageQueue addOperation:operation];
            [operation release];
        }
    }
    
    
    [array release];
    [pool drain];
//    [pool release];
}


#pragma mark -
#pragma UITableVioew

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [filesArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* identifier = @"image";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    NSUInteger row = [indexPath row];
    if (!cell) {
        
        cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier]autorelease];
        
    }
    cell.textLabel.text = [filesArray objectAtIndex:row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSArray* tmpArray = [[NSFileManager defaultManager]contentsOfDirectoryAtPath:[NSHomeDirectory() stringByAppendingPathComponent:@"tmp"] error:nil];
    if ([[thumbnailImageQueue operations]count] == 0) 
    {
        ASShowImageViewController* showController = [[ASShowImageViewController alloc]initWithNibName:@"ASShowImageViewController" bundle:nil];
        
        showController.currentImageName = [filesArray objectAtIndex:[indexPath row]];
        showController.imagePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        showController.tmpImagePath = [NSHomeDirectory() stringByAppendingPathComponent:@"tmp"];
        [self.navigationController pushViewController:showController animated:YES];
        [showController release];
    }
    else
    {
        NSLog(@"please hold on !!");
    }
}


@end
