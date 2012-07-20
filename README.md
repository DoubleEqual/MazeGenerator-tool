MazeGenerator-tool
==================

A simple Objective-C class to create a maze. DEMazeGenerator allows you to build a simple maze using Recursive division method. 

Just define number of rows, columns and a starting point and the code will do all the magic.

i.e:
<pre>
    int row = 4;
    int col = 4;
    
    DEMazeGenerator *maze = [[DEMazeGenerator alloc] initWithRow:row 
                                                          andCol:col 
                                               withStartingPoint:DEIntegerPointMake(1, 1)];
    
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
</pre>