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

  Scenario: IFPD-1 - Calling IFPD service with correct social security number and header information.

  

    * header Content-Type = 'application/vnd.com.equifax.ic.saas.request.v1+json'

    * def userInfo = get[0] baseData.testData.Feature6.case1.socialSecurityNumber

    Given url endPointUrl

    And request baseJsonRequest

    * print baseJsonRequest

    * set baseJsonRequest.applicants.primaryConsumer.personalInformation

      | path                 | value    |

      | socialSecurityNumber | userInfo |

    * print baseJsonRequest

    When method post

    Then def uploadStatusCode = responseStatus

    * status 200

   

    @regression

  Scenario: IFPD-2 - Calling IFPD service with incorrect Authentication.

     * configure headers = { organizationcode :'EWS',ig-orchestrationcode :'',Authorization :'Basic ZXdzY3N0c3Vz' }

 

    * header Content-Type = 'application/vnd.com.equifax.ic.saas.request.v1+json'

    * def userInfo = get[0] baseData.testData.Feature6.case1.socialSecurityNumber

    Given url endPointUrl

    And request baseJsonRequest

    * print baseJsonRequest

    * set baseJsonRequest.applicants.primaryConsumer.personalInformation

      | path                 | value    |

      | socialSecurityNumber | userInfo |

    * print baseJsonRequest

    When method post

    Then def uploadStatusCode = responseStatus

    * status 401

   

  @regression

  Scenario: IFPD-3 - Calling IFPD service with correct social security number and  incorrect header information-missing ig-orch code.

    * header Content-Type = 'application/vnd.com.equifax.ic.saas.request.v1+json'

    * configure headers = { organizationcode :'EWS',ig-orchestrationcode :'',Authorization :'Basic ZXdzY3N0c3VzZXI6Pz1qOiZ4TUpKTSVnaWV3czIzNA==' }

 

    * def userInfo = get[0] baseData.testData.Feature6.case4.socialSecurityNumber

    Given url endPointUrl

    And request baseJsonRequest

    * print baseJsonRequest

    * set baseJsonRequest.applicants.primaryConsumer.personalInformation

      | path                 | value    |

      | socialSecurityNumber | userInfo |

    * print baseJsonRequest

    When method post

    Then def uploadStatusCode = responseStatus

    * status 400

    * def autoResponseProducts =  $.description

    And match autoResponseProducts == "ig-orchestrationcode is missing in request header"

   

     @regression

     Scenario: IFPD-4 - Calling IFPD service with correct social security number and  incorrect header information-missing organization code.

    * header Content-Type = 'application/vnd.com.equifax.ic.saas.request.v1+json'

    * configure headers = {  organizationcode :'',ig-orchestrationcode :'test50dtec',Authorization :'Basic ZXdzY3N0c3VzZXI6Pz1qOiZ4TUpKTSVnaWV3czIzNA==' }

 

    * def userInfo = get[0] baseData.testData.Feature6.case4.socialSecurityNumber

    Given url endPointUrl

    And request baseJsonRequest

    * print baseJsonRequest

    * set baseJsonRequest.applicants.primaryConsumer.personalInformation

      | path                 | value    |

      | socialSecurityNumber | userInfo |

    * print baseJsonRequest

    When method post

    Then def uploadStatusCode = responseStatus

    * status 400

    * print uploadStatusCode 

    * def autoResponseProducts =  $.description

    And match autoResponseProducts == "organizationcode is missing in request header"

   

    

     @regression

  Scenario: IFPD-5 - Calling IFPD service with correct social security number and  incorrect header information-missing authorization.

    * header Content-Type = 'application/vnd.com.equifax.ic.saas.request.v1+json'

    * configure headers = { organizationcode :'EWS',ig-orchestrationcode :'test50dtec',Authorization :'' }

 

    * def userInfo = get[0] baseData.testData.Feature6.case4.socialSecurityNumber

    Given url endPointUrl

    And request baseJsonRequest

    * print baseJsonRequest

    * set baseJsonRequest.applicants.primaryConsumer.personalInformation

      | path                 | value    |

      | socialSecurityNumber | userInfo |

    * print baseJsonRequest

    When method post

    Then def uploadStatusCode = responseStatus

    * status 401

    * print response

       

     @regression

     Scenario: IFPD-6 - Calling IFPD service with correct social security number and  incorrect content type.

    * header Content-Type = 'application/vnd.com.equifax.ic.saas'

    * configure headers = { organizationcode :'EWS',ig-orchestrationcode :'test50dtec',Authorization :'Basic ZXdzY3N0c3VzZXI6Pz1qOiZ4TUpKTSVnaWV3czIzNA==' }

 

    * def userInfo = get[0] baseData.testData.Feature6.case4.socialSecurityNumber

    Given url endPointUrl

    And request baseJsonRequest

    * print baseJsonRequest

    * set baseJsonRequest.applicants.primaryConsumer.personalInformation

      | path                 | value    |

      | socialSecurityNumber | userInfo |

    * print baseJsonRequest

    When method post

    Then def uploadStatusCode = responseStatus

    * status 415

  

 

