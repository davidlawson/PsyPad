//
//  Random.m
//  eTASM
//
//  Created by David Lawson on 2/12/12.
//

#import "Random.h"

@implementation Random

// Sets up the random generator nrand48()
+ (unsigned short *)setupState:(unsigned int)seed
{
    unsigned short *state = malloc(7 * sizeof(unsigned short));
    state[0] = (unsigned short)(0xFFFF & seed);
    state[1] = (unsigned short)((0XFFFF0000 & seed) >> 16);
    state[2] = 0x0000;
    state[3] = 0x0005;
    state[4] = 0xdeec;
    state[5] = 0xe66d;
    state[6] = 0x000b;

    return state;
}

// Improved nrand48() implementation for generating random integers
+ (int)randiFrom:(int)low to:(int)high withState:(unsigned short *)state
{
    return (nrand48(state) % (high - low + 1)) + low;
}

// Improved nrand48() implementation for generating random doubles
+ (double)randfFrom:(double)low to:(double)high withState:(unsigned short *)state
{
    return ((double)nrand48(state) / RAND_MAX) * (high - low) + low;
}

@end
