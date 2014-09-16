//-------------------------------------------------------------------------------
// Licensed Materials - Property of IBM
// XXXX-XXX (C) Copyright IBM Corp. 2013. All Rights Reserved.
// US Government Users Restricted Rights - Use, duplication or
// disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
//-------------------------------------------------------------------------------
//
//  IBMAbstractTrigger.h
//  IBMLocation iOS SDK

@class IBMTriggerCallback;

/**
 IBMAbstractTrigger is a class that defines methods common to all triggers. When implementing a trigger, subclass IBMAbstractTrigger and override the copyWithZone: method required by NSCopying.
 
 The IBMAbstractTrigger class is a provisional API.  APIs that are marked provisional are evolving and might change or be removed in future releases.
 */
@interface IBMAbstractTrigger : NSObject <NSCopying>

/**
 * The callback object whose execute() method that will be called when the trigger is activated.
 */
@property (nonatomic) IBMTriggerCallback *callback;

@end
