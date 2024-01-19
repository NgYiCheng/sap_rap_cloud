@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'PurchaseRequisition Interface'

define view entity ZI_PurchReq_Item 
    as select from /dmo/booking
    association to parent ZI_PurchReq_Header as _Header 
                                             on $projection.Travel_ID = _Header.Travel_ID                                 
    {
        
        key travel_id as Travel_ID,
        key booking_id as Booking_ID,
            carrier_id as Carrier_ID,
            connection_id as Connection_ID,
        
        //Association
        _Header
    }
