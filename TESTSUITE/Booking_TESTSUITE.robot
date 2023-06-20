*** Settings ***
Documentation           Application Name : Booking.com
Resource                ${EXECDIR}${/}PAGES/Page.robot
Resource                ${EXECDIR}${/}RESOURCES/UTILS/COMMONS.robot


Suite Setup         Run Keywords    open_and_maximize_browser_url       close_genius_popup
#Test Setup
#Test Teardown       close_open_session
#Suite Teardown      ${None}

*** Test Cases ***

TC_01_Verify_searching_flights
    [Documentation]     Searching flights
    [Tags]              1
    PAGE.verify_that_booking_dot_com_main_page_is_launched_succesfully
    PAGE.launching_flights_and_hotels_page
    PAGE.searching_flights_and_hotel
    PAGE.select_hotel_from_displayed_hotel_list
    PAGE.select_hotel_room
    PAGE.select_flight
#    PAGE.add_customer_information
#    PAGE.add_passenger_1_information
    PAGE.validate_prices








