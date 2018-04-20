@ignore

Feature: IFPD DB event Validation

 

 

  Background:

    * def databaseConnection = Java.type("com.EWSFunctionalTest.testconfigs.DatabaseConnection")

    * def connectionObject = new databaseConnection()

    * def connection = connectionObject.getDatabaseConnection(dbUrl)

    * def databaseRetrieveData = Java.type("com.demotestscenarios.testconfigs.DatabaseRetrieveData")

    * configure afterFeature = function(){ karate.log('end feature') }

 

@ignore

  Scenario: SC-1_Executing a query, converting result as JSON, looping & validating eventypeid has only numbers

    * def correlationId = '591fd8a0-e943-4e6e-ba78-8ee255ab8568'

    * def object = new databaseRetrieveData(connection)

    * def dbResult = object.executeDatabaseQueryUsingPolling("select CORRELATION_ID,EVENTTYPEID,ORGANIZATION_CODE,ORCHESTRATION_CODE,EVENT_STATUS,EVENT_DURATION,EVENTTYPE_NAME,RESPONSE_STATUS,EVENTTYPE,SYSTEMID,BUSINESS_ORCHESTRATION_CODE,COMMUNICATION_TIME,CONSUMER_HOST_NAME,EVENT_MESSAGE,ERROR_MESSAGE from systemevent where CORRELATION_ID='"+correlationId+"' order by EVENTTYPE_NAME")

    * print dbResult

    And match each dbResult contains { EVENTTYPEID: '#number' }

    * def eventTypeName = $dbResult.[*].EVENTTYPE_NAME

    * print eventTypeName

    And match eventTypeName contains only ['Application','Application.IG','Application.SUPPRESSION','Application.VALIDATIONS','Data Access','Orchestration-Executed']

    * def closeConnection = connectionObject.closeDatabaseConnection(connection)