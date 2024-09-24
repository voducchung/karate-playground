Feature: Custom Payment Pages - Examples 1

  Background:
    * url baseUrl

    * def headers =
      """
      {
        'scfs-member-id': '1284741',
        'scfs-user-uuid': 'f3d7d80c-7a72-44ab-8b14-248926abd8fd',
        'country-id': 'SG',
        'username': 'user@example.com'
      }
      """
    * def params =
      """
      {
        page: 1,
        per_page: 10
      }
      """
    * def requestPayload =
      """
      {
        "name": "a name that works",
        "description": "a description that works",
        "amount": 1,
        "reference": "AReferenceThatWorks",
        "card_processing_fee": "COLLECTOR",
        "payout_speed": "normal",
        "payment_methods": [ "CARD", "PAYNOW", "BANK_ACCOUNT" ]
      }
      """

  Scenario Outline: List custom payment pages - <checkpoint>
    * eval <checkpoint_data_update_expression>
    * configure headers = headers
    * path '/ext/v1/receivables/custom-payment-pages'
    * params params
    * method get
    * status <status>

    Examples:
      | checkpoint        | checkpoint_data_update_expression                            | status |
      | no paging         | params = null                                                | 200    |
      | missing member id | delete headers['scfs-member-id']                             | 400    |
      | default setup     | ''                                                           | 200    |
      | multiple update   | params.page = 2; headers['username'] = 'another@example.com' | 200    |

  Scenario Outline: Get custom payment page by id - <checkpoint>
    * def pageId = ''
    * eval <checkpoint_data_update_expression>
    * configure headers = headers
    * path '/ext/v1/receivables/custom-payment-pages/' + pageId
    * method get
    * status <status>

    Examples:
      | checkpoint            | checkpoint_data_update_expression                  | status |
      | existing page id      | pageId = 'pl_4d7c6ae3-9291-40ae-bddc-4d93fcf5c08e' | 200    |
      | non-existing page id  | pageId = 'non-existing'                            | 404    |
      | unsuported country id | headers['country-id'] = 'XX'                       | 400    |

  Scenario Outline: Create custom payment page - <checkpoint>
    * eval <checkpoint_data_update_expression>
    * configure headers = headers
    * path '/ext/v1/receivables/custom-payment-pages'
    * request requestPayload
    * method post
    * status <status>

    Examples:
      | checkpoint            | checkpoint_data_update_expression                  | status |

  Scenario Outline: Update custom payment page by id - <checkpoint>
    * def pageId = ''
    * eval <checkpoint_data_update_expression>
    * configure headers = headers
    * path '/ext/v1/receivables/custom-payment-pages/' + pageId
    * request requestPayload
    * method put
    * status <status>

    Examples:
      | checkpoint            | checkpoint_data_update_expression                  | status |

  Scenario Outline: Delete custom payment page by id - <checkpoint>
    * def pageId = ''
    * eval <checkpoint_data_update_expression>
    * configure headers = headers
    * path '/ext/v1/receivables/custom-payment-pages/' + pageId
    * method delete
    * status <status>

    Examples:
      | checkpoint            | checkpoint_data_update_expression                  | status |
