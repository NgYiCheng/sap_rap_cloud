@EndUserText.label: 'Purchase Requisition Header Consumption'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Search.searchable: true
@Metadata.allowExtensions: true

define root view entity ZC_PURCHREQ_HEADER 
    as projection on ZI_PurchReq_Header as _Header
{
    
    @Search.defaultSearchElement: true
    key Travel_ID,
    Agency_ID,
    Begin_Date,
    Booking_Fee,
    Currency_Code,
    Customer_ID,
    Description,
    Lastchangedat,
    
    /* Associations */
    _Item: redirected to composition child ZC_PurchReq_Item
}
