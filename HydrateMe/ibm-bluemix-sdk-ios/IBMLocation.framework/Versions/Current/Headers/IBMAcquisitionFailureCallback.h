//-------------------------------------------------------------------------------
// Licensed Materials - Property of IBM
// XXXX-XXX (C) Copyright IBM Corp. 2013. All Rights Reserved.
// US Government Users Restricted Rights - Use, duplication or
// disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
//-------------------------------------------------------------------------------
//
//  IBMAcquisitionFailureCallback.h
//  IBMLocation iOS SDK

/**
 The IBMAcquisitionFailureCallback interface defines the methods that acquisition failure callback classes must implement.
 
 The IBMAcquisitionFailureCallback class is a provisional API.  APIs that are marked provisional are evolving and might change or be removed in future releases.
 */
@protocol IBMAcquisitionFailureCallback <NSObject>

/**
 The method will be executed when an error occurs during acquisition.
 @param errorObject the error that occurred.
 */
- (void) execute : (id) errorObject ;

@end
