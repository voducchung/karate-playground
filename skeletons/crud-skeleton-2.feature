@ignore
Feature: API Templates - CRUD

  Background:
    * url 'base url here'

    * def headers =
      """
      {
        // headers here
      }
      """
    * def params =
      """
      {
        // params here
      }
      """
    * def requestPayload =
      """
      {
        // payload here
      }
      """

  Scenario Outline: List - <checkpoint>
    * eval <checkpoint_data_update_expression>
    * configure headers = headers
    * path 'path here'
    * params params
    * method get
    * status 200
    # match detailed-matchers-here

    Examples:
      | checkpoint        | checkpoint_data_update_expression |

  Scenario Outline: Get by id - <checkpoint>
    * def pageId = ''
    * eval <checkpoint_data_update_expression>
    * configure headers = headers
    * path 'path here' + '/' + pageId
    * method get
    * status 200
    # match detailed-matchers-here

    Examples:
      | checkpoint        | checkpoint_data_update_expression |

  Scenario Outline: Create - <checkpoint>
    * eval <checkpoint_data_update_expression>
    * configure headers = headers
    * path 'path here'
    * request requestPayload
    * method post
    * status 201
    # match detailed-matchers-here

    Examples:
      | checkpoint        | checkpoint_data_update_expression |

  Scenario Outline: Update - <checkpoint>
    * def pageId = ''
    * eval <checkpoint_data_update_expression>
    * configure headers = headers
    * path 'path here' + '/' + pageId
    * request requestPayload
    * method put
    * status 200
    # match detailed-matchers-here

    Examples:
      | checkpoint        | checkpoint_data_update_expression |

  Scenario Outline: Delete by id - <checkpoint>
    * def pageId = ''
    * eval <checkpoint_data_update_expression>
    * configure headers = headers
    * path 'path here' + '/' + pageId
    * method delete
    * status 200
    # match detailed-matchers-here

    Examples:
      | checkpoint        | checkpoint_data_update_expression |
