CLASS zcl_pr_behavior_api_class DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    "Create Constructor // initialization method
    CLASS-METHODS:
        get_instance RETURNING VALUE(ro_instance) TYPE REF TO zcl_pr_behavior_api_class.

    TYPES:
        tt_create_early TYPE TABLE FOR CREATE zi_purchreq_header\\travel,
        tt_mapped_early TYPE RESPONSE FOR MAPPED EARLY zi_purchreq_header,
        tt_failed_early TYPE RESPONSE FOR FAILED EARLY zi_purchreq_header,
        tt_reported_early TYPE RESPONSE FOR REPORTED EARLY zi_purchreq_header,
        tt_create_early_item TYPE TABLE FOR CREATE zi_purchreq_header\\travel\_Item.

    "Class Methods
    METHODS:
        earlynumbering_create_travel
            IMPORTING entities  TYPE tt_create_early
            CHANGING mapped  TYPE tt_mapped_early
                     failed  TYPE tt_failed_early
                     reported  TYPE tt_reported_early,

        earlynumbering_cba_item
            IMPORTING entities TYPE tt_create_early_item
            CHANGING mapped TYPE tt_mapped_early
                     failed TYPE tt_failed_early
                     reported TYPE tt_reported_early.



  PROTECTED SECTION.
  PRIVATE SECTION.

    CLASS-DATA:
        mo_instance TYPE REF TO zcl_pr_behavior_api_class,
        gt_travel TYPE STANDARD TABLE OF /dmo/travel,
        gt_booking TYPE STANDARD TABLE OF /dmo/booking.

ENDCLASS.



CLASS zcl_pr_behavior_api_class IMPLEMENTATION.

  METHOD get_instance.

    mo_instance = ro_instance = COND #( WHEN mo_instance IS BOUND
                                        THEN mo_instance
                                        ELSE NEW #(  )
                                      ).

  ENDMETHOD.

  METHOD earlynumbering_create_travel.
    "reported - pass back calculations in save method into frontend
    "failed - pass back error message into front end
    "mapped - pass back info into front end especially ID
    DATA: travel_id_max TYPE /dmo/travel_id.

    "Ensure id is initial - must check when draft enabled
    LOOP AT entities INTO DATA(entity) WHERE Travel_ID IS NOT INITIAL.
        APPEND CORRESPONDING #( entity ) TO mapped-travel.
    ENDLOOP.

    DATA(entities_wo_travelid) = entities.
    DELETE entities_wo_travelid WHERE Travel_ID IS NOT INITIAL.

    "Get max Travel ID
    SELECT SINGLE FROM /dmo/travel FIELDS MAX( travel_id ) INTO @DATA(max_travelid).

    "Select from draft table
    SELECT SINGLE FROM ztravel_d_header FIELDS MAX( travel_id ) INTO @DATA(max_travelid_draft).

    IF max_travelid < max_travelid_draft.
        max_travelid = max_travelid_draft.
    ELSEIF max_travelid = 0.
        max_travelid += 1.
    ENDIF.

    "Set Travel ID
    LOOP AT entities_wo_travelid INTO entity.

        max_travelid += 1.
        entity-Travel_ID = max_travelid.

*        mapped-travel = VALUE #(
*            FOR entity_travel IN entities_wo_travelid (
*                %cid    =    entity_travel-%cid
*                %is_draft = entity_travel-%is_draft
*                Travel_ID = ( max_travelid += 1 )
*            )
*        ).
        APPEND VALUE #( %cid = entity-%cid
                        %key = entity-%key
                        %is_draft = entity-%is_draft
                    ) TO mapped-travel.

    ENDLOOP.

  ENDMETHOD.

  METHOD earlynumbering_cba_item.

    "declare variable for max travel_id/booking_id
    DATA: travel_id_max TYPE /dmo/travel_id,
          booking_id_max TYPE /dmo/booking_id.

    LOOP AT entities ASSIGNING FIELD-SYMBOL(<lfs_entity>).

        "ensure id is initial - must check when draft enabled
        LOOP AT <lfs_entity>-%target INTO DATA(booking_entity) WHERE Booking_ID IS NOT INITIAL.
            APPEND CORRESPONDING #( booking_entity ) TO mapped-booking.
        ENDLOOP.

        "reference and delete the result which have empty id
        DATA(entities_wo_bookingid) = <lfs_entity>-%target.
        DELETE entities_wo_bookingid WHERE Booking_ID IS NOT INITIAL.

        "get max Travel ID from master database
        SELECT SINGLE FROM /dmo/booking FIELDS MAX( booking_id )
            WHERE travel_id EQ @<lfs_entity>-Travel_ID
            INTO @DATA(max_booking_id).

        "Select from draft table
        SELECT SINGLE FROM zbook_d_item FIELDS MAX( booking_id )
            WHERE travel_id EQ @<lfs_entity>-Travel_ID
            INTO @DATA(max_bookingid_draft).



        LOOP AT entities_wo_bookingid ASSIGNING FIELD-SYMBOL(<lfs_result>).

            IF max_booking_id < max_bookingid_draft.
                max_booking_id = max_bookingid_draft.
            ENDIF.
            max_booking_id += 1.
            <lfs_result>-Booking_ID = max_booking_id.

            APPEND VALUE #( %cid = <lfs_result>-%cid
                            %key = <lfs_result>-%key
                            %is_draft = <lfs_result>-%is_draft
                        ) TO mapped-booking.

        ENDLOOP.

    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
