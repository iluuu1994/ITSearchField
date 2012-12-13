//
//  ITSearchFieldCell.m
//  Expanding Search
//
//  Created by Ilija Tovilo on 12/3/12.
//  Copyright (c) 2012 Ilija Tovilo. All rights reserved.
//

// Copyright (c) 2012, Ilija Tovilo
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without modification,
// are permitted provided that the following conditions are met:
//
// Redistributions of source code must retain the above copyright notice,
// this list of conditions and the following disclaimer.
//
// Redistributions in binary form must reproduce the above copyright notice,
// this list of conditions and the following disclaimer in the documentation and/or
// other materials provided with the distribution.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
// IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
// INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
// PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
// HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
// OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
// EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#import "ITSearchFieldCell.h"
#import "ITSearchField.h"

@implementation ITSearchFieldCell

- (void)awakeFromNib {
    [self resetCancelButtonCell];
    [self resetSearchButtonCell];
    [self setFocusRingType:NSFocusRingTypeNone];
}

- (BOOL)isCollapsed {
    return [(ITSearchField *)self.controlView isCollapsed];
}

- (void) resetSearchButtonCell {
    NSButtonCell *c= [[NSButtonCell alloc] init];
	[c setButtonType:NSMomentaryChangeButton];
	[c setBezelStyle:NSRegularSquareBezelStyle];
	[c setBordered:NO];
	[c setBezeled:NO];
	[c setEditable:NO];
	[c setImagePosition:NSImageOnly];
	[c setImage:[NSImage imageNamed:@"search"]];
    [c setAlternateImage:[NSImage imageNamed:@"search-pushed"]];
	[c setTarget:self];
	[c setAction:@selector(_search:)];
    [self setSearchButtonCell:c];
}


- (void)drawWithFrame:(NSRect)cellFrame inView:(NSView *)controlView {
    [self drawBackgroundInRect:cellFrame];
    [self drawInteriorWithFrame:cellFrame inView:controlView];
}

- (IBAction)_search:(id)sender {
    [[self cancelButtonCell] performClick:self];
    [(ITSearchField *)self.controlView toggleWidth];
}

- (void)drawBackgroundInRect:(NSRect)dirtyRect {

    ITSearchField *sf = (ITSearchField *)self.controlView;
    
    float alpha = 1.0 / (sf.expandedWidth - sf.collapsedWidth) * (NSWidth(sf.frame) - sf.collapsedWidth);
   
    //// Color Declarations
    NSColor* borderColor = [NSColor colorWithDeviceWhite:0.59 alpha:1 * alpha];
    NSColor* shadowBlack = [NSColor colorWithCalibratedRed: 0 green: 0 blue: 0 alpha: 0.22 * alpha];
    
    //// Shadow Declarations
    NSShadow* insetShadow = [[NSShadow alloc] init];
    [insetShadow setShadowColor: shadowBlack];
    [insetShadow setShadowOffset: NSMakeSize(0.1, -1.1)];
    [insetShadow setShadowBlurRadius: 2];
    
    //// Frames
    NSRect frame = NSInsetRect(self.controlView.bounds, 1, 0.5);
    
    
    //// Rounded Rectangle Drawing
    NSBezierPath* roundedRectanglePath = [NSBezierPath bezierPathWithRoundedRect:frame xRadius:NSHeight(frame) / 2 yRadius:NSHeight(frame) / 2];
    [roundedRectanglePath closePath];
    [[NSColor colorWithDeviceWhite:1.0 alpha:1.0 * alpha] setFill];
    [roundedRectanglePath fill];
    
    ////// Rounded Rectangle Inner Shadow
    NSRect roundedRectangleBorderRect = NSInsetRect([roundedRectanglePath bounds], -insetShadow.shadowBlurRadius, -insetShadow.shadowBlurRadius);
    roundedRectangleBorderRect = NSOffsetRect(roundedRectangleBorderRect, -insetShadow.shadowOffset.width, -insetShadow.shadowOffset.height);
    roundedRectangleBorderRect = NSInsetRect(NSUnionRect(roundedRectangleBorderRect, [roundedRectanglePath bounds]), -1, -1);
    
    NSBezierPath* roundedRectangleNegativePath = [NSBezierPath bezierPathWithRect: roundedRectangleBorderRect];
    [roundedRectangleNegativePath appendBezierPath: roundedRectanglePath];
    [roundedRectangleNegativePath setWindingRule: NSEvenOddWindingRule];
    
    [NSGraphicsContext saveGraphicsState];
    {
        NSShadow* insetShadowWithOffset = [insetShadow copy];
        CGFloat xOffset = insetShadowWithOffset.shadowOffset.width + round(roundedRectangleBorderRect.size.width);
        CGFloat yOffset = insetShadowWithOffset.shadowOffset.height;
        insetShadowWithOffset.shadowOffset = NSMakeSize(xOffset + copysign(0.1, xOffset), yOffset + copysign(0.1, yOffset));
        [insetShadowWithOffset set];
        [[NSColor grayColor] setFill];
        [roundedRectanglePath addClip];
        NSAffineTransform* transform = [NSAffineTransform transform];
        [transform translateXBy: -round(roundedRectangleBorderRect.size.width) yBy: 0];
        [[transform transformBezierPath: roundedRectangleNegativePath] fill];
    }
    [NSGraphicsContext restoreGraphicsState];
    
    [borderColor setStroke];
    [roundedRectanglePath setLineWidth: 1];
    [roundedRectanglePath stroke];

}

@end
