//
//  ViewController.m
//  MazeGenerator
//
//  Created by Sergio on 20/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "DEMazeGenerator.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    int row = 4;
    int col = 4;
    
    DEMazeGenerator *maze = [[DEMazeGenerator alloc] initWithRow:row andCol:col withStartingPoint:DEIntegerPointMake(1, 1)];
    
    [maze arrayMaze:^(bool **item) {
        
        NSMutableString *rowString = [NSMutableString string];
                    
        for (int r = 0; r < row * 2 + 1 ; r++)
        {
            [rowString setString:[NSString stringWithFormat:@"%d: ", r]];
            
            for (int c = 0; c < col * 2 + 1 ; c++)
            {
                [rowString appendFormat:@"%@ ", item[r][c] == 1 ? @"*" : @" "];
            }
            
            NSLog(@"%@", rowString);
        }

    }];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
   
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

@end
