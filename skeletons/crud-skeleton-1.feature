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
    * status <status>

    Examples:
      | checkpoint        | checkpoint_data_update_expression | status |

  Scenario Outline: Get by id - <checkpoint>
    * def pageId = ''
    * eval <checkpoint_data_update_expression>
    * configure headers = headers
    * path 'path here' + '/' + pageId
    * method get
    * status <status>

    Examples:
      | checkpoint            | checkpoint_data_update_expression                  | status |

  Scenario Outline: Create - <checkpoint>
    * eval <checkpoint_data_update_expression>
    * configure headers = headers
    * path 'path here'
    * request requestPayload
    * method post
    * status <status>

    Examples:
      | checkpoint            | checkpoint_data_update_expression                  | status |

  Scenario Outline: Update - <checkpoint>
    * def pageId = ''
    * eval <checkpoint_data_update_expression>
    * configure headers = headers
    * path 'path here' + '/' + pageId
    * request requestPayload
    * method put
    * status <status>

    Examples:
      | checkpoint            | checkpoint_data_update_expression                  | status |

  Scenario Outline: Delete by id - <checkpoint>
    * def pageId = ''
    * eval <checkpoint_data_update_expression>
    * configure headers = headers
    * path 'path here' + '/' + pageId
    * method delete
    * status <status>

    Examples:
      | checkpoint            | checkpoint_data_update_expression                  | status |
