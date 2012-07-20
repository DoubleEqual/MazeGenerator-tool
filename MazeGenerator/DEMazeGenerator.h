//
//  MazeGenerator.h
//  TileMap Caperucita
//
//  Created by Sergio on 18/07/12.
//  Copyright (c) 2012 Doubleequal.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DEIntegerPoint.h"

typedef void (^block)(bool **);

@interface DEMazeGenerator : NSObject
{
@private
    uint _width;
    uint _height;
    bool **_maze;
    NSMutableArray *_moves;
    struct DEIntegerPoint _start;
    block _response;
}

- (id)initWithRow:(int)row andCol:(int)col withStartingPoint:(struct DEIntegerPoint)position;
- (void)initMaze;
- (void)createMaze;
- (int)randIntMin:(int)min andMax:(int)max;
- (void)logMatrix;
- (void)arrayMaze:(block)arrayMaze;
+ (int)drawPathWithFlagsNorth:(bool)north south:(bool)south east:(bool)east west:(bool)west;

@end
