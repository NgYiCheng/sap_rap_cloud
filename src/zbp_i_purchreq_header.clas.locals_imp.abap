CLASS lhc_Travel DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR Travel RESULT result.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Travel RESULT result.

    METHODS create FOR MODIFY
      IMPORTING entities FOR CREATE Travel.

    METHODS earlynumbering_create FOR NUMBERING
      IMPORTING entities FOR CREATE Travel.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE Travel.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE Travel.

    METHODS read FOR READ
      IMPORTING keys FOR READ Travel RESULT result.

    METHODS lock FOR LOCK
      IMPORTING keys FOR LOCK Travel.

    METHODS rba_Item FOR READ
      IMPORTING keys_rba FOR READ Travel\_Item FULL result_requested RESULT result LINK association_links.

    METHODS cba_Item FOR MODIFY
      IMPORTING entities_cba FOR CREATE Travel\_Item.

    METHODS earlynumbering_cba_Item FOR NUMBERING
      IMPORTING entities FOR CREATE Travel\_Item.

ENDCLASS.

CLASS lhc_Travel IMPLEMENTATION.

  METHOD get_instance_features.
  ENDMETHOD.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD create.
  ENDMETHOD.

  METHOD earlynumbering_create.

    zcl_pr_behavior_api_class=>get_instance( )->earlynumbering_create_travel(
        EXPORTING
            entities = entities
        CHANGING
            failed = failed
            mapped = mapped
            reported = reported
    ).

  ENDMETHOD.

  METHOD update.
  ENDMETHOD.

  METHOD delete.
  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

  METHOD lock.
  ENDMETHOD.

  METHOD rba_Item.
  ENDMETHOD.

  METHOD cba_Item.
  ENDMETHOD.

  METHOD earlynumbering_cba_Item.

    zcl_pr_behavior_api_class=>get_instance( )->earlynumbering_cba_item(
        EXPORTING
            entities = entities
        CHANGING
            failed = failed
            mapped = mapped
            reported = reported
    ).

  ENDMETHOD.

ENDCLASS.

CLASS lhc_Booking DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE Booking.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE Booking.

    METHODS read FOR READ
      IMPORTING keys FOR READ Booking RESULT result.

    METHODS rba_Header FOR READ
      IMPORTING keys_rba FOR READ Booking\_Header FULL result_requested RESULT result LINK association_links.

ENDCLASS.

CLASS lhc_Booking IMPLEMENTATION.

  METHOD update.
  ENDMETHOD.

  METHOD delete.
  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

  METHOD rba_Header.
  ENDMETHOD.

ENDCLASS.

CLASS lsc_ZI_PURCHREQ_HEADER DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS finalize REDEFINITION.

    METHODS check_before_save REDEFINITION.

    METHODS save REDEFINITION.

    METHODS cleanup REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_ZI_PURCHREQ_HEADER IMPLEMENTATION.

  METHOD finalize.
  ENDMETHOD.

  METHOD check_before_save.
  ENDMETHOD.

  METHOD save.
  ENDMETHOD.

  METHOD cleanup.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
