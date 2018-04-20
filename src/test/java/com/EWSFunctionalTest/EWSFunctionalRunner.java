package com.EWSFunctionalTest;

 

import static junit.framework.TestCase.assertTrue;

 

import java.io.File;

import java.util.ArrayList;

import java.util.Collection;

import java.util.List;

 

import org.apache.commons.io.FileUtils;

import org.junit.Test;

 

import com.intuit.karate.cucumber.CucumberRunner;

import com.intuit.karate.cucumber.KarateStats;

 

import cucumber.api.CucumberOptions;

import net.masterthought.cucumber.Configuration;

import net.masterthought.cucumber.ReportBuilder;

 

//@CucumberOptions(tags = {"~@ignore"})

@CucumberOptions(features = "classpath:com/EWSFunctionalTest/feature")

public class EWSFunctionalRunner {

 

               @Test

               public void executeTest() {

                              String karateOutputPath = "target/surefire-reports";

                              KarateStats stats = CucumberRunner.parallel(getClass(), 3, "target/surefire-reports");

                              generateReport(karateOutputPath);

                              assertTrue("scenarios failed", stats.getFailCount() == 0);

               }

 

               private static void generateReport(String karateOutputPath) {

                              Collection<File> jsonFiles = FileUtils.listFiles(new File(karateOutputPath), new String[] { "json" }, true);

                              List<String> jsonPaths = new ArrayList(jsonFiles.size());

                              for (File file : jsonFiles) {

                                             jsonPaths.add(file.getAbsolutePath());

                              }

                              Configuration config = new Configuration(new File("target"), "JD ByRider Automation Execution Results");

                              ReportBuilder reportBuilder = new ReportBuilder(jsonPaths, config);

                              reportBuilder.generateReports();

               }

 

}

 