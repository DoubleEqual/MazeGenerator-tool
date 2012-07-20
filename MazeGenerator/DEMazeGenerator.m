//
//  MazeGenerator.m
//  TileMap Caperucita
//
//  Created by Sergio on 18/07/12.
//  Copyright (c) 2012 Doubleequal.com. All rights reserved.
//

#import "DEMazeGenerator.h"
#include <malloc/malloc.h>

#define NORTH 'N'
#define EAST 'E'
#define WEST 'W'
#define SOUTH 'S'

#define kNorthFlag 1
#define kEastFlag 2
#define kSouthFlag 4
#define kWestFlag 8

@implementation DEMazeGenerator

+ (int)drawPathWithFlagsNorth:(bool)north south:(bool)south east:(bool)east west:(bool)west
{
    int retValue = 0;
    
    if (north)
    {
        retValue |= kNorthFlag;
    }
    
    if (east)
    {
        retValue |= kEastFlag;
    }
    
    if (south)
    {
        retValue |= kSouthFlag;
    }
    
    if (west)
    {
        retValue |= kWestFlag;
    }
    
    return retValue;
}

- (id)initWithRow:(int)row andCol:(int)col withStartingPoint:(struct DEIntegerPoint)position
{
    if ((self = [super init]))
    {
        _width	= col * 2 + 1;
        _height	= row * 2 + 1;
        _start = position;
        
        [self initMaze];
    }
    
    return self;
}

- (void)initMaze
{
    _maze = (bool **)calloc(_height, sizeof(bool *));

    for (int r = 0; r < _height; r++)
    {
        _maze[r] = (bool *)calloc(_width, sizeof(bool));
        
        for (int c = 0; c < _width; c++)
        {
            _maze[r][c] = true;
        }
    }
    
    _maze[_start.x][_start.y] = false;
}

- (void)createMaze
{
    int back;
    int move;
    NSString *possibleDirections;
    struct DEIntegerPoint pos = _start;
    
    _moves = [NSMutableArray new];

    [_moves addObject:[NSNumber numberWithInt:pos.y + (pos.x * _width)]];
    
    while ([_moves count])
    {
        possibleDirections = @"";
        
        if ((pos.x + 2 < _height ) && (_maze[pos.x + 2][pos.y] == true) && (pos.x + 2 != false) && (pos.x + 2 != _height - 1) )
        {
            possibleDirections = [possibleDirections stringByAppendingFormat:@"%C", SOUTH];
        }
        
        if ((pos.x - 2 >= 0 ) && (_maze[pos.x - 2][pos.y] == true) && (pos.x - 2 != false) && (pos.x - 2 != _height - 1) )
        {
            possibleDirections = [possibleDirections stringByAppendingFormat:@"%C", NORTH];
        }
        
        if ((pos.y - 2 >= 0 ) && (_maze[pos.x][pos.y - 2] == true) && (pos.y - 2 != false) && (pos.y - 2 != _width - 1) )
        {
            possibleDirections = [possibleDirections stringByAppendingFormat:@"%C", WEST];
        }
        
        if ((pos.y + 2 < _width ) && (_maze[pos.x][pos.y + 2] == true) && (pos.y + 2 != false) && (pos.y + 2 != _width - 1) )
        {
            possibleDirections = [possibleDirections stringByAppendingFormat:@"%C", EAST];
        }
        
        if (possibleDirections.length > 0)
        {
            move = [self randIntMin:0 andMax:(possibleDirections.length - 1)];
            
            const char *array = [possibleDirections UTF8String];
      
            switch (array[move])
            {
                case NORTH: 
                    _maze[pos.x - 2][pos.y] = false;
                    _maze[pos.x - 1][pos.y] = false;
                    pos.x -=2;
                    break;
                    
                case SOUTH: 
                    _maze[pos.x + 2][pos.y] = false;
                    _maze[pos.x + 1][pos.y] = false;
                    pos.x +=2;
                    break;
                    
                case WEST: 
                    _maze[pos.x][pos.y - 2] = false;
                    _maze[pos.x][pos.y - 1] = false;
                    pos.y -=2;
                    break;
                    
                case EAST: 
                    _maze[pos.x][pos.y + 2] = false;
                    _maze[pos.x][pos.y + 1] = false;
                    pos.y +=2;
                    break;        
            }

            [_moves addObject:[NSNumber numberWithInt:pos.y + (pos.x * _width)]];
        }
        else
        {
            back = [[_moves lastObject] intValue];
            [_moves removeLastObject];
            pos.x = (int)(back / _width);
            pos.y = back % _width;
        }
    }
    
    _response(_maze);
//    free(_maze);
//    [_moves release];
}

- (void)arrayMaze:(block)arrayMaze
{
    _response = nil;
    _response = arrayMaze;
    
    [self createMaze];
}

- (void)logMatrix
{
    for (int x = 0; x < _height; x++)
    {
        for (int y = 0; y < _width; y++)
        {
            NSLog(@"[%d , %d] = %d", x, y, _maze[x][y]);
        }
    }
}

- (int)randIntMin:(int)min andMax:(int)max
{
    return ((arc4random() % (max - min +1)) + min);
}
    
//- (void)dealloc
//{
//    [super dealloc];
//}

@end