/*
 *  Copyright (c) 2012-2013, Pixate, Inc
 *  All rights reserved.
 *
 *  This program is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

#import "ComPixateModule.h"
#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"
#import "TiUIView.h"
#import "TiViewProxy.h"
#import "Ti2DMatrix.h"

#import <objc/runtime.h>
#import <objc/message.h>

#import <Pixate/Pixate.h>

@class Pixate;
@class PXStylesheet;
@class PXStyleUtils;

@implementation ComPixateModule

#pragma mark Internal

// this is generated for your module, please do not change it
- (id)moduleGUID
{
	return @"e7b14a43-901c-41eb-9b25-76e859290cdd";
}

// this is generated for your module, please do not change it
- (NSString*)moduleId
{
	return @"com.pixate.pxengine";
}

#pragma Pixate enums

MAKE_SYSTEM_PROP(PXStylesheetOriginApplication, PXStylesheetOriginApplication);
MAKE_SYSTEM_PROP(PXStylesheetOriginUser,        PXStylesheetOriginUser);
MAKE_SYSTEM_PROP(PXStylesheetOriginView,        PXStylesheetOriginView);

#pragma Pixate API

- (void)styleSheetFromFilePathWithOrigin:(id)args
{
    ENSURE_SINGLE_ARG(args, NSDictionary);

    NSString *aFilePath = [TiUtils stringValue:[args valueForKey:@"filename"]];
    int       origin    = [TiUtils intValue:[args valueForKey:@"origin"]];

    PXStylesheet *pxs = [Pixate styleSheetFromFilePath:aFilePath withOrigin:origin];

    if([args valueForKey:@"monitor"] != nil)
    {
        [pxs setMonitorChanges:[TiUtils boolValue:[args valueForKey:@"monitor"]]];
    }
}

- (void)styleSheetFromSourceWithOrigin:(id)args
{
    ENSURE_SINGLE_ARG(args, NSDictionary);

    NSString *source = [TiUtils stringValue:[args valueForKey:@"source"]];
    int       origin    = [TiUtils intValue:[args valueForKey:@"origin"]];

    [Pixate styleSheetFromSource:source withOrigin:origin];
}

- (void)applyStylesheets:(id)args
{
    [Pixate applyStylesheets];
}

- (id)refreshStylesWithOrientationChange
{
    return NUMBOOL(Pixate.refreshStylesWithOrientationChange);
}

-(void)setRefreshStylesWithOrientationChange:(id)val
{
    [Pixate setRefreshStylesWithOrientationChange: [TiUtils boolValue:val]];
}

- (NSString *)version
{
    return Pixate.version;
}

- (NSDate *)buildDate
{
    return Pixate.buildDate;
}

+(NSString *)licenseEmail
{
    return Pixate.licenseEmail;
}

+(NSString *)licenseKey
{
    return Pixate.licenseKey;
}

@end

@interface TiViewProxy (Pixate)
@end

@implementation TiViewProxy (Pixate)

+(void)load
{
    [self swizzleMethod:@selector(relayout) withMethod:@selector(px_relayout)];
}

-(void)updateStyles:(id)arg
{
    TiThreadPerformOnMainThread(^{
        if([self.view respondsToSelector:@selector(updateStyles)])
        {
            [[self view] updateStyles];
        }
    }, NO);
}

-(void)updateStylesNonRecursively:(id)arg
{
    TiThreadPerformOnMainThread(^{
        if([self.view respondsToSelector:@selector(updateStylesNonRecursively)])
        {
            [[self view] updateStylesNonRecursively];
        }
    }, NO);
}

-(void)px_relayout
{
    [self px_relayout];
    [self updateStylesNonRecursively:nil];
}

+ (void)swizzleMethod:(SEL)orig_sel withMethod:(SEL)alt_sel
{
	Class c = self;
    Method origMethod = class_getInstanceMethod(c, orig_sel);
    Method altMethod = class_getInstanceMethod(c, alt_sel);

    if (class_addMethod(c, orig_sel, method_getImplementation(altMethod), method_getTypeEncoding(altMethod)))
    {
        class_replaceMethod(c, alt_sel, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
    }
    else
    {
        method_exchangeImplementations(origMethod, altMethod);
    }
}

@end

////////


@interface TiUIView (Pixate)
@end

@implementation TiUIView (Pixate)

- (void)setStyleId_:(id)value
{
    [self.accessibilityElement setStyleId:[TiUtils stringValue:value]];
}

- (void)setStyleClass_:(id)value
{
    [self.accessibilityElement setStyleClass:[TiUtils stringValue:value]];
}

- (void)setStyleCSS_:(id)value
{
    [self.accessibilityElement setStyleCSS:[TiUtils stringValue:value]];
}

- (void)px_set2DTransform:(NSValue *)transform
{
    [self setTransform_:[[Ti2DMatrix alloc] initWithMatrix:[transform CGAffineTransformValue]]];
}

@end
