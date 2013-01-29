/**
 * Your Copyright Here
 *
 * Appcelerator Titanium is Copyright (c) 2009-2010 by Appcelerator, Inc.
 * and licensed under the Apache Public License (version 2)
 */
#import "ComPixatePxengineModule.h"
#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"
#import "TiUIView.h"

@class PXEngine;
@class PXStylesheet;
@class PXStyleUtils;

@implementation ComPixatePxengineModule

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

- (void) licenseKeyForUser:(id)args
{
    ENSURE_SINGLE_ARG(args, NSDictionary);
    
    NSString *user    = [TiUtils stringValue:[args valueForKey:@"licenseUser"]];
    NSString *serial = [TiUtils stringValue:[args valueForKey:@"licenseSerial"]];
    
    [PXEngine licenseKey:serial forUser:user];
}

- (void) styleSheetFromFilePathWithOrigin:(id)args
{
    ENSURE_SINGLE_ARG(args, NSDictionary);
    
    NSString *aFilePath = [TiUtils stringValue:[args valueForKey:@"filename"]];
    int       origin    = [TiUtils intValue:[args valueForKey:@"origin"]];

    [PXStylesheet styleSheetFromFilePath:aFilePath withOrigin:origin];
}

- (void) styleSheetFromSourceWithOrigin:(id)args
{
    ENSURE_SINGLE_ARG(args, NSDictionary);
    
    NSString *source = [TiUtils stringValue:[args valueForKey:@"source"]];
    int       origin    = [TiUtils intValue:[args valueForKey:@"origin"]];
    
    [PXStylesheet styleSheetFromSource:source withOrigin:origin];
}

- (void) applyStylesheets
{
    [PXStylesheet applyStylesheets];
}

- (NSString *) version
{
    return [[PXEngine sharedInstance] version];
}

- (NSDate *) buildDate
{
    return [[PXEngine sharedInstance] buildDate];
}

@end

@interface TiUIView (Pixate)
@end

@implementation TiUIView (Pixate)

- (void)updateStyles_:(id)value
{
    [PXStyleUtils updateStylesForStyleable:self andDescendants:YES];
}

- (void)updateStylesNonRecursively_:(id)value
{
    [PXStyleUtils updateStylesForStyleable:self andDescendants:NO];
}

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

@end
