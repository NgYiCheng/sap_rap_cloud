@EndUserText.label: 'Purchase Requisition Item Consumption'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Search.searchable: true
@Metadata.allowExtensions: true

define view entity ZC_PURCHREQ_ITEM 
    as projection on ZI_PurchReq_Item as _Item
{
    @Search.defaultSearchElement: true
    key Travel_ID,
    key Booking_ID,
    Carrier_ID,
    Connection_ID,
    
    /* Associations */
    _Header: redirected to parent ZC_PurchReq_Header
}
