//-------------------------------------------------------------------------------
// Licensed Materials - Property of IBM
// XXXX-XXX (C) Copyright IBM Corp. 2013. All Rights Reserved.
// US Government Users Restricted Rights - Use, duplication or
// disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
//-------------------------------------------------------------------------------
//
//  IBMArea.h
//  IBMLocation iOS SDK

@protocol IBMAreaVisitor;

/**
 Interface for geometric shapes that can be used to define an IBMGeoAreaTrigger or IBMGeoDwellTrigger.
 
 The IBMArea class is a provisional API.  APIs that are marked provisional are evolving and might change or be removed in future releases.
 */
@protocol IBMArea <NSObject>

/**
 Called to determine if the IBMAreaVisitor will be accepted.
 
 @param visitor the visitor to the defined area
 @return (NSNumber *) the visitor's return value
 */
- (NSNumber*) accept:(id<IBMAreaVisitor>)visitor;

@end
