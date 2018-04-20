
function configurations() {
    var env = karate.env; // get system property 'karate.env'
 
    if(env == null){
        karate.log('Env is not set from maven. So the default environment will be taken')
    }else{
        karate.log('Env is being set from maven as:', env);
    }
 
    karate.configure('connectTimeout', 50000);
    karate.configure('readTimeout', 50000);
 
    switch(env){
        case 'UAT1':
                    var config = {
                        environment: 'The environment is set as UAT1',
                        endPointURI: '',
                        path: ''
                    };
                    break;
                    
        case 'workforce':
             var config = {
                environment: 'Since there is no env specified from maven, default environment is set as QA',
                endPointURI: 'http://aict1lc9a014.app.c9.equifax.com:9184/',
                path: 'autoconnect/acs/submit',
                dbUrl: 'jdbc:oracle:thin:U_ICPS_SAAS_CLIENT/U_icps_saas_client2016@//clu-dx-dal-scan.nonprod.edc.equifax.com:1521/DDXQICSS_DAL_APP',
            };
            break;
            
        default:
                    var config = {
                        environment: 'Since there is no env specified from maven, default environment is set as QA',
                        endPointURI: 'http://AN00611970.eis.equifax.com:8080/',
                        path: 'ic-saas-validation-service/validate',
                         };
 
    }
    
    karate.log("Environment : ", config.environment);
    karate.log("End point URI : ", config.endPointURI);
    karate.log("Path : ", config.path);
 
    return config;
}
 