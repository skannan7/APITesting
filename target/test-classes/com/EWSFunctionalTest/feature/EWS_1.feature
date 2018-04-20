Feature: Validation Service

 

  Background:

    * def baseJsonRequest = read('../requesttemplates/validationService.json')

    * def baseData = read('../testdata/validationServiceData.json')

    * def pathIfpd = 'ic-saas-client/api'

    * def endPointURLFPD = 'http://AN00611970.eis.equifax.com:9090/'

    * def endPointUrl = endPointURLFPD + pathIfpd

    * header Content-Type = 'application/vnd.com.equifax.ic.saas.request.v1+json'

    * configure headers = read('../headers/ifpdHeader.json')

   

 


  @regression

  Scenario:  IFPD-7 - Calling client with correct social security number

    * def userInfo = get[0] baseData.testData.Feature6.case1.socialSecurityNumber

    Given url endPointUrl

    And request baseJsonRequest

    * print baseJsonRequest

    * set baseJsonRequest.applicants.primaryConsumer.personalInformation

      | path                 | value    |

      | socialSecurityNumber | userInfo |

    * print baseJsonRequest

    When method post

    Then status 200

    * print response

   

   @regression

  Scenario:  IFPD-8 - Calling client service with correct social security number that return both address type

    * def userInfo = get[0] baseData.testData.Feature6.case7.socialSecurityNumber

    Given url endPointUrl

    And request baseJsonRequest

    * print baseJsonRequest

    * set baseJsonRequest.applicants.primaryConsumer.personalInformation

      | path                 | value    |

      | socialSecurityNumber | userInfo |

    * print baseJsonRequest

    When method post

    Then status 200

    * print response

    * def autoResponseProducts =  $..addressType

    And match autoResponseProducts contains only ["CA","FA"]

@regression

  Scenario: IFPD-9 - Calling client service with correct social security number that return only the address type CA

   * def userInfo = get[0] baseData.testData.Feature6.case9.socialSecurityNumber

    Given url endPointUrl

    And request baseJsonRequest

    * print baseJsonRequest

    * set baseJsonRequest.applicants.primaryConsumer.personalInformation

      | path                 | value    |

      | socialSecurityNumber | userInfo |

    * print baseJsonRequest

    When method post

    Then status 200

    * print response

    * def autoResponseProducts =  $..addressType

    And match autoResponseProducts contains only ["CA"]

   

    @regression

  Scenario:  IFPD-10- Calling client service to validate primary address

    * def userInfo = get[0] baseData.testData.Feature6.case9.socialSecurityNumber

    Given url endPointUrl

    And request baseJsonRequest

    * print baseJsonRequest

    * set baseJsonRequest.applicants.primaryConsumer.personalInformation

      | path                 | value    |

      | socialSecurityNumber | userInfo |

    * print baseJsonRequest

    When method post

    Then status 200

    * print response

    * def autoResponseProducts =  $..addresses[0]..primaryAddress

    And match autoResponseProducts contains  [" 2 SHORT WHARF RD "]

       

    @regression

  Scenario:  IFPD-11- Calling client service to validate primary address of both  CA and FA

    * def userInfo = get[0] baseData.testData.Feature6.case7.socialSecurityNumber

    Given url endPointUrl

    And request baseJsonRequest

    * print baseJsonRequest

    * set baseJsonRequest.applicants.primaryConsumer.personalInformation

      | path                 | value    |

      | socialSecurityNumber | userInfo |

    * print baseJsonRequest

    When method post

    Then status 200

    * print response

    * def autoResponseProducts =  $..addresses[0,1]..primaryAddress

    And match autoResponseProducts contains only ["883 FLUTE WAY","052 H PDEHO VW"]

   

  @regression

  Scenario: IFPD-12 - Calling  validation service with incorrect social security number with digit less than 9

    * def userInfo = get[0] baseData.testData.Feature6.case2.socialSecurityNumber

    Given url endPointUrl

    And request baseJsonRequest

    * print baseJsonRequest

    * set baseJsonRequest.applicants.primaryConsumer.personalInformation

      | path                 | value    |

      | socialSecurityNumber | userInfo |

    * print baseJsonRequest

    When method post

    Then status 400

    * print uploadStatusCode

    * print response

   

    

    @regression

  Scenario:  IFPD-13- Calling client service to validate two types of address are validated.

    * def userInfo = get[0] baseData.testData.Feature6.case8.socialSecurityNumber

    Given url endPointUrl

    And request baseJsonRequest

    * print baseJsonRequest

    * set baseJsonRequest.applicants.primaryConsumer.personalInformation

      | path                 | value    |

      | socialSecurityNumber | userInfo |

    * print baseJsonRequest

    When method post

    Then status 200

    * print response

    * def autoResponseProducts =  $..addressType

    And match autoResponseProducts contains only ["CA","FA"]

   

    

    @ignore

  Scenario:  IFPD-14- Calling client service to get employment information.

    * def userInfo = get[0] baseData.testData.Feature6.case8.socialSecurityNumber

    Given url endPointUrl

    And request baseJsonRequest

    * print baseJsonRequest

    * set baseJsonRequest.applicants.primaryConsumer.personalInformation

      | path                 | value    |

      | socialSecurityNumber | userInfo |

    * print baseJsonRequest

    When method post

    Then status 200

    * print response

    * def autoResponseEmploymentIdentifier =  $..employments..identifier

    And match autoResponseEmploymentIdentifier contains only ["current"]

   * def autoResponseEmploymentEmployerName =  $..employments..employer

    And match autoResponseEmploymentEmployerName contains only ["TEST"]

   

    @regression

  Scenario: IFPD-15 - Calling client service with correct social security number that return ssnVerified

    * def userInfo = get[0] baseData.testData.Feature6.case9.socialSecurityNumber

    Given url endPointUrl

    And request baseJsonRequest

    * print baseJsonRequest

        * set baseJsonRequest.applicants.primaryConsumer.personalInformation

      | path                 | value    |

      | socialSecurityNumber | userInfo |

    * print baseJsonRequest

    When method post

    Then status 200

    * print response

    * def autoResponseProducts =  $..ssnVerified

     And match autoResponseProducts contains only ['N']

   

    @regression

     Scenario: IFPD-15 - Calling client service with correct social security number that return ssnVerified

    * def userInfo = get[0] baseData.testData.Feature6.case8.socialSecurityNumber

    Given url endPointUrl

    And request baseJsonRequest

    * print baseJsonRequest

        * set baseJsonRequest.applicants.primaryConsumer.personalInformation

      | path                 | value    |

      | socialSecurityNumber | userInfo |

    * print baseJsonRequest

    When method post

    Then status 200

    * print response

    * def autoResponseProducts =  $..ssnVerified

     And match autoResponseProducts contains only ['Y']
 
 

    