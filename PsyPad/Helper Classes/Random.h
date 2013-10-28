//
//  Random.h
//  eTASM
//
//  Created by David Lawson on 2/12/12.
//

#import <Foundation/Foundation.h>

@interface Random : NSObject

// Sets up the random generator nrand48()
+ (unsigned short *)setupState:(unsigned int)seed;

// Improved nrand48() implementation for generating random integers
+ (int)randiFrom:(int)low to:(int)high withState:(unsigned short *)state;

// Improved nrand48() implementation for generating random doubles
+ (double)randfFrom:(double)low to:(double)high withState:(unsigned short *)state;

@end
