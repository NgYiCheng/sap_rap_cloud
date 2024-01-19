@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Purchase Requisition Header Interface'
define root view entity ZI_PurchReq_Header 
    as select from /dmo/travel
    composition [1..*] of ZI_PurchReq_Item as _Item
{
    
    key travel_id as Travel_ID,
        agency_id as Agency_ID,
        begin_date as Begin_Date,
        booking_fee as Booking_Fee,
        currency_code as Currency_Code,
        customer_id as Customer_ID,
        description as Description,
        lastchangedat as Lastchangedat,
        
        _Item // Make association public
}


