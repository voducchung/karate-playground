Feature: Custom Payment Pages - Examples 2

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

  Scenario Outline: List custom payment pages - success - <checkpoint>
    * eval <checkpoint_data_update_expression>
    * configure headers = headers
    * path '/ext/v1/receivables/custom-payment-pages'
    * params params
    * method get
    * status 200
    * match response ==
      """
      {
        "success": true,
        "data": "#array"
      }
      """
    * match each response.data ==
      """
      {
        "id": "#string",
        "name": "#string",
        "description": "#string",
        "amount": #number,
        "reference": "#string",
        "payment_methods": "#array",
        "payout_speed": "#? ['normal', 'next_day'].includes(_)",
        "card_processing_fee": "#? ['COLLECTOR', 'PAYOR'].includes(_)",
        "payment_url": "#string",
        "status": "#? ['Active', 'Inactive'].includes(_)",
        "source_of_funds": "#array"
      }
      """
    * match each response.data[*].payment_methods contains any ["CARD", "PAY_NOW", "BANK_ACCOUNT"]')
    * match each response.data[*].source_of_funds[*] ==
      """
      {
        "type": "#? ['CARD', 'PAY_NOW', 'BANK_ACCOUNT'].includes(_)",
        "details": {
          "percent_fee_paid_by_payor": #number,
          "percent_fee_paid_by_collector": #number
        },
        "status": "#? ['PROCESSING', 'APPROVED', 'REJECTED'].includes(_)",
        "enabled": #boolean
      }
      """

    Examples:
      | checkpoint                    | checkpoint_data_update_expression |
      | default paging                | ''                                |
      | missing username should be ok | delete headers['username']        |

  Scenario Outline: List custom payment pages - failed due to invalid headers - <checkpoint>
    * eval <checkpoint_data_update_expression>
    * configure headers = headers
    * path '/ext/v1/receivables/custom-payment-pages'
    * params params
    * method get
    * status 400
    * match response ==
      """
      {
        "type": "invalid_header",
        "code": "invalid_header",
        "message": "#string"
      }
      """

    Examples:
      | checkpoint          | checkpoint_data_update_expression |
      | no required headers | headers = {}                      |
      | unsupported country | headers['country-id'] = 'INVALID' |
      | missing member id   | delete headers['scfs-member-id']  |
      | missing user uuid   | delete headers['scfs-user-uuid']  |
      | missing country id  | delete headers['country-id']      |
