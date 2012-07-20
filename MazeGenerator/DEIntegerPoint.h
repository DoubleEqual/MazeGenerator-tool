//
//  DEIntegerPoint.h
//  TileMap Caperucita
//
//  Created by Sergio on 18/07/12.
//  Copyright (c) 2012 Double Equal.com. All rights reserved.
//

#import <Foundation/Foundation.h>

//This a new integer point structure, as apple don't have one of these, we have to build one

struct DEIntegerPoint
{
    NSInteger x;
    NSInteger y;
};

CG_INLINE struct DEIntegerPoint
DEIntegerPointMake(NSInteger x, NSInteger y)
{
    struct DEIntegerPoint p; 
    p.x = x;
    p.y = y;
    
    return p;
}

CG_INLINE bool
__DEIntegerPointEqualToPoint(struct DEIntegerPoint point1, struct DEIntegerPoint point2)
{
    return point1.x == point2.x && point1.y == point2.y;
}
#define DEIntegerPointEqualToPoint __DEIntegerPointEqualToPoint